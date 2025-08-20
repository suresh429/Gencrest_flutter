import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import '../data/api_service.dart';
import '../pages/roles/mdo/mdo_home_page.dart';
import '../pages/roles/rbh/rbh_home_page.dart';
import '../pages/roles/tsm/tsm_home_page.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final passwordVisible = false.obs;
  final isLoading = false.obs;

  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      debugPrint("❌ Form validation failed");
      return;
    }

    isLoading.value = true;

    try {
      final username = usernameController.text.trim();
      final password = passwordController.text.trim();

      debugPrint("🔑 Attempting login with username: $username");
      debugPrint("🔑 Password: $password");
      debugPrint("🔑 CSRF Token: " + (ApiService.csrfToken ?? "null"));
      debugPrint("🔑 Headers: " + ApiService.headers.toString());

      Response response;
      try {
        response = await ApiService.login(username, password);
      } on DioException catch (e) {
        debugPrint("⚠️ DioException: ${e.response?.data}");
        if (e.response?.statusCode == 403 &&
            e.response?.data != null &&
            e.response?.data['message'] == 'invalid csrf token') {
          debugPrint("🔄 Retrying login with new CSRF token...");
          await ApiService.getCsrfToken();
          response = await ApiService.login(username, password);
        } else {
          rethrow;
        }
      }

      debugPrint("🔑 Login response status: ${response.statusCode}");
      debugPrint("🔑 Login response data: ${response.data}");

      if (response.statusCode == 200) {
        final user = response.data['user'] ?? {};
        final designation = (user['designation'] ?? '').toString().toUpperCase();

        usernameController.clear();
        passwordController.clear();

        // Navigate based on role
        switch (designation) {
          case 'MDO':
            Get.offAll(() => MDOHomePage());
            break;
          case 'TSM':
            Get.offAll(() => TSMHomePage());
            break;
          case 'RBH':
            Get.offAll(() => RBHHomePage());
            break;
          case 'SUPER_ADMIN':
            Get.snackbar("Login Success", "Super Admin logged in",
                backgroundColor: Colors.green.shade100,
                colorText: Colors.black);
            break;
          default:
            Get.snackbar("Login Failed", "Unexpected role: $designation",
                backgroundColor: Colors.red.shade100,
                colorText: Colors.black);
        }
      } else {
        Get.snackbar("Login Failed", "Invalid username or password",
            backgroundColor: Colors.red.shade100,
            colorText: Colors.black);
      }
    } catch (e) {
      debugPrint("⚠️ Error during login: $e");
      if (e is DioException && e.response?.data != null) {
        debugPrint("⚠️ Error response body: ${e.response?.data}");
      }
      Get.snackbar("Login Failed", e.toString(),
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
