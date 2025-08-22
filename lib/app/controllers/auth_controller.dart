import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import '../data/api_service.dart';
import '../pages/roles/mdo/mdo_home_page.dart';
import '../pages/roles/rbh/rbh_home_page.dart';
import '../pages/roles/tsm/tsm_home_page.dart';
import '../pages/login_page.dart';
import '../utils/user_local_storage.dart';

class AuthController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final UserLocalStorage _storage = UserLocalStorage();

  final passwordVisible = false.obs;
  final isLoading = false.obs;
  final isLoggedIn = false.obs;
  final userData = Rxn<Map<String, dynamic>>();
  final userRole = RxString('');

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  void checkLoginStatus() {
    if (_storage.isLoggedIn()) {
      userData.value = _storage.getUser();
      userRole.value = _storage.getRole() ?? '';
      isLoggedIn.value = true;
      // Auto-navigate based on stored role
      navigateBasedOnRole(userRole.value);
    }
  }

  void navigateBasedOnRole(String designation) {
    switch (designation.toLowerCase()) {
      case 'mdo':
        Get.offAll(() => MDOHomePage());
        break;
      case 'tsm':
        Get.offAll(() => TSMHomePage());
        break;
      case 'rbh':
        Get.offAll(() => RBHHomePage());
        break;
      case 'super_admin':
        Get.offAll(() => MDOHomePage());
        Get.snackbar(
          "Welcome Back",
          "Logged in as Super Admin",
          backgroundColor: Colors.green.shade100,
          colorText: Colors.black,
          duration: const Duration(seconds: 2)
        );
        break;
    }
  }

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

      if (response.statusCode == 200 || response.statusCode == 201) {
        final user = response.data['user'] ?? {};
        final designation = (user['designation'] ?? '').toString().toLowerCase();

        // Store user data
        _storage.saveUser(response.data['user']);
        _storage.saveRole(designation);

        usernameController.clear();
        passwordController.clear();

        isLoggedIn.value = true;
        userData.value = user;
        userRole.value = designation;

        // Navigate based on role
        switch (designation) {
          case 'mdo':
            Get.offAll(() => MDOHomePage());
            break;
          case 'tsm':
            Get.offAll(() => TSMHomePage());
            break;
          case 'rbh':
            Get.offAll(() => RBHHomePage());
            break;
          case 'super_admin':
            Get.offAll(() => MDOHomePage()); // Navigate super admin to MDO page for now
            Get.snackbar(
              "Login Success",
              "Welcome Super Admin",
              backgroundColor: Colors.green.shade100,
              colorText: Colors.black,
              duration: const Duration(seconds: 2)
            );
            break;
          default:
            Get.snackbar(
              "Login Failed",
              "Unexpected role: $designation",
              backgroundColor: Colors.red.shade100,
              colorText: Colors.black
            );
        }
      } else {
        Get.snackbar(
          "Login Failed",
          "Invalid username or password",
          backgroundColor: Colors.red.shade100,
          colorText: Colors.black
        );
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

  Future<void> logout() async {
    await _storage.clearAll();
    isLoggedIn.value = false;
    userData.value = null;
    userRole.value = '';
    Get.offAll(() => const LoginPage());
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
