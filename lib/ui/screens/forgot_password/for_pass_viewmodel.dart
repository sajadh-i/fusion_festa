import 'package:flutter/material.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:stacked/stacked.dart';
import 'package:fusion_festa/app/app.router.dart';

class ForPassViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  String? validateEmail(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(text)) return 'Enter a valid email address';
    return null;
  }

  void onBack() {
    // TODO: navigationService.back();
    navigationService.back();
  }

  void onSendResetLink() {
    if (formKey.currentState?.validate() != true) return;
    // TODO: call API to send reset link, show success message / navigate
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
