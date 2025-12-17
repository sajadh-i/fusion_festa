// lib/ui/screens/profile/profile_view.dart
import 'package:flutter/material.dart';
import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/constants/fonts.gen.dart';
import 'package:fusion_festa/ui/screens/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () => ProfileViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.loadprofile();
      },
      builder: (context, vm, child) {
        final size = MediaQuery.of(context).size;
        final height = size.height;
        final width = size.width;
        final h = height / 812;
        final w = width / 375;

        return Scaffold(
          backgroundColor: const Color(0xFF050304),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF050304),
            elevation: 0,

            centerTitle: true,
            title: Text(
              'Profile & Settings',
              style: TextStyle(
                fontFamily: FontFamily.poppins,
                fontSize: 20 * w,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar + name + email
                  SizedBox(height: 8 * h),
                  CircleAvatar(
                    radius: 44 * w,
                    backgroundColor: const Color(0xFF1C1010),
                    backgroundImage: vm.profileImage.isNotEmpty
                        ? NetworkImage(vm.profileImage)
                        : AssetImage(Assets.images.profileAvatar.path),
                  ),
                  SizedBox(height: 12 * h),
                  Text(
                    vm.userName.isNotEmpty ? vm.userName : "User",
                    style: TextStyle(
                      fontFamily: FontFamily.poppins,
                      fontSize: 18 * w,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4 * h),
                  Text(
                    vm.userEmail,
                    style: TextStyle(
                      fontFamily: FontFamily.dMSans,
                      fontSize: 13 * w,
                      color: const Color(0xFFB7A9A6),
                    ),
                  ),
                  SizedBox(height: 16 * h),

                  // Edit profile button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: vm.onEditProfileTap,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFF181012),
                        side: BorderSide.none,
                        padding: EdgeInsets.symmetric(vertical: 12 * h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 24 * h),

                  // ACCOUNT
                  const _SectionHeader('ACCOUNT'),
                  SizedBox(height: 8 * h),
                  _SettingsCard(
                    children: [
                      // Only My Events, Payment Methods, Password & Security
                      _SettingsTile(
                        icon: Icons.celebration_outlined,
                        iconBg: const Color(0x33FF8A3D),
                        title: 'My Events',
                        onTap: vm.onMyEventsTap,
                      ),
                      _SettingsTile(
                        icon: Icons.credit_card,
                        iconBg: const Color(0x3332C4FF),
                        title: 'Payment Methods',
                        onTap: vm.onPaymentMethodsTap,
                      ),
                      _SettingsTile(
                        icon: Icons.lock_outline_rounded,
                        iconBg: const Color(0x33FF2B2B),
                        title: 'Password & Security',
                        onTap: vm.onSecurityTap,
                        showDivider: false,
                      ),
                    ],
                  ),

                  SizedBox(height: 24 * h),

                  // PREFERENCES
                  const _SectionHeader('PREFERENCES'),
                  SizedBox(height: 8 * h),
                  _SettingsCard(
                    children: [
                      _ToggleTile(
                        icon: Icons.notifications_none_rounded,
                        iconBg: const Color(0x3332C4FF),
                        title: 'Notifications',
                        value: vm.notificationsEnabled,
                        onChanged: vm.onNotificationsChanged,
                      ),
                      _SettingsTile(
                        icon: Icons.language_rounded,
                        iconBg: const Color(0x334CAF50),
                        title: 'Language',
                        trailingText: vm.languageLabel,
                        onTap: vm.onLanguageTap,

                        showDivider: false,
                      ),
                    ],
                  ),

                  SizedBox(height: 24 * h),

                  // SUPPORT & LEGAL
                  const _SectionHeader('SUPPORT & LEGAL'),
                  SizedBox(height: 8 * h),
                  _SettingsCard(
                    children: [
                      _SettingsTile(
                        icon: Icons.headset_mic_outlined,
                        iconBg: const Color(0x3332C4FF),
                        title: 'Help & Support',
                        onTap: vm.onHelpTap,
                      ),
                      _SettingsTile(
                        icon: Icons.article_outlined,
                        iconBg: const Color(0x33FF8A3D),
                        title: 'Terms of Service',
                        onTap: vm.onTermsTap,
                      ),
                      _SettingsTile(
                        icon: Icons.privacy_tip_outlined,
                        iconBg: const Color(0x334CAF50),
                        title: 'Privacy Policy',
                        onTap: vm.onPrivacyTap,
                        showDivider: false,
                      ),
                    ],
                  ),

                  SizedBox(height: 24 * h),

                  // Log out
                  SizedBox(
                    width: double.infinity,
                    height: 50 * h,
                    child: OutlinedButton(
                      onPressed: vm.onLogoutTap,
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF10261E),
                        foregroundColor: const Color(0xFF3AF78C),
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Log Out',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 12 * h),

                  // Delete account
                  TextButton(
                    onPressed: vm.onDeleteAccountTap,
                    child: const Text(
                      'Delete Account',
                      style: TextStyle(
                        color: Color(0xFFFF4B4B),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 8 * h),
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
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFFB7A9A6),
          fontSize: 12,
          letterSpacing: 0.7,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  final List<Widget> children;
  const _SettingsCard({required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF181012),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(children: children),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String? trailingText;
  final VoidCallback onTap;
  final bool showDivider;
  final bool showTopDivider;

  const _SettingsTile({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.onTap,
    this.trailingText,
    this.showDivider = true,
    this.showTopDivider = false,
  });

  @override
  Widget build(BuildContext context) {
    final tile = ListTile(
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: iconBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.white, size: 18),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(
              trailingText!,
              style: const TextStyle(color: Color(0xFFB7A9A6), fontSize: 13),
            ),
          const SizedBox(width: 4),
          const Icon(Icons.chevron_right, color: Color(0xFFB7A9A6)),
        ],
      ),
      onTap: onTap,
    );

    return Column(
      children: [
        tile,
        if (showDivider)
          const Divider(height: 0, thickness: 0.7, color: Color(0xFF2E2221)),
      ],
    );
  }
}

class _ToggleTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleTile({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 18),
          ),
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          trailing: Switch(
            value: value,
            activeColor: const Color(0xFF004D2F),
            activeTrackColor: const Color(0xFF3AF78C),
            onChanged: onChanged,
          ),
          onTap: () => onChanged(!value),
        ),
        const Divider(height: 0, thickness: 0.7, color: Color(0xFF2E2221)),
      ],
    );
  }
}
