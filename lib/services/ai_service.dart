import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class AiService {
  static final String _apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';

  final GenerativeModel model = GenerativeModel(
    model: 'gemini-2.5-flash',
    apiKey: _apiKey,
  );

  Future<String> sendMessage(String message) async {
    try {
      final response = await model.generateContent([Content.text(message)]);
      return response.text ?? "No response from AI";
    } catch (e) {
      return "Error: $e";
    }
  }
}
