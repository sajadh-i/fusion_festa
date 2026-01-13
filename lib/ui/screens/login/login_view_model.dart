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

    return null; //valid password
  }

  Future<void> onLogin() async {
    if (isBusy) return;
    if (formKey.currentState?.validate() != true) return;

    setBusy(true);
    try {
      final user = await authservice.loginWithEmail(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final exists = await userservice.userExists(user.uid);
      if (!exists) {
        await userservice.createUser(
          uid: user.uid,
          name: user.displayName ?? 'User',
          email: user.email ?? emailController.text.trim(),
        );
      }

      //GET ROLE
      final role = await userservice.getUserRole(user.uid);

      //ROLE-BASED NAVIGATION
      if (role == 'admin') {
        navigationService.clearStackAndShow(Routes.adminView);
      } else {
        navigationService.clearStackAndShow(Routes.navbarView);
      }
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e);
    } catch (e) {
      dialogService.showDialog(
        title: 'Login failed',
        description: 'Something went wrong. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

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

      final role = await userservice.getUserRole(user.uid);

      if (role == 'admin') {
        navigationService.clearStackAndShow(Routes.adminView);
      } else {
        navigationService.clearStackAndShow(Routes.navbarView);
      }
    } catch (_) {
      dialogService.showDialog(
        title: 'Google login failed',
        description: 'Unable to login with Google.',
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
