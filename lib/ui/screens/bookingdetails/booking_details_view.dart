import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/bookingdetails/booking_details_view_model.dart';
import 'package:stacked/stacked.dart';

class BookingDetailsView extends StatelessWidget {
  const BookingDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BookingDetailsViewModel>.reactive(
      viewModelBuilder: () {
        return BookingDetailsViewModel();
      },
      builder:
          (
            BuildContext context,
            BookingDetailsViewModel viewModel,
            Widget? child,
          ) {
            return Scaffold(appBar: AppBar(title: Text("Booking")));
          },
    );
  }
}
