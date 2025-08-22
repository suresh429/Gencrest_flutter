import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:get/get.dart';
import 'app/bindings/initial_binding.dart';
import 'app/data/api_service.dart';
import 'app/pages/login_page.dart';
import 'app/utils/colors.dart';
import 'app/utils/offline_sync_manager.dart';
import 'app/utils/user_local_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and open all required boxes
  await Hive.initFlutter();

  // Open all required boxes first
  await Future.wait([
    Hive.openBox('userBox'),
    Hive.openBox('offlineBox'),
  ]);

  // Initialize user storage before API service
  final userStorage = UserLocalStorage();
  await userStorage.init();

  // Initialize API service after storage is ready
  await ApiService.init();

  // Initialize offline sync last
  await OfflineSyncManager().init();

  // System UI configuration
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
  ));

  FlutterNativeSplash.preserve(
    widgetsBinding: WidgetsFlutterBinding.ensureInitialized(),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Minimal App',
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.scaffoldBgColor,
        navigationBarTheme: NavigationBarThemeData(
          labelTextStyle: WidgetStateProperty.all(
            const TextStyle(
              fontSize: 10, // smaller font for labels
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderColor),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.primaryColor, width: 2),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.errorColor),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.errorColor, width: 2),
          ),
          labelStyle: const TextStyle(color: AppColors.greyColor),
          floatingLabelStyle: const TextStyle(color: AppColors.primaryColor),
          errorStyle: const TextStyle(color: AppColors.errorColor),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
            side: const BorderSide(color: AppColors.greyColor, width: 1),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            textStyle: const TextStyle(fontSize: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
      home: const SplashScreenRemover(),
    );
  }
}

class SplashScreenRemover extends StatefulWidget {
  const SplashScreenRemover({super.key});

  @override
  State<SplashScreenRemover> createState() => _SplashScreenRemoverState();
}

class _SplashScreenRemoverState extends State<SplashScreenRemover> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 400), () {
      FlutterNativeSplash.remove();
      Get.offAll(() => const LoginPage());
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("Welcome", style: TextStyle(fontSize: 24))),
    );
  }
}
