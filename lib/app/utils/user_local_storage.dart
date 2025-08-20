import 'package:hive/hive.dart';

class UserLocalStorage {
  static final UserLocalStorage _instance = UserLocalStorage._internal();
  factory UserLocalStorage() => _instance;
  UserLocalStorage._internal();

  late Box userBox;

  Future<void> init() async {
    userBox = await Hive.openBox('userBox');
  }

  Future<void> saveUser(Map<String, dynamic> userData) async {
    await userBox.put('user', userData);
  }

  Map<String, dynamic>? getUser() {
    final data = userBox.get('user');
    return data != null ? Map<String, dynamic>.from(data) : null;
  }

  Future<void> saveRole(String role) async {
    await userBox.put('role', role);
  }

  String? getRole() => userBox.get('role') as String?;

  Future<void> saveToken(String token, String refreshToken) async {
    await userBox.put('accessToken', token);
    await userBox.put('refreshToken', refreshToken);
  }

  String? getToken() => userBox.get('accessToken') as String?;
  String? getRefreshToken() => userBox.get('refreshToken') as String?;

  Future<void> saveCsrfToken(String csrfToken) async {
    await userBox.put('csrfToken', csrfToken);
  }

  String? getCsrfToken() => userBox.get('csrfToken') as String?;

  Future<void> clearUser() async {
    await userBox.clear();
  }
}
