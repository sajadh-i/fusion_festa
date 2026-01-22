import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/constants/fonts.gen.dart';
import 'package:fusion_festa/ui/screens/splash/splashviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class Splashview extends StatefulWidget {
  const Splashview({super.key});

  @override
  State<Splashview> createState() => _SplashviewState();
}

class _SplashviewState extends State<Splashview>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => SplashViewModel(),

      onViewModelReady: (model) {
        model.init(this);
      },

      builder: (context, viewModel, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Animation
                ScaleTransition(
                  scale: viewModel.scaleAnimation,
                  child: FadeTransition(
                    opacity: viewModel.fadeAnimation,
                    child: Assets.images.logo5.image(
                      height: 300,
                      width: 300,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Letter by letter animation
                AnimatedBuilder(
                  animation: viewModel.controller,
                  builder: (context, child) {
                    final text = "FUSION FESTA";
                    final chars = text.characters.toList();

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: chars.map((char) {
                        final index = chars.indexOf(char);
                        final progress = viewModel.controller.value;
                        final delay = index * 0.08; // 80ms per letter

                        return Opacity(
                          opacity: progress > delay ? 1.0 : 0.0,
                          child: Transform.scale(
                            scale: progress > delay ? 1.0 : 0.5,
                            child: Text(
                              char,
                              style: const TextStyle(
                                fontFamily: FontFamily.poppins,
                                fontSize: 44,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
