import 'package:flutter/material.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:stacked/stacked.dart';

class SignUpViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    notifyListeners();
  }

  String? validateFullName(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'Full name is required';
    if (text.length < 3) return 'Enter at least 3 characters';
    if (!RegExp(r"^[a-zA-Z\s.]+$").hasMatch(text)) {
      return 'Only letters and spaces allowed';
    }
    return null;
  }

  String? validateEmail(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'Email is required';
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(text)) return 'Enter a valid email address';
    return null;
  }

  String? validatePassword(String? value) {
    final pwd = value ?? '';
    if (pwd.isEmpty) return 'Password is required';
    if (pwd.length < 8) return 'At least 8 characters required';

    final hasUpper = RegExp(r'[A-Z]').hasMatch(pwd);
    final hasLower = RegExp(r'[a-z]').hasMatch(pwd);
    final hasDigit = RegExp(r'[0-9]').hasMatch(pwd);
    final hasSpecial = RegExp(
      r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]=+`~]',
    ).hasMatch(pwd);

    if (!hasUpper) return 'Include at least one uppercase letter';
    if (!hasLower) return 'Include at least one lowercase letter';
    if (!hasDigit) return 'Include at least one number';
    if (!hasSpecial) return 'Include at least one special character';

    return null;
  }

  String? validateConfirmPassword(String? value) {
    final confirm = value ?? '';
    if (confirm.isEmpty) return 'Confirm your password';
    if (confirm != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void onCreateAccount() {
    if (formKey.currentState?.validate() != true) return;
    // TODO: call sign-up API, then navigate
  }

  void onGoogleSignUp() {
    // TODO: handle Google sign-up
  }

  void onAppleSignUp() {
    // TODO: handle Apple sign-up
  }

  void onLoginTap() {
    // TODO: navigate to Login screen
    navigationService.replaceWith(Routes.loginView);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
