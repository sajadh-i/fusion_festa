import 'package:flutter/material.dart';
import 'package:fusion_festa/ui/screens/ticketselectionScreen/ticketselection_view_model.dart';
import 'package:stacked/stacked.dart';

class TicketselectionView extends StatelessWidget {
  final String eventId;
  const TicketselectionView({super.key, required this.eventId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TicketselectionViewModel>.reactive(
      viewModelBuilder: () => TicketselectionViewModel(eventId: eventId),
      onViewModelReady: (viewModel) {
        viewModel.init();
      },
      builder: (context, viewModel, child) {
        if (viewModel.isBusy || viewModel.event == null) {
          return const Scaffold(
            backgroundColor: Color(0xFF0D0606),
            body: Center(
              child: CircularProgressIndicator(color: Color(0xFFFF8A3D)),
            ),
          );
        }
        final size = MediaQuery.of(context).size;
        final padding = size.width * 0.05;

        return Scaffold(
          backgroundColor: const Color(0xFF0D0606),
          appBar: AppBar(
            backgroundColor: const Color(0xFF141010),
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: const Text(
              'Select your ticket',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              // physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.02),

                    _AnimatedSlideFade(
                      delay: 0,
                      child: _DateCard(size: size, vm: viewModel),
                    ),

                    SizedBox(height: size.height * 0.03),

                    const Text(
                      'Select Your Tickets',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),

                    _AnimatedSlideFade(
                      delay: 100,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: viewModel.event!.tickets.length,
                        itemBuilder: (context, index) {
                          final tier = viewModel.event!.tickets[index];
                          final qty = viewModel.selectedQty[tier.id] ?? 0;
                          return _TicketCard(
                            title: tier.name,
                            availabileseat:
                                '${viewModel.availableSeats(tier)} seats available',
                            price: tier.price.toInt(),
                            statusLabel: viewModel.availableSeats(tier) < 10
                                ? 'Selling Fast'
                                : 'Available',
                            statusColor: viewModel.availableSeats(tier) < 10
                                ? const Color(0xFFFF8A3D)
                                : const Color(0xFF46C980),
                            count: qty,
                            onAdd: () => viewModel.increment(tier.id),
                            onRemove: () => viewModel.decrement(tier.id),
                            enabled: viewModel.availableSeats(tier) > 0,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),

                    _AnimatedSlideFade(
                      delay: 400,
                      child: const Text(
                        'Your Booking Summary',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.015),

                    _AnimatedSlideFade(
                      delay: 450,
                      child: _SummaryCard(viewModel: viewModel),
                    ),

                    SizedBox(height: size.height * 0.11),
                  ],
                ),
              ),
            ),
          ),

          bottomNavigationBar: _AnimatedSlideFade(
            delay: 500,
            fromBottom: true,
            child: Container(
              padding: EdgeInsets.fromLTRB(
                padding,
                size.height * 0.015,
                padding,
                size.height * 0.02,
              ),
              decoration: const BoxDecoration(
                color: Color(0xFF141010),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 12,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Grand Total',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFFB7A9A6),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '₹${viewModel.grandTotal.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF46C980),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.06,
                      child: ElevatedButton(
                        onPressed: viewModel.canProceed
                            ? viewModel.onProceedToPayment
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF8A3D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 12,
                          shadowColor: const Color(0xFFFF8A3D).withOpacity(0.6),
                        ),
                        child: const Text(
                          'Proceed to Payment',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
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

/// animation wrapper
class _AnimatedSlideFade extends StatelessWidget {
  final Widget child;
  final int delay;
  final bool fromBottom;

  const _AnimatedSlideFade({
    required this.child,
    this.delay = 0,
    this.fromBottom = false,
  });

  @override
  Widget build(BuildContext context) {
    final offsetStart = fromBottom ? 24.0 : 14.0;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,

      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, offsetStart * value),
          child: Opacity(opacity: 1 - value, child: child),
        );
      },
      child: child,
    );
  }
}

/// date card (dark theme)
class _DateCard extends StatelessWidget {
  final Size size;
  final TicketselectionViewModel vm;

  const _DateCard({required this.size, required this.vm});

  @override
  Widget build(BuildContext context) {
    final start = vm.event!.startAt;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFF181012),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.6),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: size.width * 0.14,
            width: size.width * 0.14,
            decoration: BoxDecoration(
              color: const Color(0xFF1E2A22),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.calendar_today_rounded,
              color: Color(0xFF46C980),
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${start.day}/${start.month}/${start.year} • '
                  '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  vm.event!.venueName,
                  style: TextStyle(fontSize: 13, color: Color(0xFFB7A9A6)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// ticket card (dark)
class _TicketCard extends StatelessWidget {
  final String title;
  final String availabileseat;
  final int price;
  final String statusLabel;
  final Color statusColor;
  final int count;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool enabled;

  const _TicketCard({
    required this.title,
    required this.availabileseat,
    required this.price,
    required this.statusLabel,
    required this.statusColor,
    required this.count,
    required this.onAdd,
    required this.onRemove,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFF181012),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: size.width * 0.02),
              _Counter(
                value: count,
                onAdd: enabled ? onAdd : null,
                onRemove: enabled ? onRemove : null,
              ),
            ],
          ),
          SizedBox(height: size.height * 0.007),
          Text(
            availabileseat,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFFB7A9A6),
              height: 1.3,
            ),
          ),
          SizedBox(height: size.height * 0.012),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '₹${price.toStringAsFixed(0)}.00',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFFE0B2),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Counter extends StatelessWidget {
  final int value;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  const _Counter({required this.value, this.onAdd, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final btnSize = size.width * 0.1;

    Widget _circleButton(IconData icon, VoidCallback? onTap) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(btnSize / 2),
        child: Container(
          height: btnSize,
          width: btnSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF3A2A29)),
            color: const Color(0xFF141010),
          ),
          child: Icon(
            icon,
            size: 18,
            color: onTap == null ? const Color(0xFF5D4D4B) : Colors.white,
          ),
        ),
      );
    }

    return Row(
      children: [
        _circleButton(Icons.remove, onRemove),
        SizedBox(width: size.width * 0.02),
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        SizedBox(width: size.width * 0.02),
        _circleButton(Icons.add, onAdd),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final TicketselectionViewModel viewModel;

  const _SummaryCard({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: const Color(0xFF181012),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          for (final tier in viewModel.event!.tickets)
            if ((viewModel.selectedQty[tier.id] ?? 0) > 0)
              _summaryRow(
                '${tier.name} (x${viewModel.selectedQty[tier.id]})',
                tier.price * (viewModel.selectedQty[tier.id] ?? 0),
              ),

          Divider(color: Colors.white.withOpacity(0.12)),

          _summaryRow('Subtotal', viewModel.subTotal, muted: true),
          _summaryRow('Taxes & Fees', viewModel.fees, muted: true),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, num value, {bool muted = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: muted ? const Color(0xFFB7A9A6) : Colors.white,
          ),
        ),
        Text(
          '₹${value.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: muted ? const Color(0xFFB7A9A6) : Colors.white,
          ),
        ),
      ],
    );
  }
}
