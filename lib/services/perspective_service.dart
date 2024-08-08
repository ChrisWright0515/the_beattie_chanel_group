import 'api_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PerspectiveApiService {
  final ApiService apiService;
  final String baseUrl =
      'https://commentanalyzer.googleapis.com/v1alpha1/comments:analyze';

  PerspectiveApiService({required this.apiService});

  Future<Map<String, dynamic>> analyzeComment(String comment) async {
    final apiKey = await apiService.getApiKey('GOOGLE_MAP_API_KEY');
    if (apiKey == null) {
      throw Exception('API key not found');
    }

    final Map<String, dynamic> body = {
      'comment': {'text': comment},
      'requestedAttributes': {'TOXICITY': {}},
      'doNotStore': true, // Optional flag to not store the comments
      'languages': ['en'] // Specify the language as English
    };

    final headers = {
      'Content-Type': 'application/json',
    };

    final Uri uri = Uri.parse('$baseUrl?key=$apiKey');

    print('Request URI: $uri');
    print('Request headers: $headers');
    print('Request body: ${json.encode(body)}');

    try {
      final response =
          await http.post(uri, headers: headers, body: json.encode(body));

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception(
            'Failed to analyze comment: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }
}
