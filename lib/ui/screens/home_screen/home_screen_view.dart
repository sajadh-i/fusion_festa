import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/gen/fonts.gen.dart';
import 'package:fusion_festa/ui/screens/home_screen/home_screen_view_model.dart';
import 'package:fusion_festa/ui/widgets/custom_carosel.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreenView extends StatelessWidget {
  final VoidCallback? onGoToEvents;
  const HomeScreenView({super.key, this.onGoToEvents});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeScreenViewModel>.reactive(
      viewModelBuilder: () => HomeScreenViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) {
        final size = MediaQuery.of(context).size;
        final padding = size.width * 0.06;

        return Scaffold(
          backgroundColor: const Color(0xFF050814),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    _buildHeader(context, size),
                    SizedBox(height: size.height * 0.02),
                    // Create Event Button
                    _buildCreateButton(context, size, viewModel),

                    SizedBox(height: size.height * 0.02),
                    FusionCarousel(images: viewModel.carouselImages),
                    SizedBox(height: size.height * 0.02),
                    // Nearby Events Map
                    _buildFestivalCalendar(size, viewModel),

                    SizedBox(height: size.height * 0.025),

                    _buildNearbyMap(context, size, viewModel),

                    SizedBox(height: size.height * 0.025),

                    // Fusion Feed
                    _buildFusionFeed(context, size, viewModel),

                    SizedBox(height: size.height * 0.025),

                    _buildThoughtWall(size, viewModel),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, Size size) {
    return Row(
      children: [
        Container(
          height: size.width * 0.12,
          width: size.width * 0.12,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF1F6AFF), Color(0xFF4D9FFF)],
            ),
          ),
          child: const Icon(Icons.explore, color: Colors.white, size: 24),
        ),
        SizedBox(width: size.width * 0.04),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Explore Kerala',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                'Cultural events',
                style: TextStyle(color: Color(0xFFB7A9A6), fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildThoughtWall(Size size, HomeScreenViewModel vm) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'User Experiences',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: size.height * 0.01),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF101727),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.image, color: Color(0xFFFF8A3D)),
                onPressed: vm.pickImage,
              ),
              Expanded(
                child: TextField(
                  controller: vm.reviewcontroller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Share your experience...',
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Color(0xFFFF8A3D)),
                onPressed: vm.submitReview,
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        ...vm.reviews.map((doc) {
          return _buildThoughtCard(doc: doc, vm: vm);
        }).toList(),
      ],
    );
  }

  Widget _buildThoughtCard({
    required QueryDocumentSnapshot doc,
    required HomeScreenViewModel vm,
  }) {
    final data = doc.data() as Map<String, dynamic>;
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final likedBy = List<String>.from(data['likedBy'] ?? []);
    final isLiked = likedBy.contains(uid);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF101727),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                data['userName'],
                style: const TextStyle(color: Colors.white),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Colors.white),
                itemBuilder: (_) => [
                  const PopupMenuItem(value: 'delete', child: Text("Delete")),
                ],
                onSelected: (_) => vm.deleteReview(doc.id),
              ),
            ],
          ),

          const SizedBox(height: 8),

          if ((data['text'] ?? '').isNotEmpty)
            Text(
              data['text'],
              style: const TextStyle(color: Color(0xFFB7A9A6)),
            ),

          if (data['imageUrl'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(data['imageUrl']),
              ),
            ),

          const SizedBox(height: 10),

          Row(
            children: [
              IconButton(
                icon: Icon(
                  isLiked ? Icons.favorite : Icons.favorite_border,
                  color: isLiked ? Colors.red : Colors.white,
                ),
                onPressed: () => vm.toggleLike(doc.id, isLiked),
              ),
              Text(
                '${data['likeCount'] ?? 0}',
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCreateButton(
    BuildContext context,
    Size size,
    HomeScreenViewModel viewModel,
  ) {
    return SizedBox(
      height: size.height * 0.06,
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          viewModel.addevent();
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Create Cultural Event',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF8A3D),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          elevation: 8,
        ),
      ),
    );
  }

  Widget _buildFestivalCalendar(Size size, HomeScreenViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Festival Calendar',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: size.height * 0.01),

        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF101727),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TableCalendar(
            firstDay: DateTime.utc(2020),
            lastDay: DateTime.utc(2030),

            focusedDay: viewModel.selectedDay,

            selectedDayPredicate: (day) =>
                isSameDay(day, viewModel.selectedDay),

            onDaySelected: (selectedDay, focusedDay) {
              viewModel.selectDate(selectedDay);
            },

            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: TextStyle(color: Colors.white),
              leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
              rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
            ),

            eventLoader: (day) {
              return viewModel.events.where((e) {
                final date = (e['startAt'] as Timestamp).toDate();
                return date.year == day.year &&
                    date.month == day.month &&
                    date.day == day.day;
              }).toList();
            },

            calendarStyle: const CalendarStyle(
              defaultTextStyle: TextStyle(color: Colors.white),
              weekendTextStyle: TextStyle(color: Colors.orange),
              todayDecoration: BoxDecoration(
                color: Color(0xFFFF8A3D),
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Color(0xFF4D9FFF),
                shape: BoxShape.circle,
              ),
            ),

            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, day, events) {
                if (events.isNotEmpty) {
                  return Positioned(
                    bottom: 4,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF8A3D),
                        shape: BoxShape.circle,
                      ),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
        ),
        if (viewModel.selectedEvents.isNotEmpty) ...[
          SizedBox(height: 12),
          ...viewModel.selectedEvents.map((event) {
            return Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF101727),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event['title'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    event['venue']['name'] ?? '',
                    style: const TextStyle(color: Color(0xFFB7A9A6)),
                  ),
                ],
              ),
            );
          }),
        ],
      ],
    );
  }

  Widget _buildNearbyMap(
    BuildContext context,
    Size size,
    HomeScreenViewModel viewModel,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nearby Events',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: size.height * 0.01),

        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF101727),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              ...viewModel.events.take(3).map((doc) {
                final data = doc.data() as Map<String, dynamic>;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFFFF8A3D)),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          data['title'] ?? 'Event',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                );
              }),

              const SizedBox(height: 10),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Later you can open Google Maps screen
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFFF8A3D)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'View on Map',
                    style: TextStyle(color: Color(0xFFFF8A3D)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFusionFeed(
    BuildContext context,
    Size size,
    HomeScreenViewModel viewModel,
  ) {
    final latestEvents = viewModel.events.take(3).toList(); // only 3 items

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Fusion Feed',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: onGoToEvents,
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFFFF8A3D),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.015),

        SizedBox(
          height: size.height * 0.32,
          child: latestEvents.isEmpty
              ? const Center(
                  child: Text(
                    "No events yet",
                    style: TextStyle(color: Colors.white70),
                  ),
                )
              : ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: latestEvents.length,
                  separatorBuilder: (_, __) =>
                      SizedBox(width: size.width * 0.04),
                  itemBuilder: (context, index) {
                    final data =
                        latestEvents[index].data() as Map<String, dynamic>;

                    return _buildFeedCard(
                      context: context,
                      imageUrl: data['imageUrl'] ?? '',
                      title: data['title'] ?? 'Untitled',
                      subtitle: data['category'] ?? 'Event',
                      liked: false,
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildFeedCard({
    required BuildContext context,
    required String imageUrl,
    required String title,
    required String subtitle,
    required bool liked,
  }) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.87,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Color(0xFFB7A9A6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
