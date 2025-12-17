// lib/ui/screens/helpSupport/helpsupport_viewmodel.dart
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpsupportViewmodel extends BaseViewModel {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController = TextEditingController();

  bool isSending = false;

  // WhatsApp number and email
  final String supportPhone = '7994766865';
  final String supportEmail = 'sajadhi791@gmail.com';

  Future<void> onFaqTap() async {
    // TODO: open FAQ page if you have one
  }

  Future<void> onContactEmailTap() async {
    final uri = Uri(
      scheme: 'mailto',
      path: supportEmail,
      queryParameters: {
        'subject': 'Fusion Festa support',
        'body': 'Hi Fusion Festa team,\n\nI need help with...',
      },
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      debugPrint('Could not launch $uri');
    }
  }

  Future<void> onContactWhatsAppTap() async {
    final uri = Uri.parse(
      'https://wa.me/$supportPhone?text=${Uri.encodeComponent('Hi Fusion Festa team, I need help with my booking.')}',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $uri');
    }
  }

  Future<void> onReportProblemTap() async {
    // optionally scroll to message form
  }

  Future<void> sendSupportMessage(BuildContext context) async {
    if (subjectController.text.trim().isEmpty ||
        messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter both subject and message.')),
      );
      return;
    }

    isSending = true;
    notifyListeners();

    // For now just open email composer with subject+body
    final subject = Uri.encodeComponent(subjectController.text.trim());
    final body = Uri.encodeComponent(messageController.text.trim());
    final uri = Uri.parse('mailto:$supportEmail?subject=$subject&body=$body');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }

    isSending = false;
    notifyListeners();
  }

  @override
  void dispose() {
    subjectController.dispose();
    messageController.dispose();
    super.dispose();
  }
}
