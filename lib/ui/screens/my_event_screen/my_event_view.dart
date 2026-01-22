import 'package:flutter/material.dart';
import 'package:fusion_festa/models/eventlist.dart';
import 'package:fusion_festa/ui/screens/my_event_screen/my_event_viewmodel.dart';
import 'package:stacked/stacked.dart';

class MyEventView extends StatelessWidget {
  const MyEventView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MyEventViewmodel>.reactive(
      viewModelBuilder: () => MyEventViewmodel(),
      onViewModelReady: (viewModel) {
        viewModel.init();
      },
      builder:
          (BuildContext context, MyEventViewmodel viewModel, Widget? child) {
            final size = MediaQuery.of(context).size;
            if (!viewModel.isBusy && viewModel.events.isEmpty) {
              return const Center(
                child: Text(
                  'No events created yet',
                  style: TextStyle(color: Colors.white54),
                ),
              );
            }

            return Scaffold(
              backgroundColor: const Color(0xFF0D0606),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                title: const Text(
                  'My Events',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                centerTitle: true,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: viewModel.events.length,
                      itemBuilder: (context, index) {
                        final offset = 40.0 * (index + 1);
                        final event = viewModel.events[index];

                        return TweenAnimationBuilder<double>(
                          tween: Tween(begin: 1, end: 0),
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOut,
                          builder: (context, value, child) {
                            return Transform.translate(
                              offset: Offset(0, offset * value),
                              child: Opacity(opacity: 1 - value, child: child),
                            );
                          },
                          child: _buildMyEventCard(
                            context,
                            size,
                            event,
                            viewModel,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
    );
  }

  Widget _buildMyEventCard(
    BuildContext context,
    Size size,
    EventListModel events,
    MyEventViewmodel vm,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF181012),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Event image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.network(
              events.imageUrl,
              height: 270,
              width: double.infinity,
              fit: BoxFit.fill,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  height: 190,
                  color: const Color(0xFF2E2221),
                  child: const Center(
                    child: CircularProgressIndicator(color: Color(0xFFFF8A3D)),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 190,
                  color: const Color(0xFF2E2221),
                  child: const Center(
                    child: Icon(
                      Icons.image_not_supported,
                      color: Color(0xFFB7A9A6),
                      size: 40,
                    ),
                  ),
                );
              },
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title + tag
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        events.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0x33FF8A3D),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        events.category,
                        style: TextStyle(
                          color: Color(0xFFFF8A3D),
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Date
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today_outlined,
                      color: Color(0xFFB7A9A6),
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      "${events.startAt.day}/${events.startAt.month}/${events.startAt.year}",
                      style: TextStyle(color: Color(0xFFB7A9A6), fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 4),

                // Location
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Color(0xFFB7A9A6),
                      size: 14,
                    ),
                    SizedBox(width: 6),
                    Text(
                      events.venue,
                      style: TextStyle(color: Color(0xFFB7A9A6), fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 15),

                // Delete button
                GestureDetector(
                  onTap: () async {
                    final confirm = await showDialog<bool>(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: const Text('Delete Event'),
                        content: const Text(
                          'Are you sure you want to delete this event?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context, false),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context, true),
                            child: const Text('Delete'),
                          ),
                        ],
                      ),
                    );

                    if (confirm == true) {
                      await vm.deleteEvent(events.id);
                    }
                  },
                  child: Container(
                    height: size.height * 0.05,
                    decoration: BoxDecoration(
                      color: const Color(0x33FF8A3D),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.delete,
                            size: 18,
                            color: Color(0xFFFF8A3D),
                          ),
                          SizedBox(width: 6),
                          Text(
                            "Delete",
                            style: TextStyle(
                              color: Color(0xFFFF8A3D),
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
