import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:fusion_festa/ui/screens/onboarding/onboardingviewmodel.dart';

class Onboardingview extends StatelessWidget {
  const Onboardingview({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<Onboardingviewmodel>.reactive(
      viewModelBuilder: () => Onboardingviewmodel(),
      builder: (context, viewModel, child) {
        final size = MediaQuery.of(context).size;
        final item = viewModel.currentItem;

        return Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              SizedBox(
                height: size.height * 0.70,
                width: double.infinity,
                child: item.image.image(fit: BoxFit.cover),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: size.height * 0.60,
                  padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,

                        Color(0xE020110C),
                        Color(0xFF20110C),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),

                      Text(
                        item.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 28,
                          height: 1.3,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 35),
                      Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.5,
                          color: Color(0xFFD0C8C3),
                        ),
                      ),

                      SizedBox(height: 40),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          viewModel.items.length,
                          (index) => Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4.0,
                            ),
                            child: _Dot(
                              isActive: index == viewModel.currentIndex,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: ElevatedButton(
                                onPressed: viewModel.onSkip,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  side: const BorderSide(
                                    color: Color(0xFF6C5F56),
                                    width: 1.4,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text(
                                  'Skip',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: SizedBox(
                              height: 52,
                              child: ElevatedButton(
                                onPressed: viewModel.onNext,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFF6A2B),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  viewModel.isLastPage ? 'Get Started' : 'Next',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Dot extends StatelessWidget {
  final bool isActive;
  const _Dot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFF6A2B) : const Color(0xFF4C3327),
        shape: BoxShape.circle,
      ),
    );
  }
}
