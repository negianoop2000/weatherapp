import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String> generateWeatherAlert(String weatherDescription) async {
  const apiKey = 'YOUR_OPENAI_API_KEY';
  const endpoint = 'https://api.openai.com/v1/completions';

  final response = await http.post(
    Uri.parse(endpoint),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'model': 'gpt-4',
      'prompt': 'Create a weather alert for $weatherDescription',
      'max_tokens': 50
    }),
  );

  final responseData = json.decode(response.body);
  return responseData['choices'][0]['text'].trim();
}