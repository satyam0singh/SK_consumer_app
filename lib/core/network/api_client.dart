import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

/// Custom exception for API errors
class ApiException implements Exception {
  final String message;
  final String code;
  final int statusCode;

  ApiException({
    required this.message,
    required this.code,
    required this.statusCode,
  });

  @override
  String toString() => 'ApiException($statusCode): [$code] $message';
}

/// Centralized API client — all consumer data flows through here.
///
/// Every request includes `Authorization: Bearer <Firebase ID token>`.
class ApiClient {
  // TODO: Replace with your actual Cloud Functions URL after deployment
  static const String baseUrl =
      'https://us-central1-YOUR_PROJECT_ID.cloudfunctions.net';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Get current user's ID token
  Future<String> _getToken() async {
    final user = _auth.currentUser;
    if (user == null) throw ApiException(
      message: 'Not authenticated',
      code: 'UNAUTHORIZED',
      statusCode: 401,
    );
    final token = await user.getIdToken();
    if (token == null) throw ApiException(
      message: 'Failed to get token',
      code: 'UNAUTHORIZED',
      statusCode: 401,
    );
    return token;
  }

  /// Standard auth headers
  Future<Map<String, String>> _headers() async {
    final token = await _getToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };
  }

  /// GET request
  Future<dynamic> get(String endpoint,
      {Map<String, String>? queryParams}) async {
    final uri = Uri.parse('$baseUrl/$endpoint')
        .replace(queryParameters: queryParams);
    final headers = await _headers();

    final response = await http.get(uri, headers: headers);
    return _handleResponse(response);
  }

  /// POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl/$endpoint');
    final headers = await _headers();

    final response = await http.post(
      uri,
      headers: headers,
      body: jsonEncode(body),
    );
    return _handleResponse(response);
  }

  /// Parse response, throw ApiException on non-200
  dynamic _handleResponse(http.Response response) {
    final body = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    throw ApiException(
      message: body['error'] ?? 'Unknown error',
      code: body['code'] ?? 'SERVER_ERROR',
      statusCode: response.statusCode,
    );
  }
}
