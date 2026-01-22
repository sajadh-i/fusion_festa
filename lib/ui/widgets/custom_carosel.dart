import 'dart:async';
import 'package:flutter/material.dart';

class FusionCarousel extends StatefulWidget {
  final List<String> images;

  const FusionCarousel({super.key, required this.images});

  @override
  State<FusionCarousel> createState() => _FusionCarouselState();
}

class _FusionCarouselState extends State<FusionCarousel> {
  final PageController _controller = PageController();
  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // Auto slide every 4 seconds
    timer = Timer.periodic(const Duration(seconds: 4), (_) {
      if (_controller.hasClients) {
        int next = (currentIndex + 1) % widget.images.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 230,
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() => currentIndex = index);
            },
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  image: DecorationImage(
                    image: AssetImage(widget.images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    // gradient: LinearGradient(
                    //   begin: Alignment.topCenter,
                    //   end: Alignment.bottomCenter,
                    //   colors: [
                    //     Colors.transparent,
                    //     Colors.black.withOpacity(0.6),
                    //   ],
                    // ),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.images.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 8,
              width: currentIndex == index ? 22 : 8,
              decoration: BoxDecoration(
                color: currentIndex == index
                    ? const Color(0xFFFF8A3D)
                    : Colors.white24,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
