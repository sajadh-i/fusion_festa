import 'dart:async';

import 'package:fusion_festa/app/utils.dart';
import 'package:fusion_festa/models/eventlist.dart';
import 'package:stacked/stacked.dart';

class MyEventViewmodel extends BaseViewModel {
  StreamSubscription? _subscription;
  List<EventListModel> _events = [];

  List<EventListModel> get events => _events;
  void init() {
    setBusy(true);

    _subscription = eventservice.streamMyEvents().listen((data) {
      _events = data;
      setBusy(false);
      notifyListeners();
    });
  }

  Future<void> deleteEvent(String eventId) async {
    try {
      await eventservice.deleteEvent(eventId);
    } catch (e) {
      dialogService.showDialog(
        title: 'Delete failed',
        description: 'Unable to delete event. Try again.',
      );
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
