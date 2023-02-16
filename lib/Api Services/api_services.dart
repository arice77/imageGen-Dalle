import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiServices {
  Future<List<dynamic>> imageCall(String request) async {
    const apiKey = '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';
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/images/generations'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'prompt': request,
        'n': 1,
        'size': '1024x1024',
      }),
    );
    if (response.statusCode == 200) {
      final data = await jsonDecode(response.body)['data'];

      return data;
    } else {
      return [];
    }
  }
}
