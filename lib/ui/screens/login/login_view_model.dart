import 'package:flutter/material.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:stacked/stacked.dart';

class LoginViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email or username is required';
    }
    // simple email pattern; allow username without @ as well
    if (value.contains('@')) {
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
      if (!emailRegex.hasMatch(value.trim())) {
        return 'Enter a valid email';
      }
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  void onLogin() {
    if (formKey.currentState?.validate() != true) return;

    // TODO: call API, then navigate
    // navigationService.replaceWith(Routes.homeView);
  }

  void tapsignup() {
    navigationService.navigateTo(Routes.signUpView);
  }

  void tapforgotpassword() {
    navigationService.navigateTo(Routes.forPassView);
  }

  void onGoogleLogin() {}

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
