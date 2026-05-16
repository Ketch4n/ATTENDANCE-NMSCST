import 'dart:async';
import 'dart:convert';
import 'package:attendance_nmscst/src/data/mock/mock_data.dart';
import 'package:attendance_nmscst/src/data/server/url.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const Duration _connectionTimeout = Duration(seconds: 5);

  /// Check if the API server is reachable
  static Future<bool> checkApiConnectivity() async {
    try {
      final response = await http
          .get(
            Uri.parse('${Servername.host}health'),
          )
          .timeout(_connectionTimeout);

      return response.statusCode == 200;
    } catch (e) {
      // Try a simple ping to the base URL
      try {
        final response = await http
            .get(
              Uri.parse(Servername.host),
            )
            .timeout(_connectionTimeout);

        return response.statusCode < 500;
      } catch (e) {
        return false;
      }
    }
  }

  /// Generic GET request with demo mode support
  static Future<Map<String, dynamic>> get(
    String endpoint, {
    bool isDemoMode = false,
  }) async {
    if (isDemoMode) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 500));
      return _getMockData(endpoint);
    }

    try {
      final response = await http
          .get(
            Uri.parse('${Servername.host}$endpoint'),
          )
          .timeout(_connectionTimeout);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to load data. HTTP status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  /// Generic POST request with demo mode support
  static Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body, {
    bool isDemoMode = false,
  }) async {
    if (isDemoMode) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      return MockData.postSuccessResponse;
    }

    try {
      final response = await http
          .post(
            Uri.parse('${Servername.host}$endpoint'),
            body: body,
          )
          .timeout(_connectionTimeout);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to post data. HTTP status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  /// Generic DELETE request with demo mode support
  static Future<Map<String, dynamic>> delete(
    String endpoint, {
    bool isDemoMode = false,
  }) async {
    if (isDemoMode) {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 600));
      return MockData.postSuccessResponse;
    }

    try {
      final response = await http
          .delete(
            Uri.parse('${Servername.host}$endpoint'),
          )
          .timeout(_connectionTimeout);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to delete data. HTTP status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error occurred: $e');
    }
  }

  /// Get mock data based on endpoint
  static Map<String, dynamic> _getMockData(String endpoint) {
    if (endpoint.contains('establishment')) {
      return MockData.establishmentResponse;
    } else if (endpoint.contains('announcement')) {
      return MockData.announcementResponse;
    } else {
      return MockData.errorResponse;
    }
  }
}
