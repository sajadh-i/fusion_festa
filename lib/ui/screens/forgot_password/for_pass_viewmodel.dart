import 'package:firebase_auth/firebase_auth.dart';
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

  void onSendResetLink() async {
    if (formKey.currentState?.validate() != true) return;

    setBusy(true);

    try {
      await authservice.sendPasswordResetEmail(emailController.text.trim());

      dialogService.showDialog(
        title: 'Reset Link Sent',
        description:
            'A password reset link has been sent to your email. Please check your inbox.',
      );

      // go back to login after success
      navigationService.replaceWith(Routes.loginView);
    } on FirebaseAuthException catch (e) {
      dialogService.showDialog(
        title: 'Error',
        description: e.message ?? 'Failed to send reset link',
      );
    } catch (_) {
      dialogService.showDialog(
        title: 'Error',
        description: 'Something went wrong. Try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
}
