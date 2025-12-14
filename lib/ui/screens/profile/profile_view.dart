import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/profile/profile_view_model.dart';
import 'package:stacked/stacked.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      viewModelBuilder: () {
        return ProfileViewModel();
      },
      builder:
          (BuildContext context, ProfileViewModel viewModel, Widget? child) {
            return Scaffold(appBar: AppBar(title: Text("Profile")));
          },
    );
  }
}
