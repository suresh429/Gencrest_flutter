import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../data/api_service.dart';
import '../pages/roles/mdo/mdo_home_page.dart';
import '../pages/roles/rbh/rbh_home_page.dart';
import '../pages/roles/tsm/tsm_home_page.dart';
import '../utils/user_local_storage.dart';

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
      debugPrint("Form validation failed");
      return;
    }

    isLoading.value = true;

    try {
      final username = usernameController.text.trim();
      final password = passwordController.text.trim();

      await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
      const token = "dummy_token_123456";

      ApiService.setToken(token);

      // Ensure UserLocalStorage is initialized
      await UserLocalStorage().init();
      // Dummy user data with role
      final role = username.trim().toLowerCase();
      final validRoles = ['mdo', 'tsm', 'rbh'];
      debugPrint("Checking role: $role");
      if (!validRoles.contains(role)) {
        Get.snackbar("Login Failed", "Invalid username or password",
            backgroundColor: Colors.red.shade100, colorText: Colors.black);
        isLoading.value = false;
        return;
      }
      final userData = {
        'username': username,
        'role': role.toUpperCase(),
      };
      debugPrint("User data prepared: $userData");
      await UserLocalStorage().saveUser(userData);
      await UserLocalStorage().saveRole(userData['role']!);

      usernameController.clear();
      passwordController.clear();

      debugPrint("User role before navigation: ${userData['role']}");

      switch (userData['role']) {
        case 'MDO':
          debugPrint("Navigating to MDOHomePage");
          Get.offAll(() => MDOHomePage());
          debugPrint("Navigated to MDOHomePage");
          break;
        case 'TSM':
          debugPrint("Navigating to TSMHomePage");
          Get.offAll(() => TSMHomePage());
          debugPrint("Navigated to TSMHomePage");
          break;
        case 'RBH':
          debugPrint("Navigating to RBHHomePage");
          Get.offAll(() => RBHHomePage());
          debugPrint("Navigated to RBHHomePage");
          break;
        default:
          debugPrint("Unexpected role: ${userData['role']}");
          Get.snackbar("Login Failed", "Unexpected role assignment",
              backgroundColor: Colors.red.shade100, colorText: Colors.black);
          break;
      }
    } catch (e) {
      debugPrint("Error during login: $e");
      Get.snackbar("Login Failed", "Invalid username or password",
          backgroundColor: Colors.red.shade100, colorText: Colors.black);
    } finally {
      isLoading.value = false;
      debugPrint("Login process completed");
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}