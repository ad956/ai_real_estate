import 'package:dio/dio.dart';
import '../core/utils/logger.dart';
import '../core/utils/connectivity_service.dart';
import '../core/constants/mock_data.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: MockData.USE_REAL_API ? 'https://aiinrealestate.in/api/' : 'https://jsonplaceholder.typicode.com/',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
  ));

  static Future<Map<String, dynamic>> getProperties() async {
    if (!MockData.USE_REAL_API) {
      Logger.logInfo('Using mock data for properties');
      await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
      return MockData.PROPERTIES_RESPONSE;
    }
    
    if (!await ConnectivityService.hasInternetConnection()) {
      Logger.logNetworkError('properties', 'No internet connection');
      throw Exception('No internet connection. Please check your network.');
    }
    
    try {
      Logger.logInfo('Fetching properties from real API');
      final response = await _dio.get('property');
      Logger.logInfo('Properties fetched successfully');
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        Logger.logError('Server error for properties', e);
        throw Exception('Server temporarily unavailable. Please try again later.');
      }
      Logger.logNetworkError('properties', e);
      throw Exception('Failed to fetch properties. Check your internet connection.');
    } catch (e) {
      Logger.logError('Unexpected error fetching properties', e);
      throw Exception('Something went wrong. Please try again.');
    }
  }

  static Future<Map<String, dynamic>> getCategoryProperties() async {
    if (!MockData.USE_REAL_API) {
      Logger.logInfo('Using mock data for category properties');
      await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
      return MockData.CATEGORY_PROPERTIES_RESPONSE;
    }
    
    if (!await ConnectivityService.hasInternetConnection()) {
      Logger.logNetworkError('category_properties', 'No internet connection');
      throw Exception('No internet connection. Please check your network.');
    }
    
    try {
      Logger.logInfo('Fetching category properties from real API');
      final response = await _dio.get('category_property');
      Logger.logInfo('Category properties fetched successfully');
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        Logger.logError('Server error for category properties', e);
        throw Exception('Server temporarily unavailable. Please try again later.');
      }
      Logger.logNetworkError('category_properties', e);
      throw Exception('Failed to fetch category properties. Check your internet connection.');
    } catch (e) {
      Logger.logError('Unexpected error fetching category properties', e);
      throw Exception('Something went wrong. Please try again.');
    }
  }

  static Future<Map<String, dynamic>> getWebStories() async {
    if (!MockData.USE_REAL_API) {
      Logger.logInfo('Using mock data for web stories');
      await Future.delayed(Duration(milliseconds: 500)); // Simulate network delay
      return MockData.WEBSTORIES_RESPONSE;
    }
    
    if (!await ConnectivityService.hasInternetConnection()) {
      Logger.logNetworkError('webstories', 'No internet connection');
      throw Exception('No internet connection. Please check your network.');
    }
    
    try {
      Logger.logInfo('Fetching web stories from real API');
      final response = await _dio.get('webstories');
      Logger.logInfo('Web stories fetched successfully');
      return response.data;
    } on DioException catch (e) {
      if (e.response?.statusCode == 500) {
        Logger.logError('Server error for web stories', e);
        throw Exception('Server temporarily unavailable. Please try again later.');
      }
      Logger.logNetworkError('webstories', e);
      throw Exception('Failed to fetch web stories. Check your internet connection.');
    } catch (e) {
      Logger.logError('Unexpected error fetching web stories', e);
      throw Exception('Something went wrong. Please try again.');
    }
  }
}