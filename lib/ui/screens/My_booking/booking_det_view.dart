import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/My_booking/booking_det_view_model.dart';
import 'package:stacked/stacked.dart';

class BookingDetView extends StatelessWidget {
  const BookingDetView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingDetViewModel>.reactive(
      viewModelBuilder: () => BookingDetViewModel(),
      onViewModelReady: (viewModel) => viewModel.initialise(),
      builder: (context, viewModel, child) {
        final size = MediaQuery.of(context).size;

        return Scaffold(
          backgroundColor: Color(0xFF050814),
          appBar: AppBar(
            backgroundColor: Color(0xFF050814),
            elevation: 0,
            foregroundColor: Colors.white,
            title: Text('My Bookings'),
            centerTitle: true,
          ),
          body: SafeArea(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  SizedBox(height: 12),
                  _buildTabBar(size),
                  SizedBox(height: 12),
                  Expanded(child: _buildTabContent(size, viewModel)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabBar(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Color(0xFF101727),
        borderRadius: BorderRadius.circular(40),
      ),
      child: TabBar(
        indicator: BoxDecoration(
          color: Color(0x33FF8A3D),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        labelColor: Color(0xFFFF8A3D),

        unselectedLabelColor: Color(0xFFB7A9A6),
        dividerColor: Colors.transparent,
        tabs: [
          Tab(text: 'Active'),
          Tab(text: 'Past'),
        ],
      ),
    );
  }

  Widget _buildTabContent(Size size, BookingDetViewModel viewModel) {
    return TabBarView(
      children: [
        _buildBookingsList(size, viewModel.activeBookings),
        _buildBookingsList(size, viewModel.pastBookings),
      ],
    );
  }

  Widget _buildBookingsList(Size size, List<Map<String, dynamic>> bookings) {
    if (bookings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.event_busy, color: Colors.white38, size: 70),
              SizedBox(height: 16),
              Text(
                "No bookings yet",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 6),
              Text(
                "You haven’t booked any events.\nExplore events and book your seat!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Color(0xFFB7A9A6), fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final item = bookings[index];
        return _buildBookingCard(
          size,
          imageUrl: item['image'],
          title: item['title'],
          venue: item['venue'],
          dateTime: item['dateTime'],
          status: item['status'],
        );
      },
    );
  }

  Widget _buildBookingCard(
    Size size, {
    required String imageUrl,
    required String title,
    required String venue,
    required String dateTime,
    required String status,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Color(0xFF101727),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
            child: Stack(
              children: [
                Image.network(
                  imageUrl,
                  height: size.height * 0.22,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: size.height * 0.22,
                      color: Colors.grey[900],
                      child: Center(
                        child: Icon(Icons.image, color: Colors.white54),
                      ),
                    );
                  },
                ),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.85),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 14,
                  left: 16,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(venue, style: TextStyle(color: Color(0xFFB7A9A6))),
                SizedBox(height: 6),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      size: 14,
                      color: Color(0xFFB7A9A6),
                    ),
                    SizedBox(width: 6),
                    Text(dateTime, style: TextStyle(color: Color(0xFFB7A9A6))),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0x33FF8A3D),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: Color(0xFFFF8A3D),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF8A3D),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text("View Ticket"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
