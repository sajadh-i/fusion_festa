import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:fusion_festa/models/eventlist.dart';
import 'package:stacked/stacked.dart';

class EventScreenViewModel extends BaseViewModel {
  // final EventService _eventService = EventService();
  StreamSubscription? _subscription;

  int selectedFilterIndex = 0;
  bool listVisible = false;

  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';

  List<EventListModel> _allEvents = [];

  List<EventListModel> get events {
    List<EventListModel> filtered = _allEvents;

    if (selectedFilterIndex != 0) {
      final categoryMap = {1: 'Dance', 2: 'Music', 3: 'Festival', 4: 'Ritual'};
      filtered = filtered
          .where((e) => e.category == categoryMap[selectedFilterIndex])
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      filtered = filtered.where((e) {
        return e.title.toLowerCase().contains(q) ||
            e.venue.toLowerCase().contains(q) ||
            e.category.toLowerCase().contains(q);
      }).toList();
    }

    return filtered;
  }

  void init() {
    _subscription = eventservice.streamAllEvents().listen((data) {
      _allEvents = data;
      notifyListeners();
    });

    Future.delayed(const Duration(milliseconds: 150), () {
      listVisible = true;
      notifyListeners();
    });
  }

  void onevettap(String eventid) {
    navigationService.navigateTo(
      Routes.eventdetailsView,
      arguments: EventdetailsViewArguments(eventId: eventid),
    );
  }

  // 🔍 ONLY this updates search
  void onSearchChanged(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void onFilterChanged(int index) {
    selectedFilterIndex = index;
    notifyListeners();
  }

  @override
  void dispose() {
    searchController.dispose();
    _subscription?.cancel();
    super.dispose();
  }
}
