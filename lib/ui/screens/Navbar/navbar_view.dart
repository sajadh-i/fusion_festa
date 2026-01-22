import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/Navbar/navbar_view_model.dart';
import 'package:fusion_festa/ui/screens/AI_chat/ai_chat_view.dart';

import 'package:fusion_festa/ui/screens/event_screen/event_screen_view.dart';
import 'package:fusion_festa/ui/screens/home_screen/home_screen_view.dart';

import 'package:fusion_festa/ui/screens/profile/profile_view.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:stacked/stacked.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NavbarViewModel>.reactive(
      viewModelBuilder: () => NavbarViewModel(),
      builder: (context, viewModel, child) {
        final screens = [
          HomeScreenView(
            onGoToEvents: () {
              viewModel.onTabChange(1);
            },
          ),
          EventScreenView(),
          AiChatView(),
          ProfileView(),
        ];

        return Scaffold(
          backgroundColor: const Color(0xFF0D0606),
          body: IndexedStack(index: viewModel.currentIndex, children: screens),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF141010),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.7),
                  blurRadius: 12,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: GNav(
              selectedIndex: viewModel.currentIndex,
              onTabChange: viewModel.onTabChange,
              gap: 8,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),

              backgroundColor: const Color(0xFF141010),
              color: const Color(0xFF9B8C88),
              iconSize: 22,
              activeColor: Colors.white,
              tabBackgroundColor: const Color(0xFFFF2B2B),
              rippleColor: const Color(0x33FF2B2B),
              hoverColor: const Color(0x33FFFFFF),
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOutCubic,
              tabs: [
                GButton(icon: Icons.home_filled, text: 'Home'),
                GButton(icon: Icons.event_rounded, text: 'Events'),
                GButton(icon: Icons.memory, text: 'Fusion AI'),
                GButton(icon: Icons.person_rounded, text: 'Profile'),
              ],
            ),
          ),
        );
      },
    );
  }
}
