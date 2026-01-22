import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/change_password/change_password_view_model.dart';

import 'package:stacked/stacked.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ViewModelBuilder<ChangePasswordViewModel>.reactive(
      viewModelBuilder: () => ChangePasswordViewModel(),
      builder: (context, vm, child) {
        return Scaffold(
          backgroundColor: const Color(0xFF050814),
          appBar: AppBar(
            backgroundColor: const Color(0xFF050814),
            elevation: 0,
            foregroundColor: Colors.white,
            title: const Text("Change Password"),
            centerTitle: true,
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: vm.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Secure your account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      "Update your password regularly for better security",
                      style: TextStyle(color: Color(0xFFB7A9A6)),
                    ),
                    const SizedBox(height: 30),

                    _passwordField(
                      controller: vm.currentController,
                      label: "Current Password",
                      obscure: vm.obscureCurrent,
                      toggle: vm.toggleCurrent,
                      validator: vm.validatePassword,
                    ),

                    const SizedBox(height: 16),

                    _passwordField(
                      controller: vm.newController,
                      label: "New Password",
                      obscure: vm.obscureNew,
                      toggle: vm.toggleNew,
                      validator: vm.validatePassword,
                    ),

                    const SizedBox(height: 16),

                    _passwordField(
                      controller: vm.confirmController,
                      label: "Confirm Password",
                      obscure: vm.obscureConfirm,
                      toggle: vm.toggleConfirm,
                      validator: vm.validatePassword,
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: size.height * 0.065,
                      child: ElevatedButton(
                        onPressed: vm.isBusy
                            ? null
                            : () => vm.changePassword(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8A3D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                          ),
                        ),
                        child: vm.isBusy
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text(
                                "Update Password",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
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

  Widget _passwordField({
    required TextEditingController controller,
    required String label,
    required bool obscure,
    required VoidCallback toggle,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF101727),
        hintText: label,
        hintStyle: const TextStyle(color: Color(0xFFB7A9A6)),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),

        suffixIcon: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off : Icons.visibility,
            color: const Color(0xFFB7A9A6),
          ),
          onPressed: toggle,
        ),
      ),
    );
  }
}
