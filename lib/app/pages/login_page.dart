import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'assets/images/gen_logo.png',
                  height: 100,
                  width: 100,
                ),
                const SizedBox(height: 16),
                Center(child: Text('Welcome to Gencrest', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18))),
                Center(
                  child: Text(
                    'Login to Your Account',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: controller.usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter Email' : null,
                ),
                const SizedBox(height: 16),
                Obx(() => TextFormField(
                  controller: controller.passwordController,
                  obscureText: !controller.passwordVisible.value,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: IconButton(
                      icon: Icon(controller.passwordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                  validator: (value) =>
                  value!.isEmpty ? 'Please enter password' : null,
                )),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Forgot password?',
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey),
                  ),
                ),

                const SizedBox(height: 15),
                Obx(() => ElevatedButton(
                  onPressed: controller.isLoading.value ? null : controller.login,
                  child: controller.isLoading.value
                      ? const SizedBox(
                    width: 20, // Constrain width
                    height: 20, // Constrain height
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                      : const Text("Login"),
                )),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
