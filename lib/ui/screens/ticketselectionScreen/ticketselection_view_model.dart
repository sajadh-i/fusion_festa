import 'package:firebase_auth/firebase_auth.dart';
import 'package:fusion_festa/app/app.router.dart';
import 'package:fusion_festa/app/utils.dart';
import 'package:fusion_festa/models/eventdetails.dart';
import 'package:fusion_festa/models/tickettiermodel.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:stacked/stacked.dart';

class TicketselectionViewModel extends BaseViewModel {
  final String eventId;
  TicketselectionViewModel({required this.eventId});

  //event data
  EventDetailsModel? event;
  //this have selected quantity per ticket tier
  Map<String, int> selectedQty = {};
  //payment initilization
  late Razorpay _razorpay;
  //priCe caluculation
  //total ticket price without fees
  double get subTotal => totalAmount;
  //platform fee 5%
  double get fees => totalAmount * 0.05;
  //user see on the ui amount
  double get grandTotal => subTotal + fees;

  double get displayAmount => grandTotal; // real amount
  //dummtpaying amount
  double get paymentAmount => 1; //  ₹1 rs for pay dummy
  //enable payment button only if ticket is selected
  bool get canProceed => totalAmount > 0;

  Future<void> init() async {
    setBusy(true);
    event = await eventservice.getEventById(eventId);

    for (final tier in event!.tickets) {
      selectedQty[tier.id] = 0;
    }

    //razorpayinitilization
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);

    setBusy(false);
  }

  int availableSeats(TicketTierModel tier) {
    return tier.totalSeats - tier.soldSeats;
  }

  void increment(String tierId) {
    final tier = event!.tickets.firstWhere((t) => t.id == tierId);
    final available = tier.totalSeats - tier.soldSeats;

    if ((selectedQty[tierId] ?? 0) >= available) return;

    selectedQty[tierId] = (selectedQty[tierId] ?? 0) + 1;
    notifyListeners();
  }

  void decrement(String tierId) {
    if ((selectedQty[tierId] ?? 0) > 0) {
      selectedQty[tierId] = selectedQty[tierId]! - 1;
      notifyListeners();
    }
  }

  double get totalAmount {
    double sum = 0;
    for (final tier in event!.tickets) {
      sum += tier.price * (selectedQty[tier.id] ?? 0);
    }
    return sum;
  }

  Future<void> onProceedToPayment() async {
    if (!canProceed) return;

    var options = {
      'key': 'rzp_live_ILgsfZCZoFIKMb',
      'amount': paymentAmount * 100, // ₹1  paise
      'currency': 'INR',
      'name': 'Fusion Festa',
      'description': 'Event Ticket Booking',
      'prefill': {
        'email': FirebaseAuth.instance.currentUser?.email ?? '',
        'contact': '9999999999',
      },
    };

    _razorpay.open(options);
  }

  Future<void> _handlePaymentSuccess(PaymentSuccessResponse response) async {
    try {
      setBusy(true);
      final bookingId = await bookingservice.createBooking(
        event: event!,
        selectedQty: selectedQty,
        displayAmount: displayAmount,
        paymentId: response.paymentId!,
      );

      final bookedTickets = event!.tickets
          .where((t) => (selectedQty[t.id] ?? 0) > 0)
          .map(
            (t) => {
              'tierId': t.id,
              'name': t.name,
              'price': t.price,
              'quantity': selectedQty[t.id],
            },
          )
          .toList();
      await localnotificationservice.show(
        title: 'Booking Confirmed 🎫',
        body: 'Your ticket is confirmed for ${event!.title}',
      );

      setBusy(false);
      navigationService.navigateTo(
        Routes.bookingConfirmationView,
        arguments: BookingConfirmationViewArguments(
          bookingId: bookingId,
          eventTitle: event!.title,
          venue: event!.venueName,
          startAt: event!.startAt,
          endAt: event!.endAt,
          totalPaid: displayAmount,
          userId: FirebaseAuth.instance.currentUser!.uid,
          bookedTickets: bookedTickets,
        ),
      );
    } catch (e) {
      dialogService.showDialog(
        title: 'Booking Failed',
        description: e.toString(),
      );
    } finally {
      setBusy(false);
    }
  }

  /// Payment failed
  void _handlePaymentError(PaymentFailureResponse response) {
    dialogService.showDialog(
      title: 'Payment Failed',
      description: response.message ?? 'Please try again',
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
