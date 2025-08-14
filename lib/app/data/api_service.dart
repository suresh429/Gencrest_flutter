import 'package:dio/dio.dart';
import 'local_storage.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://yourapi.com/api/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  static void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static Future<Response> get(String path,
      {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(path, queryParameters: query);
      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Response> post(String path, dynamic data) async {
    try {
      final response = await _dio.post(path, data: data);
      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Response> put(String path, dynamic data) async {
    try {
      final response = await _dio.put(path, data: data);
      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  static Future<Response> delete(String path) async {
    try {
      final response = await _dio.delete(path);
      return response;
    } on DioError catch (e) {
      throw _handleError(e);
    }
  }

  static String _handleError(DioError error) {
    if (error.response != null) {
      return 'Error ${error.response?.statusCode}: ${error.response?.data}';
    } else {
      return 'Network error: ${error.message}';
    }
  }
}

