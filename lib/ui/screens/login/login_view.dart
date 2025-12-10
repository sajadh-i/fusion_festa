import 'package:flutter/material.dart';
import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/ui/screens/login/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
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
                image: AssetImage(Assets.images.loginimage.path),
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 52),

                          // Top icon
                          Center(
                            child: Container(
                              height: 72,
                              width: 72,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2B1410),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Icon(
                                Icons.star_border_rounded,
                                color: Color(0xFFFF2B2B),
                                size: 36,
                              ),
                            ),
                          ),

                          const SizedBox(height: 32),

                          // Title
                          const Center(
                            child: Text(
                              'Welcome Back',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Center(
                            child: Text(
                              'Experience the Culture',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFFCAC4C9),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // FORM
                          Form(
                            key: viewModel.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Email or Username',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Email field
                                Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2B1817),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: const Color(0xFF4A3332),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: viewModel.emailController,
                                    style: const TextStyle(color: Colors.white),
                                    validator: viewModel.validateEmail,
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: Icon(
                                        Icons.person_outline,
                                        color: Color(0xFFD7C9C7),
                                      ),
                                      hintText: 'Enter your email or username',
                                      hintStyle: TextStyle(
                                        color: Color(0xFFB39C9A),
                                        fontSize: 14,
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 0,
                                        vertical: 16,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 20),

                                const Text(
                                  'Password',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Password field
                                Container(
                                  height: 56,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF2B1817),
                                    borderRadius: BorderRadius.circular(18),
                                    border: Border.all(
                                      color: const Color(0xFF4A3332),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: viewModel.passwordController,
                                    obscureText: viewModel.isPasswordObscured,
                                    style: const TextStyle(color: Colors.white),
                                    validator: viewModel.validatePassword,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      prefixIcon: const Icon(
                                        Icons.lock_outline,
                                        color: Color(0xFFD7C9C7),
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          viewModel.isPasswordObscured
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          color: const Color(0xFFD7C9C7),
                                        ),
                                        onPressed:
                                            viewModel.togglePasswordVisibility,
                                      ),
                                      hintText: 'Enter your password',
                                      hintStyle: const TextStyle(
                                        color: Color(0xFFB39C9A),
                                        fontSize: 14,
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 0,
                                            vertical: 16,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Forgot password
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: viewModel.onForgotPassword,
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.zero,
                              ),
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Color(0xFFFF3B30),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          // Login button
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: viewModel.onLogin,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF2B2B),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                elevation: 0,
                              ),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Divider "or"
                          Row(
                            children: const [
                              Expanded(
                                child: Divider(
                                  color: Color(0xFF645452),
                                  thickness: 0.8,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  'or',
                                  style: TextStyle(
                                    color: Color(0xFFCAC4C9),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Divider(
                                  color: Color(0xFF645452),
                                  thickness: 0.8,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),

                          // Continue with Google
                          SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: OutlinedButton(
                              onPressed: viewModel.onGoogleLogin,
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                  color: Color(0xFF4E3A39),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                backgroundColor: Colors.transparent,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 24,
                                    width: 24,
                                    color: const Color(0xFF37474F),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Continue with Google',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          // Bottom sign up text
                          Center(
                            child: Wrap(
                              children: const [
                                Text(
                                  "Don't have an account? ",
                                  style: TextStyle(
                                    color: Color(0xFFCAC4C9),
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: Color(0xFFFF3B30),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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
        );
      },
    );
  }
}
