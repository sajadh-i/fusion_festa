// lib/ui/screens/event_details/eventdetails_view.dart

import 'package:flutter/material.dart';
import 'package:fusion_festa/gen/fonts.gen.dart';
import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/ui/screens/event_details/eventdetails_view_model.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:stacked/stacked.dart';

class EventdetailsView extends StatelessWidget {
  final String eventId;
  const EventdetailsView({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventdetailsViewModel>.reactive(
      viewModelBuilder: () => EventdetailsViewModel(eventId: eventId),
      onViewModelReady: (vm) => vm.init(),
      builder: (context, vm, child) {
        final size = MediaQuery.of(context).size;
        final h = size.height / 812;
        final w = size.width / 375;

        //SHIMMER WHILE LOADING
        if (vm.isBusy) {
          return Scaffold(
            backgroundColor: const Color(0xFF050304),
            body: SafeArea(child: _buildShimmer(context)),
          );
        }

        return Scaffold(
          backgroundColor: const Color(0xFF050304),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      /// 🔹 APP BAR WITH IMAGE
                      SliverAppBar(
                        backgroundColor: const Color(0xFF050304),
                        elevation: 0,
                        pinned: true,
                        expandedHeight: size.height * 0.40,
                        leading: IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                            size: 20,
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Image.network(
                                vm.imageUrl,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) =>
                                    Container(color: Colors.black26),
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.transparent,
                                      Color(0xCC000000),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// 🔹 CONTENT
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20 * w,
                            vertical: 16 * h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// TITLE
                              Text(
                                vm.title,
                                style: TextStyle(
                                  fontFamily: FontFamily.poppins,
                                  fontSize: 22 * w,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),

                              SizedBox(height: 24 * h),

                              /// INFO CHIPS
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _InfoChip(
                                    icon: Icons.calendar_today_rounded,
                                    label: vm.dateText,
                                  ),
                                  SizedBox(width: 24 * w),
                                  _InfoChip(
                                    icon: Icons.access_time_rounded,
                                    label: vm.timeText,
                                  ),
                                  SizedBox(width: 24 * w),
                                  // _InfoChip(
                                  //   icon: Icons.place_rounded,
                                  //   label: vm.venueName,
                                  // ),
                                  _InfoChip(
                                    icon: Icons.currency_rupee_rounded,
                                    label: vm.priceRange,
                                  ),
                                ],
                              ),

                              SizedBox(height: 36 * h),

                              /// 🔹 TABS
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _TabButton(
                                    title: 'About',
                                    isSelected: vm.selectedTab == 0,
                                    onTap: () => vm.onTabChanged(0),
                                  ),
                                  _TabButton(
                                    title: 'Venue',
                                    isSelected: vm.selectedTab == 1,
                                    onTap: () => vm.onTabChanged(1),
                                  ),
                                ],
                              ),

                              SizedBox(height: 16 * h),

                              /// 🔹 TAB CONTENT
                              AnimatedOpacity(
                                opacity: vm.contentVisible ? 1 : 0,
                                duration: const Duration(milliseconds: 250),
                                child: AnimatedSlide(
                                  offset: vm.contentVisible
                                      ? Offset.zero
                                      : const Offset(0, 0.03),
                                  duration: const Duration(milliseconds: 250),
                                  child: _buildTabContent(vm),
                                ),
                              ),

                              SizedBox(height: 40 * h),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(20 * w, 12 * h, 20 * w, 12 * h),
                  decoration: const BoxDecoration(
                    color: Color(0xFF050304),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black54,
                        blurRadius: 10,
                        offset: Offset(0, -4),
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52 * h,
                    child: ElevatedButton(
                      onPressed: vm.onBookNow,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8A3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(26),
                        ),
                      ),
                      child: const Text(
                        'Book Now',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //TAB CONTENT
  Widget _buildTabContent(EventdetailsViewModel vm) {
    final textStyle = const TextStyle(
      color: Color(0xFFE6D7D0),
      fontSize: 14,
      height: 1.6,
    );

    if (vm.selectedTab == 0) {
      //ABOUT TAB
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            "Organizer ID : FUSION${vm.organizerid}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            maxLines: 2,
            "Organizer Name : ${vm.organizername}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 24),
          Text(vm.aboutText, style: textStyle),
          const SizedBox(height: 24),
          _MapSection(vm: vm),
        ],
      );
    } else {
      /// VENUE TAB
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Venue : ${vm.venueName}",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          Text(maxLines: 2, "Location : ${vm.venueDetails}", style: textStyle),
          const SizedBox(height: 24),
          _MapSection(vm: vm),
        ],
      );
    }
  }

  /// 🔹 SHIMMER UI
  Widget _buildShimmer(BuildContext context) {
    Widget box({double h = 16, double w = double.infinity}) => Container(
      height: h,
      width: w,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Shimmer(
      color: Colors.white,
      colorOpacity: 0.3,
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            color: Colors.white.withOpacity(0.15),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                box(h: 22, w: 200),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(4, (_) => box(h: 46, w: 46)),
                ),
                const SizedBox(height: 24),
                box(),
                const SizedBox(height: 10),
                box(),
                const SizedBox(height: 10),
                box(w: 180),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 🔹 MAP SECTION
class _MapSection extends StatelessWidget {
  final EventdetailsViewModel vm;
  const _MapSection({required this.vm});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location In Map",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: vm.openMap,
          child: Container(
            height: 260,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                image: AssetImage(Assets.images.fusionmap.path),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF050304).withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Icon(Icons.map_rounded, color: Colors.white),
                    SizedBox(width: 6),
                    Text(
                      'Open in Google Maps',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 🔹 INFO CHIP
class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            color: const Color(0xFF181012),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: const Color(0xFFFF8A3D)),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xFFE6D7D0), fontSize: 11),
        ),
      ],
    );
  }
}

/// 🔹 TAB BUTTON
class _TabButton extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFFFF8A3D) : Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 2,
            width: isSelected ? 40 : 0,
            color: const Color(0xFFFF8A3D),
          ),
        ],
      ),
    );
  }
}
