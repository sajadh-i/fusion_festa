// lib/ui/screens/event_details/eventdetails_view_model.dart
import 'package:flutter/material.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:fusion_festa/models/eventdetails.dart';
import 'package:stacked/stacked.dart';
import 'package:url_launcher/url_launcher.dart';

class EventdetailsViewModel extends BaseViewModel {
  final String eventId;

  EventdetailsViewModel({required this.eventId});

  EventDetailsModel? event;
  bool isloading = true;
  int selectedTab = 0;

  bool contentVisible = false;

  Future<void> init() async {
    setBusy(true);
    try {
      Future.delayed(Duration(seconds: 2));
      event = await eventservice.getEventById(eventId);
    } catch (e) {
      debugPrint(e.toString());
    }
    setBusy(false);
    contentVisible = true;
    notifyListeners();
  }

  String get title => event?.title ?? "";
  String get organizername => event?.organizerName ?? "";
  String get organizerid => event?.organizerId ?? "";
  String get imageUrl => event?.imageUrl ?? "";
  String get venueName => event?.venueName ?? "";
  String get venueDetails => event?.venueAddress ?? "";
  String get aboutText => event?.description ?? "";
  String get dateText {
    if (event == null) return '';
    final d = event!.startAt;
    return '${d.day}/${d.month}/${d.year}';
  }

  String get timeText {
    if (event == null) return '';
    final t = event!.startAt;
    return '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
  }

  String get priceRange {
    if (event == null || event!.tickets.isEmpty) return 'Free';

    final prices = event!.tickets
        .map((e) => e.price)
        .where((p) => p > 0)
        .toList();

    if (prices.isEmpty) return 'Free';

    prices.sort();
    return '₹${prices.first.toInt()} – ₹${prices.last.toInt()}';
  }

  void onTabChanged(int index) {
    if (selectedTab == index) return;

    selectedTab = index;
    contentVisible = false;
    notifyListeners();

    Future.delayed(const Duration(milliseconds: 100), () {
      contentVisible = true;
      notifyListeners();
    });
  }

  Future<void> openMap() async {
    // Simple Google Maps search for venue name
    final query = Uri.encodeComponent(event?.venueAddress ?? '');
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$query',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  void onBookNow() {
    navigationService.navigateTo(
      Routes.ticketselectionView,
      arguments: TicketselectionViewArguments(eventId: eventId),
    );
  }
}
