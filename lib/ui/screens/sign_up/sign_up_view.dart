import 'package:flutter/material.dart';
import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/ui/screens/sign_up/sign_up_view_model.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, viewModel, child) {
        final size = MediaQuery.of(context).size;

        return Scaffold(
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(Assets.images.signupimage.path),
              ),
            ),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xCC000000),
                    Color(0xB3000000),
                    Color(0x99000000),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(minHeight: size.height - 48),
                      child: Form(
                        key: viewModel.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 24),

                            // Title
                            const Text(
                              'Create Your Account',
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Join the Celebration of Kerala\'s Culture',
                              style: TextStyle(
                                fontSize: 15,
                                color: Color(0xFFCAC4C9),
                              ),
                            ),

                            const SizedBox(height: 32),

                            // Full name
                            const Text(
                              'Full Name',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RoundedField(
                              controller: viewModel.fullNameController,
                              hint: 'Enter your full name',
                              prefixIcon: Icons.person_outline,
                              validator: viewModel.validateFullName,
                              obscure: false,
                            ),

                            const SizedBox(height: 20),

                            // Email
                            const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RoundedField(
                              controller: viewModel.emailController,
                              hint: 'Enter your email address',
                              prefixIcon: Icons.mail_outline,
                              validator: viewModel.validateEmail,
                              keyboardType: TextInputType.emailAddress,
                              obscure: false,
                            ),

                            const SizedBox(height: 20),

                            // Password
                            const Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RoundedField(
                              controller: viewModel.passwordController,
                              hint: 'Enter your password',
                              prefixIcon: Icons.lock_outline,
                              validator: viewModel.validatePassword,
                              obscure: viewModel.isPasswordObscured,
                              suffix: IconButton(
                                icon: Icon(
                                  viewModel.isPasswordObscured
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFFD7C9C7),
                                ),
                                onPressed: viewModel.togglePasswordVisibility,
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Confirm password
                            const Text(
                              'Confirm Password',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            RoundedField(
                              controller: viewModel.confirmPasswordController,
                              hint: 'Confirm your password',
                              prefixIcon: Icons.lock_outline,
                              validator: viewModel.validateConfirmPassword,
                              obscure: viewModel.isConfirmPasswordObscured,
                              suffix: IconButton(
                                icon: Icon(
                                  viewModel.isConfirmPasswordObscured
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: const Color(0xFFD7C9C7),
                                ),
                                onPressed:
                                    viewModel.toggleConfirmPasswordVisibility,
                              ),
                            ),

                            const SizedBox(height: 28),

                            // Create account button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: ElevatedButton(
                                onPressed: viewModel.onCreateAccount,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF8A3D),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  elevation: 8,
                                  shadowColor: const Color(
                                    0xFFFF8A3D,
                                  ).withOpacity(0.6),
                                ),
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Divider OR
                            Row(
                              children: const [
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFF4D4340),
                                    thickness: 0.8,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  child: Text(
                                    'OR',
                                    style: TextStyle(
                                      color: Color(0xFFCAC4C9),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: Color(0xFF4D4340),
                                    thickness: 0.8,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),

                            // Google button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: OutlinedButton(
                                onPressed: viewModel.onGoogleSignUp,
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFF4E3A39),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  backgroundColor: const Color(0xFF191615),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 22,
                                      width: 22,
                                      color: const Color(0xFF37474F),
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Sign up with Google',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),

                            // Apple button
                            SizedBox(
                              width: double.infinity,
                              height: 56,
                              child: OutlinedButton(
                                onPressed: viewModel.onAppleSignUp,
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFF4E3A39),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(26),
                                  ),
                                  backgroundColor: const Color(0xFF191615),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 22,
                                      width: 22,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(width: 12),
                                    const Text(
                                      'Sign up with Apple',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),

                            // Already have account
                            Center(
                              child: Wrap(
                                children: [
                                  const Text(
                                    'Already have an account? ',
                                    style: TextStyle(
                                      color: Color(0xFFCAC4C9),
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: viewModel.onLoginTap,
                                    child: const Text(
                                      'Log In',
                                      style: TextStyle(
                                        color: Color(0xFFFF8A3D),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Terms text (optional)
                            const Center(
                              child: Text(
                                'By creating an account, you agree to our Terms of\nService and Privacy Policy.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF8E8783),
                                  fontSize: 12,
                                  height: 1.4,
                                ),
                              ),
                            ),

                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class RoundedField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final IconData prefixIcon;
  final String? Function(String?)? validator;
  final bool obscure;
  final Widget? suffix;
  final TextInputType? keyboardType;

  const RoundedField({
    super.key,
    required this.controller,
    required this.hint,
    required this.prefixIcon,
    this.validator,
    required this.obscure,
    this.suffix,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      keyboardType: keyboardType,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF191615),
        prefixIcon: Icon(prefixIcon, color: const Color(0xFFD7C9C7)),
        suffixIcon: suffix,
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF8F8A86), fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF403532)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Color(0xFF403532)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
    );
  }
}
