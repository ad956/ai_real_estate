import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: 'https://aiinrealestate.in/api/',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  ));

  static Future<Map<String, dynamic>> getProperties() async {
    try {
      final response = await _dio.get('property');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch properties: $e');
    }
  }

  static Future<Map<String, dynamic>> getCategoryProperties() async {
    try {
      final response = await _dio.get('category_property');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch category properties: $e');
    }
  }

  static Future<Map<String, dynamic>> getWebStories() async {
    try {
      final response = await _dio.get('webstories');
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch web stories: $e');
    }
  }
}