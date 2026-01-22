import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ChangePasswordViewModel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final currentController = TextEditingController();
  final newController = TextEditingController();
  final confirmController = TextEditingController();

  bool obscureCurrent = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  void toggleCurrent() {
    obscureCurrent = !obscureCurrent;
    notifyListeners();
  }

  void toggleNew() {
    obscureNew = !obscureNew;
    notifyListeners();
  }

  void toggleConfirm() {
    obscureConfirm = !obscureConfirm;
    notifyListeners();
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Required';
    if (value.length < 6) return 'Minimum 6 characters';
    return null;
  }

  Future<void> changePassword(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    if (newController.text != confirmController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Passwords do not match")));
      return;
    }

    try {
      setBusy(true);

      final user = FirebaseAuth.instance.currentUser!;
      final email = user.email!;

      // Re-authenticate
      final credential = EmailAuthProvider.credential(
        email: email,
        password: currentController.text.trim(),
      );

      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newController.text.trim());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password updated successfully")),
      );

      currentController.clear();
      newController.clear();
      confirmController.clear();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Password update failed")),
      );
    } finally {
      setBusy(false);
    }
  }

  @override
  void dispose() {
    currentController.dispose();
    newController.dispose();
    confirmController.dispose();
    super.dispose();
  }
}
