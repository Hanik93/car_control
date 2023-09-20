import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiUrl;

  ApiService(this.apiUrl);

  Future<http.Response> sendRequest(String endpoint, [dynamic value]) async {
    final url = Uri.parse('$apiUrl/$endpoint');
    Map<String, dynamic>? body;
    if (value != null) {
      body = {'value': value};
    }
    try {
      final response = await http.post(url, body: json.encode(body), headers: {'Content-Type': 'application/json'});
      return response;
    } catch (error) {
      print('Error sending command: $error');
      throw error;
    }
  }

  Future<http.Response> fetchImageStream() async {
    final url = Uri.parse('$apiUrl/cam');
    try {
      final response = await http.get(url);
      return response;
    } catch (error) {
      print('Failed to get image from server');
      throw error;
    }
  }
}
