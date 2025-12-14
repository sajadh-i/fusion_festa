import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/settings/setting_view_model.dart';
import 'package:stacked/stacked.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SettingViewModel>.reactive(
      viewModelBuilder: () {
        return SettingViewModel();
      },
      builder:
          (BuildContext context, SettingViewModel viewModel, Widget? child) {
            return Scaffold();
          },
    );
  }
}
