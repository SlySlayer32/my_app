import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/core/config/environment_config.dart';
import 'package:my_app/core/utils/app_logger.dart';
import 'package:get_it/get_it.dart';

/// Http client that's configured based on the current environment
class ApiClient {
  ApiClient({http.Client? client})
      : _config = GetIt.instance<EnvironmentConfig>(),
        _client = client ?? http.Client();
  final EnvironmentConfig _config;
  final http.Client _client;

  static const String _tag = 'ApiClient';

  /// Base URL from environment config
  String get baseUrl => _config.apiBaseUrl;

  /// Performs a GET request
  Future<dynamic> get(String endpoint) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    AppLogger.d(_tag, 'GET request to: $url');

    try {
      final response = await _client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      return _processResponse(response);
    } catch (e, stackTrace) {
      AppLogger.e(_tag, 'Error during GET request: $e', stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Performs a POST request
  Future<dynamic> post(String endpoint, {Map<String, dynamic>? body}) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    AppLogger.d(_tag, 'POST request to: $url');
    if (_config.enableLogging) {
      AppLogger.d(_tag, 'Request body: $body');
    }

    try {
      final response = await _client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: body != null ? jsonEncode(body) : null,
      );

      return _processResponse(response);
    } catch (e, stackTrace) {
      AppLogger.e(_tag, 'Error during POST request: $e',
          stackTrace: stackTrace);
      rethrow;
    }
  }

  /// Process the HTTP response
  dynamic _processResponse(http.Response response) {
    if (_config.enableLogging) {
      AppLogger.d(_tag, 'Response status: ${response.statusCode}');
      AppLogger.d(_tag, 'Response body: ${response.body}');
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) return null;
      return jsonDecode(response.body);
    } else {
      final error = 'Request failed with status: ${response.statusCode}';
      AppLogger.e(_tag, error);
      throw Exception(error);
    }
  }

  /// Closes the client when no longer needed
  void dispose() {
    _client.close();
  }
}
