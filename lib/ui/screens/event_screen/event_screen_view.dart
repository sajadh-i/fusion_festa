import 'package:flutter/material.dart';
import 'package:fusion_festa/models/eventlist.dart';
import 'package:fusion_festa/ui/screens/event_screen/event_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class EventScreenView extends StatelessWidget {
  const EventScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventScreenViewModel>.reactive(
      viewModelBuilder: () => EventScreenViewModel(),
      onViewModelReady: (vm) => vm.init(),
      builder: (context, viewModel, child) {
        final size = MediaQuery.of(context).size;

        return Scaffold(
          backgroundColor: const Color(0xFF0D0606),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),

                  const Text(
                    'Discover Kerala\'s Culture',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _SearchBar(
                    controller: viewModel.searchController,
                    onChanged: viewModel.onSearchChanged,
                  ),

                  const SizedBox(height: 16),

                  _FilterRow(
                    selectedIndex: viewModel.selectedFilterIndex,
                    onChanged: viewModel.onFilterChanged,
                  ),

                  const SizedBox(height: 16),

                  Expanded(
                    child: viewModel.events.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  color: Colors.white.withOpacity(0.3),
                                  size: 64,
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  'No events found',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.6),
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : AnimatedOpacity(
                            opacity: viewModel.listVisible ? 1 : 0,
                            duration: const Duration(milliseconds: 400),
                            child: ListView.builder(
                              padding: EdgeInsets.only(
                                bottom: size.height * 0.12,
                              ),
                              itemCount: viewModel.events.length,
                              itemBuilder: (context, index) {
                                final event = viewModel.events[index];
                                return AnimatedSlide(
                                  duration: const Duration(milliseconds: 350),
                                  curve: Curves.easeOut,
                                  offset: viewModel.listVisible
                                      ? Offset.zero
                                      : const Offset(0, 0.1),
                                  child: _EventCard(
                                    event: event,
                                    onTap: () {
                                      viewModel.onevettap(event.id);
                                    },
                                  ),
                                );
                              },
                            ),
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
}

/// WIDGETS

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF4A3332)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Color(0xFF4A3332)),
        ),
        border: InputBorder.none,
        prefixIcon: const Icon(Icons.search, color: Color(0xFFB7A9A6)),
        suffixIcon: controller.text.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear, color: Color(0xFFB7A9A6)),
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
              )
            : null,
        hintText: 'Search by event, artist, or location',
        hintStyle: const TextStyle(color: Color(0xFF8F817E), fontSize: 13),
        contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      ),
    );
  }
}

class _FilterRow extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _FilterRow({required this.selectedIndex, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final filters = ['All', 'Dance', 'Music', 'Festivals', 'Ritual'];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(filters.length, (index) {
          final isSelected = index == selectedIndex;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              selected: isSelected,
              label: Text(
                filters[index],
                style: TextStyle(
                  color: isSelected ? Colors.black : const Color(0xFFE2D5D2),
                  fontWeight: FontWeight.w500,
                ),
              ),
              selectedColor: const Color(0xFFFF8A3D),
              backgroundColor: const Color(0xFF1A1111),
              side: BorderSide(
                color: isSelected
                    ? const Color(0xFFFF8A3D)
                    : const Color(0xFF2E2221),
              ),
              onSelected: (_) => onChanged(index),
            ),
          );
        }),
      ),
    );
  }
}

class _EventCard extends StatelessWidget {
  final EventListModel event;
  final Function()? onTap;
  const _EventCard({required this.event, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            // Image with error handling
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Image.network(
                event.imageUrl,
                height: 270,
                width: double.infinity,
                fit: BoxFit.fill,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 190,
                    color: const Color(0xFF2E2221),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFFFF8A3D),
                      ),
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
                          event.title,
                          style: const TextStyle(
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
                          event.category,
                          style: const TextStyle(
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
                      const Icon(
                        Icons.calendar_today_outlined,
                        color: Color(0xFFB7A9A6),
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        '${event.startAt.day}/${event.startAt.month}/${event.startAt.year}',
                        style: const TextStyle(
                          color: Color(0xFFB7A9A6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Location
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        color: Color(0xFFB7A9A6),
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        event.venue,
                        style: const TextStyle(
                          color: Color(0xFFB7A9A6),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
