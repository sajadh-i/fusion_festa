import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:fusion_festa/services/auth_service.dart';
import 'package:fusion_festa/services/user_service.dart';

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
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final password = value ?? '';

    if (password.isEmpty) {
      return 'Password is required';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!RegExp(r'[A-Z]').hasMatch(password)) {
      return 'Password must contain at least 1 uppercase letter';
    }

    if (!RegExp(r'[a-z]').hasMatch(password)) {
      return 'Password must contain at least 1 lowercase letter';
    }

    if (!RegExp(r'[0-9]').hasMatch(password)) {
      return 'Password must contain at least 1 number';
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>_\-\\/\[\]=+`~]').hasMatch(password)) {
      return 'Password must contain at least 1 special character';
    }

    return null; // ✅ valid password
  }

  // ================= EMAIL LOGIN =================
  Future<void> onLogin() async {
    if (isBusy) return;
    if (formKey.currentState?.validate() != true) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    setBusy(true);
    try {
      final user = await authservice.loginWithEmail(
        email: email,
        password: password,
      );

      final exists = await userservice.userExists(user.uid);
      if (!exists) {
        await userservice.createUser(
          uid: user.uid,
          name: user.displayName ?? 'User',
          email: user.email ?? email,
        );
      }

      navigationService.replaceWith(Routes.navbarView);
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (_) {
      dialogService.showDialog(
        title: 'Login failed',
        description: 'Something went wrong. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  // ================= GOOGLE LOGIN =================
  Future<void> onGoogleLogin() async {
    if (isBusy) return;

    setBusy(true);
    try {
      final user = await authservice.signInWithGoogle();

      final exists = await userservice.userExists(user.uid);
      if (!exists) {
        await userservice.createUser(
          uid: user.uid,
          name: user.displayName ?? 'User',
          email: user.email ?? '',
        );
      }

      navigationService.replaceWith(Routes.navbarView);
    } catch (_) {
      dialogService.showDialog(
        title: 'Google login failed',
        description: 'Unable to login with Google. Try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  // ================= ERROR HANDLING =================
  void _handleAuthError(FirebaseAuthException e) {
    String message;
    switch (e.code) {
      case 'user-not-found':
        message = 'No account found. Please sign up.';
        break;
      case 'wrong-password':
        message = 'Incorrect password.';
        break;
      case 'invalid-email':
        message = 'Invalid email address.';
        break;
      case 'user-disabled':
        message = 'This account has been disabled.';
        break;
      default:
        message = 'Login failed. Please try again.';
    }

    dialogService.showDialog(title: 'Login Error', description: message);
  }

  void tapsignup() {
    navigationService.navigateTo(Routes.signUpView);
  }

  void tapforgotpassword() {
    navigationService.navigateTo(Routes.forPassView);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
