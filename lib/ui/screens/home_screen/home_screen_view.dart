import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fusion_festa/constants/assets.gen.dart';
import 'package:fusion_festa/gen/fonts.gen.dart';
import 'package:fusion_festa/ui/screens/home_screen/home_screen_view_model.dart';
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

                    // Nearby Events Map
                    _buildFestivalCalendar(size, viewModel),

                    SizedBox(height: size.height * 0.025),
                    // _buildFestivalCalendar(size, viewModel),
                    _buildNearbyMap(context, size, viewModel),

                    SizedBox(height: size.height * 0.025),

                    // Fusion Feed
                    _buildFusionFeed(context, size, viewModel),

                    // SizedBox(height: size.height * 0.02),
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
              Expanded(
                child: TextField(
                  controller: vm.reviewcontroller,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: 'Share your experience...',
                    hintStyle: TextStyle(color: Color(0xFFB7A9A6)),
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
          return _buildThoughtCard(
            name: doc.data().toString().contains('userName')
                ? doc['userName']
                : 'User',
            message: doc.data().toString().contains('message')
                ? doc['message']
                : '',
          );
        }).toList(),
      ],
    );
  }

  Widget _buildThoughtCard({required String name, required String message}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF101727),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(message, style: const TextStyle(color: Color(0xFFB7A9A6))),
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
            focusedDay: DateTime.now(),
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
            ),
          ),
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Nearby Events Map',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Kochi',
                style: TextStyle(
                  color: Color(0xFFFF8A3D),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.01),

        Container(
          height: size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color(0xFF101727),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FlutterMap(
              options: const MapOptions(
                initialCenter: LatLng(9.9312, 76.2673), // Kochi
                initialZoom: 12,
                interactionOptions: InteractionOptions(
                  flags: InteractiveFlag.all,
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.fusion_festa',
                ),

                MarkerLayer(
                  markers: viewModel.events
                      .map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final venue = data['venue'];

                        if (venue == null ||
                            venue['lat'] == null ||
                            venue['lng'] == null) {
                          return null;
                        }

                        return Marker(
                          point: LatLng(venue['lat'], venue['lng']),
                          width: 40,
                          height: 40,
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.red,
                          ),
                        );
                      })
                      .whereType<Marker>()
                      .toList(),
                ),
              ],
            ),
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
          // Positioned(
          //   top: 12,
          //   right: 12,
          //   child: GestureDetector(
          //     onTap: () {}, // viewModel.toggleLike
          //     child: Container(
          //       padding: const EdgeInsets.all(8),
          //       decoration: BoxDecoration(
          //         color: Colors.black.withOpacity(0.6),
          //         shape: BoxShape.circle,
          //       ),
          //       child: Icon(
          //         liked ? Icons.favorite : Icons.favorite_border,
          //         color: liked ? Colors.red : Colors.white,
          //         size: 20,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
