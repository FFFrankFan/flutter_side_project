import 'dart:convert';
import 'package:flutter_project/constant.dart';
import 'package:http/http.dart' as http;

class OpenAIService {

  OpenAIService();

  Future<String> getResponse(String prompt) async {
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Constant.OPEN_AI_KEY}',
    };
    final body = jsonEncode({
      'model': 'gpt-4o',
      'messages': [
        {'role': 'user', 'content': prompt},
      ],
      'max_tokens': 800,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final content = data['choices'][0]['message']['content'];
      print('content: $content');
      return content;
    } else {
      throw Exception('Failed to load response');
    }
  }
}