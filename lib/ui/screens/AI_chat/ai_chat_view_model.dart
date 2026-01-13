import 'package:flutter/material.dart';
import 'package:fusion_festa/services/ai_service.dart';
import 'package:stacked/stacked.dart';

class AiChatViewModel extends BaseViewModel {
  final AiService _aiService = AiService();

  TextEditingController messageController = TextEditingController();

  List<Map<String, String>> messages = [];

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messages.add({"role": "user", "text": text});
    notifyListeners();

    messageController.clear();

    final reply = await _aiService.sendMessage(text);

    messages.add({"role": "bot", "text": reply});
    notifyListeners();
  }
}
