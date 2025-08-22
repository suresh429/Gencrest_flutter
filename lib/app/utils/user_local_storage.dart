import 'package:hive/hive.dart';

class UserLocalStorage {
  static final UserLocalStorage _instance = UserLocalStorage._internal();
  late Box _box;
  static const String _tokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';
  static const String _roleKey = 'user_role';
  static const String _isLoggedInKey = 'is_logged_in';

  factory UserLocalStorage() {
    return _instance;
  }

  UserLocalStorage._internal();

  Future<void> init() async {
    try {
      _box = await Hive.openBox('userBox');
    } catch (e) {
      // If box is already open, get the existing box
      _box = Hive.box('userBox');
    }
  }

  // Token Management
  Future<void> saveToken(String token, String refreshToken) async {
    await _box.put(_tokenKey, token);
    await _box.put(_refreshTokenKey, refreshToken);
    await _box.put(_isLoggedInKey, true);
  }

  String? getToken() {
    return _box.get(_tokenKey);
  }

  String? getRefreshToken() {
    return _box.get(_refreshTokenKey);
  }

  // User Data Management
  Future<void> saveUser(Map<String, dynamic> userData) async {
    await _box.put(_userKey, userData);
  }

  Map<String, dynamic>? getUser() {
    final userData = _box.get(_userKey);
    if (userData != null) {
      return Map<String, dynamic>.from(userData);
    }
    return null;
  }

  // Role Management
  Future<void> saveRole(String role) async {
    await _box.put(_roleKey, role);
  }

  String? getRole() {
    return _box.get(_roleKey);
  }

  // Login State
  bool isLoggedIn() {
    return _box.get(_isLoggedInKey, defaultValue: false);
  }

  // Clear all data on logout
  Future<void> clearAll() async {
    await _box.clear();
  }

  // Get specific user field
  T? getUserField<T>(String field) {
    final userData = getUser();
    if (userData != null && userData.containsKey(field)) {
      return userData[field] as T;
    }
    return null;
  }

  // Update specific user field
  Future<void> updateUserField(String field, dynamic value) async {
    final userData = getUser() ?? {};
    userData[field] = value;
    await saveUser(userData);
  }
}
