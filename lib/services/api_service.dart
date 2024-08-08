// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import '../environment.dart';

// class ApiService {
//   final String baseUrl;
//   final storage = const FlutterSecureStorage();

//   ApiService({required this.baseUrl});

//   Future<String?> getApiKey(String serviceName) async {
//     final apiKey = await Environment.getApiKey(serviceName);
//     return apiKey;
//   }

//   Future<http.Response> getRequest(String endpoint,
//       {Map<String, String>? params, Map<String, String>? headers}) async {
//     // Ensure no double slashes in the URL
//     String url = baseUrl.endsWith('/')
//         ? baseUrl.substring(0, baseUrl.length - 1)
//         : baseUrl;
//     endpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;

//     Uri uri = Uri.parse('$url/$endpoint');
//     if (params != null) {
//       uri = uri.replace(queryParameters: params);
//     }

//     print('Request URI: $uri'); // Debugging
//     print('Request headers: $headers'); // Debugging

//     final response = await http.get(uri, headers: headers);

//     return _handleResponse(response);
//   }

//   Future<http.Response> postRequest(String endpoint, Map<String, dynamic> body,
//       {Map<String, String>? headers}) async {
//     // Ensure no double slashes in the URL
//     String url = baseUrl.endsWith('/')
//         ? baseUrl.substring(0, baseUrl.length - 1)
//         : baseUrl;
//     endpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;

//     Uri uri = Uri.parse('$url/$endpoint');

//     print('Request URI: $uri'); // Debugging
//     print('Request headers: $headers'); // Debugging

//     final response = await http.post(
//       uri,
//       headers: headers,
//       body: json.encode(body),
//     );

//     return _handleResponse(response);
//   }

//   http.Response _handleResponse(http.Response response) {
//     if (response.statusCode >= 200 && response.statusCode < 300) {
//       return response;
//     } else {
//       print('Failed response status code: ${response.statusCode}'); // Debugging
//       throw Exception('Failed to load data: ${response.statusCode}');
//     }
//   }
// }

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../environment.dart';

class ApiService {
  final String baseUrl;
  final storage = const FlutterSecureStorage();

  ApiService({required this.baseUrl});

  Future<String?> getApiKey(String serviceName) async {
    final apiKey = await Environment.getApiKey(serviceName);
    return apiKey;
  }

  Future<http.Response> getRequest(String endpoint,
      {Map<String, String>? params,
      Map<String, String>? headers,
      String? customBaseUrl}) async {
    // Ensure no double slashes in the URL
    String url = (customBaseUrl ?? baseUrl).endsWith('/')
        ? (customBaseUrl ?? baseUrl)
            .substring(0, (customBaseUrl ?? baseUrl).length - 1)
        : (customBaseUrl ?? baseUrl);
    endpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;

    Uri uri = Uri.parse('$url/$endpoint');
    if (params != null) {
      uri = uri.replace(queryParameters: params);
    }

    print('Request URI: $uri');
    print('Request headers: $headers');

    final response = await http.get(uri, headers: headers);

    return _handleResponse(response);
  }

  Future<http.Response> postRequest(String endpoint, Map<String, dynamic> body,
      {Map<String, String>? headers, String? customBaseUrl}) async {
    // Ensure no double slashes in the URL
    String url = (customBaseUrl ?? baseUrl).endsWith('/')
        ? (customBaseUrl ?? baseUrl)
            .substring(0, (customBaseUrl ?? baseUrl).length - 1)
        : (customBaseUrl ?? baseUrl);
    endpoint = endpoint.startsWith('/') ? endpoint.substring(1) : endpoint;

    Uri uri = Uri.parse('$url/$endpoint');

    print('Request URI: $uri');
    print('Request headers: $headers');
    print('Request body: ${json.encode(body)}');

    final response = await http.post(
      uri,
      headers: headers,
      body: json.encode(body),
    );

    return _handleResponse(response);
  }

  http.Response _handleResponse(http.Response response) {
    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response;
    } else {
      throw Exception(
          'Failed to load data: ${response.statusCode}, ${response.body}');
    }
  }
}
