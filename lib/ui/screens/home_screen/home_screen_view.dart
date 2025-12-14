import 'package:flutter/material.dart';
import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/gen/fonts.gen.dart';
import 'package:fusion_festa/ui/screens/home_screen/home_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class HomeScreenView extends StatelessWidget {
  final VoidCallback? onGoToEvents;
  const HomeScreenView({super.key, this.onGoToEvents});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      onViewModelReady: (viewModel) {
        viewModel.initialise();
      },
      builder: (context, viewModel, child) {
        final size = MediaQuery.of(context).size;
        final height = size.height;
        final width = size.width;

        // Simple scale factors based on a 812x375 base phone size
        final h = height / 812;
        final w = width / 375;
        final textScale = width / 375; // responsive text [web:34][web:35]

        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              'Explore Events!',
              style: TextStyle(
                fontFamily: FontFamily.inter,
                fontSize: 24 * textScale.clamp(0.9, 1.3),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 24 * textScale.clamp(0.9, 1.4),
                ),
                onPressed: () {
                  viewModel.tapsetteing();
                },
              ),
              SizedBox(width: 4 * w),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  // Background image + dark gradient
                  SizedBox(
                    height: height,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Image.asset(
                            Assets.images.homescreenimage.path,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
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
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Foreground content
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20 * w,
                      vertical: 16 * h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10 * h),

                        const Text(
                          'Make your plans for an\nunforgettable event with',
                          style: TextStyle(
                            fontSize: 20,
                            height: 1.4,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFD9D2CF),
                          ),
                        ),

                        SizedBox(height: 4 * h),

                        Text(
                          'Fusion Festa',
                          style: TextStyle(
                            fontFamily: FontFamily.inter,
                            fontSize: 30 * textScale.clamp(0.9, 1.4),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: 20 * h),

                        // instead of the plain const Text block
                        AnimatedSlide(
                          offset: viewModel.showHeroText
                              ? Offset.zero
                              : const Offset(0, 0.2),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          child: AnimatedOpacity(
                            opacity: viewModel.showHeroText ? 1 : 0,
                            duration: const Duration(milliseconds: 500),
                            curve:
                                Curves.easeOut, // smooth fade [web:50][web:52]
                            child: const Text(
                              maxLines: 4,
                              'Celebrate the spirit of Kerala.'
                              'Colorful festivals, temple lights, and music.'
                              'Traditional arts, rhythms, and rituals.'
                              'Joyful gatherings with food and culture.'
                              'Experience Kerala’s vibrant festive vibe.',
                              style: TextStyle(
                                color: Color(0xFFD9D2CF),
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20 * h),

                        SizedBox(
                          height: 44 * h.clamp(0.8, 1.2),
                          width: size.width * 0.40,
                          child: ElevatedButton(
                            onPressed: viewModel.onGetStarted,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF8A3D),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22 * w),
                              ),
                              elevation: 8,
                              shadowColor: const Color(
                                0xFFFF8A3D,
                              ).withOpacity(0.6),
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 15 * textScale.clamp(0.9, 1.2),
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 80 * h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              Assets.images.ticket.path,
                              height: height * 0.35,
                              width: width * 0.8,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),

                        SizedBox(height: 20 * h),

                        buildCompletedEventCard(
                          height: height,
                          width: width,
                          textScale: textScale,
                        ),
                      ],
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

  Widget buildCompletedEventCard({
    required double height,
    required double width,
    required double textScale,
  }) {
    final h = height / 812;
    final w = width / 375;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Completed Events',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16 * textScale.clamp(0.9, 1.2),
                fontWeight: FontWeight.w600,
              ),
            ),
            GestureDetector(
              onTap: onGoToEvents,
              child: Text(
                'View all',
                style: TextStyle(
                  color: const Color(0xFFFF8A3D),
                  fontSize: 13 * textScale.clamp(0.9, 1.1),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12 * h),

        Container(
          padding: EdgeInsets.only(left: 15 * w, bottom: 15 * h),
          height: height * 0.24, // card scales with screen height [web:34]
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20 * w),
            image: DecorationImage(
              image: AssetImage(Assets.images.homescreenimage.path),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                '11.11 SING 2 TOUR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13 * textScale.clamp(0.9, 1.1),
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 4 * h),
              Text(
                'Ed Sheeran · Kochi Arena',
                style: TextStyle(
                  color: const Color(0xFFE1D6D2),
                  fontSize: 12 * textScale.clamp(0.9, 1.1),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
