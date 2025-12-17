// lib/ui/screens/security/password_security_view.dart
import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/passwordsecurity/passwordsecurityviewmode.dart';
import 'package:stacked/stacked.dart';
import 'package:fusion_festa/gen/fonts.gen.dart';

class PasswordSecurityView extends StatelessWidget {
  const PasswordSecurityView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PasswordSecurityViewModel>.reactive(
      viewModelBuilder: () => PasswordSecurityViewModel(),
      onViewModelReady: (vm) => vm.initialise(),
      builder: (context, vm, child) {
        final size = MediaQuery.of(context).size;
        final h = size.height / 812;
        final w = size.width / 375;

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
              'Password & Security',
              style: TextStyle(
                fontFamily: FontFamily.poppins,
                fontSize: 18 * w,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 20 * w,
                vertical: 16 * h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header text
                  Text(
                    'Secure your Fusion Festa account with your device lock and password options.',
                    style: TextStyle(
                      color: const Color(0xFFB7A9A6),
                      fontSize: 13 * w,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 20 * h),

                  const _SectionHeader('DEVICE SECURITY'),

                  SizedBox(height: 8 * h),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF181012),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        SwitchListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          secondary: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: const Color(0x333AF78C),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.phonelink_lock_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          title: const Text(
                            'Use system lock',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: const Text(
                            'Require your device PIN, pattern, fingerprint, or Face ID when opening Fusion Festa or sensitive sections.',
                            style: TextStyle(
                              color: Color(0xFFB7A9A6),
                              fontSize: 11,
                              height: 1.4,
                            ),
                          ),
                          value: vm.systemLockEnabled,
                          activeColor: const Color(0xFF004D2F),
                          activeTrackColor: const Color(0xFF3AF78C),
                          onChanged: vm.isBusy
                              ? null
                              : (_) => vm.toggleSystemLock(),
                        ),
                        if (vm.systemLockError != null)
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                            child: Text(
                              vm.systemLockError!,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 11,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24 * h),

                  const _SectionHeader('PASSWORD'),

                  SizedBox(height: 8 * h),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF181012),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: const Color(0x33FF8A3D),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.lock_reset_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          title: const Text(
                            'Change password',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: const Text(
                            'Update the password you use to sign in.',
                            style: TextStyle(
                              color: Color(0xFFB7A9A6),
                              fontSize: 11,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.chevron_right,
                            color: Color(0xFFB7A9A6),
                          ),
                          onTap: vm.ontapchangepassword,
                        ),
                        const Divider(
                          height: 0,
                          thickness: 0.7,
                          color: Color(0xFF2E2221),
                        ),
                        ListTile(
                          leading: Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: const Color(0x33FF2B2B),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.logout_rounded,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          title: const Text(
                            'Sign out from all devices',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: const Text(
                            'Force log out from any other phones or browsers.',
                            style: TextStyle(
                              color: Color(0xFFB7A9A6),
                              fontSize: 11,
                            ),
                          ),
                          onTap: vm.ontaplogOutAllDevices,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32 * h),

                  // Info text
                  const Text(
                    'Tip: Keep your device lock and email up to date to recover your Fusion Festa account easily.',
                    style: TextStyle(
                      color: Color(0xFF8F817E),
                      fontSize: 11,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFFB7A9A6),
        fontSize: 12,
        letterSpacing: 0.7,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
