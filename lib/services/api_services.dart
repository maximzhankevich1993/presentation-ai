import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/presentation.dart';

class ApiService {
  static const String _baseUrl = 'https://api.deepseek.com/v1';
  static const String _apiKey = 'YOUR_DEEPSEEK_API_KEY'; // Замени на свой
  
  static final Dio _dio = Dio(BaseOptions(
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $_apiKey',
    },
  ));

  static Future<Presentation> generatePresentation(String topic, {int maxSlides = 10}) async {
    try {
      final prompt = _buildPrompt(topic, maxSlides);
      
      final response = await _dio.post(
        '$_baseUrl/chat/completions',
        data: jsonEncode({
          'model': 'deepseek-chat',
          'messages': [
            {'role': 'system', 'content': _systemPrompt()},
            {'role': 'user', 'content': prompt}
          ],
          'temperature': 0.7,
          'max_tokens': 2000,
          'response_format': {'type': 'json_object'}
        }),
      );
      
      if (response.statusCode == 200) {
        final data = response.data;
        final content = data['choices'][0]['message']['content'];
        final json = jsonDecode(content);
        return Presentation.fromDeepSeekJson(json);
      } else {
        throw Exception('Ошибка сервера: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Ошибка сети: ${e.message}');
    }
  }

  static Future<String> improveText(String text) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/chat/completions',
        data: jsonEncode({
          'model': 'deepseek-chat',
          'messages': [
            {'role': 'system', 'content': 'Ты — профессиональный редактор. Улучши текст, сделав его более чётким и профессиональным. Ответь только улучшенным текстом.'},
            {'role': 'user', 'content': text}
          ],
          'temperature': 0.5,
          'max_tokens': 500,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = response.data;
        return data['choices'][0]['message']['content'].trim();
      }
      throw Exception('Ошибка сервера');
    } catch (e) {
      throw Exception('Ошибка улучшения текста');
    }
  }

  static String _systemPrompt() {
    return '''Ты — эксперт по созданию презентаций. Создай структуру презентации в формате JSON.

Правила:
1. Каждый слайд имеет заголовок
2. Содержание — 3-5 ключевых пунктов
3. Для каждого слайда укажи ключевые слова для поиска картинки (на английском)
4. Слайды должны быть логически связаны

Формат ответа:
{
  "title": "Заголовок презентации",
  "slides": [
    {
      "title": "Заголовок слайда",
      "subtitle": "Подзаголовок",
      "content": ["Пункт 1", "Пункт 2", "Пункт 3"],
      "image_keywords": "keywords for image search"
    }
  ]
}''';
  }

  static String _buildPrompt(String topic, int maxSlides) {
    return '''Создай структуру презентации на тему: "$topic"

Требования:
- Количество слайдов: ровно $maxSlides
- Первый слайд: заголовок и введение
- Последний слайд: заключение
- Для каждого слайда укажи ключевые слова для поиска картинки на английском''';
  }
}