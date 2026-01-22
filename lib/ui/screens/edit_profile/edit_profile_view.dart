import 'package:flutter/material.dart';
import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/constants/fonts.gen.dart';
import 'package:fusion_festa/ui/screens/edit_profile/edit_profile_viewmodel.dart';
import 'package:fusion_festa/ui/screens/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewmodel>.reactive(
      viewModelBuilder: () => EditProfileViewmodel(),
      builder: (context, vm, child) {
        final size = MediaQuery.of(context).size;
        final height = size.height;
        final width = size.width;
        final h = height / 812;
        final w = width / 375;

        return Scaffold(
          backgroundColor: const Color(0xFF050304),
          appBar: AppBar(
            backgroundColor: const Color(0xFF050304),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 20,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              'Edit Profile',
              style: TextStyle(
                fontFamily: FontFamily.poppins,
                fontSize: 22 * w,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: Form(
              key: vm.formKey,

              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: 20 * w,
                  vertical: 24 * h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar  edit icon
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 64 * w,
                          backgroundColor: const Color(0xFF1C1010),
                          backgroundImage: vm.profileImageFile != null
                              ? FileImage(vm.profileImageFile!)
                              : (vm.profileImageUrl.isNotEmpty
                                        ? NetworkImage(vm.profileImageUrl)
                                        : AssetImage(
                                            Assets.images.profileAvatar.path,
                                          ))
                                    as ImageProvider,
                        ),

                        GestureDetector(
                          onTap: vm.onChangeAvatar,
                          child: Container(
                            width: 34 * w,
                            height: 34 * w,
                            decoration: const BoxDecoration(
                              color: Color(0xFF004D2F),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 32 * h),

                    // Full name
                    _Label('Full Name'),
                    SizedBox(height: 8 * h),
                    _ProfileField(
                      controller: vm.nameController,
                      hint: 'Your full name',
                      validator: vm.validateName,
                    ),

                    SizedBox(height: 20 * h),

                    // Email
                    _Label('Email Address'),
                    SizedBox(height: 8 * h),
                    _ProfileField(
                      readOnly: true,
                      enabled: false,
                      controller: vm.emailController,
                      hint: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 20 * h),

                    // Phone
                    _Label('Phone Number'),
                    SizedBox(height: 8 * h),
                    _ProfileField(
                      controller: vm.phoneController,
                      hint: '+91 98765 43210',
                      keyboardType: TextInputType.phone,
                      validator: vm.validatePhone,
                    ),

                    SizedBox(height: 40 * h),

                    // Save button
                    SizedBox(
                      width: double.infinity,
                      height: 52 * h,
                      child: ElevatedButton(
                        onPressed: vm.isBusy
                            ? null
                            : () => vm.onSaveProfile(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF004D2F),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          elevation: 8,
                          shadowColor: const Color(0xFF004D2F).withOpacity(0.7),
                        ),
                        child: vm.isBusy
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : const Text(
                                'Save Changes',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _Label extends StatelessWidget {
  final String text;
  const _Label(this.text);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFE6D7D0),
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _ProfileField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool readOnly;
  final bool enabled;

  const _ProfileField({
    required this.controller,
    required this.hint,
    this.validator,
    this.keyboardType,
    this.readOnly = false,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly!,
      enabled: enabled,
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      cursorColor: const Color(0xFFFF8A3D),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9B8E88), fontSize: 13),
        filled: true,
        fillColor: const Color(0xFF0F090B),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF3A2C2A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFFF8A3D), width: 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.4),
        ),
      ),
    );
  }
}
