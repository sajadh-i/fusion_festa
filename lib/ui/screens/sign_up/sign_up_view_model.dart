import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stacked/stacked.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:fusion_festa/services/auth_service.dart';
import 'package:fusion_festa/services/user_service.dart';

class SignUpViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isPasswordObscured = true;
  bool isConfirmPasswordObscured = true;

  // ---------------- TOGGLES ----------------
  void togglePasswordVisibility() {
    isPasswordObscured = !isPasswordObscured;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordObscured = !isConfirmPasswordObscured;
    notifyListeners();
  }

  // ---------------- VALIDATORS ----------------
  String? validateFullName(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'Full name is required';
    if (text.length < 3) return 'Enter at least 3 characters';
    return null;
  }

  String? validateEmail(String? value) {
    final text = (value ?? '').trim();
    if (text.isEmpty) return 'Email is required';
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(text)) {
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

  String? validateConfirmPassword(String? value) {
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

  // ---------------- EMAIL SIGN UP ----------------
  Future<void> onCreateAccount() async {
    if (!formKey.currentState!.validate()) return;

    setBusy(true);
    try {
      final user = await authservice.signUpWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      await userservice.createUser(
        uid: user.uid,
        name: fullNameController.text.trim(),
        email: user.email!,
      );

      navigationService.replaceWith(Routes.navbarView);
    } on FirebaseAuthException catch (e) {
      dialogService.showDialog(
        title: 'Sign up failed',
        description: _mapAuthError(e),
      );
    } finally {
      setBusy(false);
    }
  }

  // ---------------- GOOGLE SIGN UP ----------------
  Future<void> onGoogleSignUp() async {
    setBusy(true);
    try {
      final user = await authservice.signInWithGoogle();

      final exists = await userservice.userExists(user.uid);
      if (!exists) {
        await userservice.createUser(
          uid: user.uid,
          name: user.displayName ?? 'User',
          email: user.email!,
        );
      }

      navigationService.replaceWith(Routes.navbarView);
    } catch (e) {
      dialogService.showDialog(
        title: 'Google Sign-In failed',
        description: e.toString(),
      );
    } finally {
      setBusy(false);
    }
  }

  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email already registered. Please login.';
      case 'weak-password':
        return 'Password is too weak.';
      case 'invalid-email':
        return 'Invalid email address.';
      default:
        return 'Sign up failed.';
    }
  }

  // ---------------- NAVIGATION ----------------
  void onLoginTap() {
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
