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
    if (data is Map<String, dynamic>) {
      return data;
    }
    return null;
  }

  Future<void> saveRole(String role) async {
    await userBox.put('role', role);
  }

  String? getRole() {
    return userBox.get('role') as String?;
  }

  Future<void> clearUser() async {
    await userBox.delete('user');
    await userBox.delete('role');
  }
}

