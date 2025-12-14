import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class EventItem {
  final String imagePath;
  final String title;
  final String category;
  final String dateText;
  final String location;

  EventItem({
    required this.imagePath,
    required this.title,
    required this.category,
    required this.dateText,
    required this.location,
  });
}

/// VIEWMODEL
class EventScreenViewModel extends BaseViewModel {
  int selectedFilterIndex = 0;
  bool listVisible = false;

  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  // All events (original data)
  final List<EventItem> _allEvents = [
    EventItem(
      imagePath: "https://c.stocksy.com/a/O3B000/z9/42494.jpg",
      title: 'Thrissur Pooram',
      category: 'Festival',
      dateText: 'April 23, 2024',
      location: 'Thrissur',
    ),
    EventItem(
      imagePath: "https://c.stocksy.com/a/O3B000/z9/42494.jpg",
      title: 'Nishagandhi Dance Festival',
      category: 'Dance',
      dateText: 'May 10, 2024',
      location: 'Thiruvananthapuram',
    ),
    EventItem(
      imagePath: "https://c.stocksy.com/a/O3B000/z9/42494.jpg",
      title: 'Kannur Theyyam Festival',
      category: 'Festival',
      dateText: 'June 5, 2024',
      location: 'Kannur',
    ),
    EventItem(
      imagePath: "https://c.stocksy.com/a/O3B000/z9/42494.jpg",
      title: 'Carnatic Music Concert',
      category: 'Music',
      dateText: 'July 15, 2024',
      location: 'Kochi',
    ),
    EventItem(
      imagePath: "https://c.stocksy.com/a/O3B000/z9/42494.jpg",
      title: 'Traditional Kathakali Performance',
      category: 'Dance',
      dateText: 'August 20, 2024',
      location: 'Ernakulam',
    ),
  ];

  // Filtered events (what's displayed)
  List<EventItem> get events {
    List<EventItem> filtered = _allEvents;

    // Filter by category
    if (selectedFilterIndex != 0) {
      final categoryMap = {1: 'Dance', 2: 'Music', 3: 'Festival'};
      final selectedCategory = categoryMap[selectedFilterIndex];
      filtered = filtered.where((e) => e.category == selectedCategory).toList();
    }

    // Filter by search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((e) {
        final query = searchQuery.toLowerCase();
        return e.title.toLowerCase().contains(query) ||
            e.location.toLowerCase().contains(query) ||
            e.category.toLowerCase().contains(query);
      }).toList();
    }

    return filtered;
  }

  void init() {
    print('EventScreenViewModel init called');
    print('Events count: ${_allEvents.length}');

    // Listen to search changes
    searchController.addListener(() {
      searchQuery = searchController.text;
      notifyListeners();
    });

    Future.delayed(const Duration(milliseconds: 100), () {
      listVisible = true;
      print('List visible set to true');
      notifyListeners();
    });
  }

  void onFilterChanged(int index) {
    print('Filter changed to index: $index');
    selectedFilterIndex = index;
    notifyListeners();
  }

  void onSearchChanged(String query) {
    print('Search query: $query');
    searchQuery = query;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
