import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import '../utils/user_local_storage.dart';

class ApiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://gencrest.effybiz.com/api/v1/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  static final UserLocalStorage _storage = UserLocalStorage();
  static final CookieJar _cookieJar = CookieJar();

  static String? _csrfToken;
  static String? _accessToken;
  static String? _refreshToken;

  /// Initialize service - add cookie manager & load tokens
  static Future<void> init() async {
    _dio.interceptors.add(CookieManager(_cookieJar));
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (e, handler) async {
          if (e.response?.statusCode == 403 &&
              e.response?.data['message'] == 'invalid csrf token') {
            try {
              await getCsrfToken();
              // Retry the original request with new CSRF token
              final opts = Options(
                method: e.requestOptions.method,
                headers: e.requestOptions.headers,
              );
              final response = await _dio.request(
                e.requestOptions.path,
                options: opts,
                data: e.requestOptions.data,
              );
              return handler.resolve(response);
            } catch (retryError) {
              return handler.next(e);
            }
          }
          return handler.next(e);
        },
      ),
    );

    _accessToken = _storage.getToken();
    _refreshToken = _storage.getRefreshToken();

    if (_accessToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_accessToken';
    }

    // Get initial CSRF token
    await getCsrfToken();
  }

  /// Get CSRF token from server
  static Future<String> getCsrfToken() async {
    try {
      final response = await _dio.get('auth/csrf');
      _csrfToken = response.data['csrfToken'];
      if (_csrfToken != null) {
        _dio.options.headers['x-csrf-token'] = _csrfToken;
      }
      return _csrfToken!;
    } catch (e) {
      debugPrint('Error getting CSRF token: $e');
      rethrow;
    }
  }

  /// Login with credentials
  static Future<Response> login(String identifier, String password) async {
    if (_csrfToken == null) {
      await getCsrfToken();
    }

    try {
      final response = await _dio.post(
        "auth/login/password",
        data: {"identifier": identifier, "password": password},
        options: Options(
          headers: {
            'x-csrf-token': _csrfToken,
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _accessToken = response.data['access_token'];
        _refreshToken = response.data['refresh_token'];

        if (_accessToken != null) {
          await _storage.saveToken(_accessToken!, _refreshToken ?? "");
          setToken(_accessToken!);
        }

        // Save complete user data
        if (response.data['user'] != null) {
          final userData = Map<String, dynamic>.from(response.data['user']);
          await _storage.saveUser(userData);

          if (userData['designation'] != null) {
            await _storage.saveRole(userData['designation'].toString());
          }
        }
      }

      return response;
    } catch (e) {
      debugPrint('Login error: $e');
      rethrow;
    }
  }

  /// Save access token for future requests
  static void setToken(String token) {
    _accessToken = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  /// Refresh token
  static Future<void> refreshAccessToken() async {
    if (_refreshToken == null) throw Exception("No refresh token found");

    final response = await _dio.post("auth/refresh", data: {
      "refresh_token": _refreshToken,
    });

    if (response.statusCode == 200) {
      _accessToken = response.data['access_token'];
      _refreshToken = response.data['refresh_token'];

      if (_accessToken != null) {
        await _storage.saveToken(_accessToken!, _refreshToken ?? "");
        setToken(_accessToken!);
      }
    }
  }

  /// Generic GET
  static Future<Response> get(String path,
      {Map<String, dynamic>? query}) async {
    return await _dio.get(path, queryParameters: query);
  }

  /// Generic POST
  static Future<Response> post(String path, dynamic data) async {
    return await _dio.post(path, data: data);
  }

  /// PUT
  static Future<Response> put(String path, dynamic data) async {
    return await _dio.put(path, data: data);
  }

  /// DELETE
  static Future<Response> delete(String path) async {
    return await _dio.delete(path);
  }

  static String? get csrfToken => _csrfToken;
  static Map<String, dynamic> get headers =>
      Map<String, dynamic>.from(_dio.options.headers);
}
