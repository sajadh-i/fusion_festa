import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:fusion_festa/models/event_request_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';

class AdminViewModel extends BaseViewModel {
  List<EventRequest> _requests = [];
  StreamSubscription? _sub;

  List<EventRequest> get requests =>
      _requests.where((e) => e.status == 'pending').toList();

  int get pendingCount => _requests.where((e) => e.status == 'pending').length;

  int get approvedCount =>
      _requests.where((e) => e.status == 'approved').length;

  int get rejectedCount =>
      _requests.where((e) => e.status == 'rejected').length;

  void init() {
    _sub = adminservice.allEventsStream().listen(_mapEvents);
  }

  void _mapEvents(QuerySnapshot snapshot) {
    _requests = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;

      return EventRequest(
        id: doc.id,
        imageUrl: data['imageUrl'] ?? '',
        tag: data['category'] ?? '',
        status: data['status'] ?? 'pending',
        title: data['title'] ?? '',
        organizer: data['organizerName'] ?? '',
        dateText: _formatDate(data['startAt']),
      );
    }).toList();

    notifyListeners();
  }

  Future<void> adminLogout() async {
    setBusy(true);
    try {
      //admin logout
      await authservice.logout();

      // Clear admin-specific local state
      final prefs = await SharedPreferences.getInstance();

      // If admin logs out  onboarding can be shown again
      // Useful when same device switches between admin & user
      await prefs.setBool('onboarding_done', false);

      /// Clear notification preferences if admin-only
      await prefs.remove('notifications_enabled');

      // Navigate to Login & clear stack
      navigationService.clearStackAndShow(Routes.loginView);
    } catch (e) {
      dialogService.showDialog(
        title: 'Logout Failed',
        description: 'Something went wrong. Please try again.',
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> acceptRequest(String id) async {
    await adminservice.approveEvent(id);
  }

  Future<void> rejectRequest(String id) async {
    await adminservice.rejectEvent(id);
  }

  String _formatDate(Timestamp? ts) {
    if (ts == null) return '';
    final d = ts.toDate();
    return '${d.day}/${d.month}/${d.year}';
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}
