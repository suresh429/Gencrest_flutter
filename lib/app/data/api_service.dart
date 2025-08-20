import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
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

  // 🔒 Hardcoded CSRF token for testing
  static String? _csrfToken = "i6DMYFsZ-INs1eeplXN6r4gSzos8P0CdHw98";

  static String? _accessToken;
  static String? _refreshToken;

  /// Initialize service - add cookie manager & load tokens
  static Future<void> init() async {
    _dio.interceptors.add(CookieManager(_cookieJar));

    _accessToken = _storage.getToken();
    _refreshToken = _storage.getRefreshToken();

    if (_accessToken != null) {
      _dio.options.headers['Authorization'] = 'Bearer $_accessToken';
    }

    // ✅ Always set hardcoded CSRF token
    if (_csrfToken != null) {
      _dio.options.headers['x-csrf-token'] = _csrfToken;
    }
  }

  /// Skip fetching CSRF from server (use hardcoded one)
  static Future<String> getCsrfToken() async {
    print("⚠️ Using hardcoded CSRF token: $_csrfToken");
    _dio.options.headers['x-csrf-token'] = _csrfToken;
    return _csrfToken!;
  }

  /// Login with CSRF token
  static Future<Response> login(String identifier, String password) async {
    // if (_csrfToken == null) {
    //   await getCsrfToken();
    // }

    final response = await _dio.post(
      "auth/login/password",
      data: {"identifier": identifier, "password": password},
      options: Options(headers: {
        "x-csrf-token": "i6DMYFsZ-INs1eeplXN6r4gSzos8P0CdHw98",
        "Accept": "application/json",
      }),
    );

    if (response.statusCode == 200) {
      _accessToken = response.data['access_token'];
      _refreshToken = response.data['refresh_token'];

      if (_accessToken != null) {
        await _storage.saveToken(_accessToken!, _refreshToken ?? "");
        setToken(_accessToken!);
      }

      // Save user data
      if (response.data['user'] != null) {
        await _storage.saveUser(Map<String, dynamic>.from(response.data['user']));
        if (response.data['user']['designation'] != null) {
          await _storage.saveRole(response.data['user']['designation']);
        }
      }
    }

    return response;
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
