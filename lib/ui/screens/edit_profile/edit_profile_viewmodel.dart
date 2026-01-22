import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:fusion_festa/services/user_service.dart';
import 'package:fusion_festa/services/cloudinary_service.dart';

class EditProfileViewmodel extends BaseViewModel {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  File? profileImageFile;
  String profileImageUrl = '';

  final _imagePicker = ImagePicker();

  //LOAD EXISTING DATA
  Future<void> init() async {
    setBusy(true);

    final authUser = FirebaseAuth.instance.currentUser!;
    emailController.text = authUser.email ?? '';

    final data = await userservice.getCurrentUserProfile();
    nameController.text = data['name'] ?? '';
    phoneController.text = data['phone'] ?? '';
    profileImageUrl = data['profileImage'] ?? '';

    setBusy(false);
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number required';
    }
    if (value.trim().length < 10) {
      return 'Enter valid phone number';
    }
    return null;
  }

  Future<void> onChangeAvatar() async {
    final picked = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (picked == null) return;

    profileImageFile = File(picked.path);
    notifyListeners();
  }

  Future<void> onSaveProfile(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    setBusy(true);

    String finalImageUrl = profileImageUrl;

    if (profileImageFile != null) {
      finalImageUrl = await cloudinaryservice.uploadImage(profileImageFile!);
    }

    await userservice.updateProfile(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      profileImage: finalImageUrl,
    );

    setBusy(false);

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile updated')));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
