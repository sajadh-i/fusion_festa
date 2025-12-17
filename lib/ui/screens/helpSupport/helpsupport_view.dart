// lib/ui/screens/helpSupport/helpsupport_view.dart
import 'package:flutter/material.dart';
import 'package:fusion_festa/gen/fonts.gen.dart';
import 'package:fusion_festa/ui/screens/helpSupport/helpsupport_viewmodel.dart';
import 'package:stacked/stacked.dart';

class HelpsupportView extends StatelessWidget {
  const HelpsupportView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HelpsupportViewmodel>.reactive(
      viewModelBuilder: () => HelpsupportViewmodel(),
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
              'Help & Support',
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
                  Text(
                    'Need help with Fusion Festa bookings, payments, or events? Reach out any time.',
                    style: TextStyle(
                      color: const Color(0xFFB7A9A6),
                      fontSize: 13 * w,
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 20 * h),

                  const _SectionHeader('QUICK HELP'),
                  SizedBox(height: 8 * h),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF181012),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        _HelpTile(
                          icon: Icons.help_outline_rounded,
                          iconBg: const Color(0x33FF8A3D),
                          title: 'Browse FAQs',
                          subtitle:
                              'Instant answers about tickets, cancellations, and events.',
                          onTap: vm.onFaqTap,
                        ),
                        const Divider(
                          height: 0,
                          thickness: 0.7,
                          color: Color(0xFF2E2221),
                        ),
                        _HelpTile(
                          icon: Icons.bug_report_outlined,
                          iconBg: const Color(0x33FF2B2B),
                          title: 'Report a problem',
                          subtitle:
                              'Tell us if something is not working as expected.',
                          onTap: vm.onReportProblemTap,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24 * h),

                  const _SectionHeader('CONTACT US'),
                  SizedBox(height: 8 * h),

                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF181012),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      children: [
                        _HelpTile(
                          icon: Icons.email_outlined,
                          iconBg: const Color(0x3332C4FF),
                          title: 'Email support',
                          subtitle: vm.supportEmail,
                          onTap: vm.onContactEmailTap,
                        ),
                        const Divider(
                          height: 0,
                          thickness: 0.7,
                          color: Color(0xFF2E2221),
                        ),
                        _HelpTile(
                          icon: Icons.chat_bubble_outline_rounded,
                          iconBg: const Color(0x333AF78C),
                          title: 'Chat on WhatsApp',
                          subtitle: vm.supportPhone,
                          onTap: vm.onContactWhatsAppTap,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24 * h),

                  const _SectionHeader('SEND US A MESSAGE'),
                  SizedBox(height: 8 * h),

                  _FusionField(
                    controller: vm.subjectController,
                    hint: 'Subject (e.g., Ticket not received)',
                    maxLines: 1,
                  ),
                  SizedBox(height: 12 * h),
                  _FusionField(
                    controller: vm.messageController,
                    hint:
                        'Describe your issue with the event, payment, or booking.',
                    maxLines: 4,
                  ),

                  SizedBox(height: 20 * h),

                  SizedBox(
                    width: double.infinity,
                    height: 50 * h,
                    child: ElevatedButton(
                      onPressed: vm.isSending
                          ? null
                          : () => vm.sendSupportMessage(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8A3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                        elevation: 10,
                        shadowColor: const Color(0xFFFF8A3D).withOpacity(0.7),
                      ),
                      child: vm.isSending
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
                              'Send Message',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),

                  SizedBox(height: 16 * h),

                  const Text(
                    'Our support team typically replies within 24 hours.',
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

class _HelpTile extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _HelpTile({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Color(0xFFB7A9A6), fontSize: 11),
      ),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFFB7A9A6)),
      onTap: onTap,
    );
  }
}

class _FusionField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;

  const _FusionField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      cursorColor: const Color(0xFFFF8A3D),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFF9B8E88), fontSize: 13),
        filled: true,
        fillColor: const Color(0xFF0F090B),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFF3A2C2A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFFF8A3D), width: 1.4),
        ),
      ),
    );
  }
}
