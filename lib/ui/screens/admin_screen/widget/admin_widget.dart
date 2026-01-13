import 'package:flutter/material.dart';
import 'package:fusion_festa/models/event_request_model.dart';
import 'package:fusion_festa/ui/screens/admin_screen/admin_view_model.dart';

class StatusCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final int count;

  const StatusCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.all(size.width * 0.035),
      decoration: BoxDecoration(
        color: const Color(0xFF101727),
        borderRadius: BorderRadius.circular(18),
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
          Row(
            children: [
              Icon(icon, color: iconColor, size: 18),
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(color: Color(0xFFB7C0D8), fontSize: 13),
              ),
            ],
          ),
          const Spacer(),
          Text(
            '$count',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedRequestCard extends StatelessWidget {
  final int delay;
  final EventRequest request;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const AnimatedRequestCard({
    required this.delay,
    required this.request,
    required this.onAccept,
    required this.onReject,
  });

  Color get tagColor {
    switch (request.tag.toLowerCase()) {
      case 'theyyam':
        return const Color(0xFFFF8A3D);
      case 'kathakali':
        return const Color(0xFF46C980);
      default:
        return const Color(0xFF4D9FFF);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 1, end: 0),
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,

      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 16 * value),
          child: Opacity(opacity: 1 - value, child: child),
        );
      },
      child: RequestCard(
        request: request,
        tagColor: tagColor,
        onAccept: onAccept,
        onReject: onReject,
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  final EventRequest request;
  final Color tagColor;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const RequestCard({
    required this.request,
    required this.tagColor,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: EdgeInsets.only(bottom: size.height * 0.018),
      decoration: BoxDecoration(
        color: const Color(0xFF101727),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            blurRadius: 12,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(size.width * 0.035),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Image.network(
                    request.imageUrl,
                    height: size.width * 0.18,
                    width: size.width * 0.18,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: size.width * 0.035),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: tagColor.withOpacity(0.18),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              request.tag,
                              style: TextStyle(
                                color: tagColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          // Text(
                          //   request.timeAgo,
                          //   style: const TextStyle(
                          //     color: Color(0xFF858FA9),
                          //     fontSize: 11,
                          //   ),
                          // ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        request.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        request.organizer,
                        style: const TextStyle(
                          color: Color(0xFF858FA9),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            size: 14,
                            color: Color(0xFF858FA9),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            request.dateText,
                            style: const TextStyle(
                              color: Color(0xFF858FA9),
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
          const Divider(height: 1, color: Color(0xFF151E30)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.035,
              vertical: size.height * 0.012,
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: onReject,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF262F43)),
                      backgroundColor: const Color(0xFF101727),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        color: Color(0xFFE85C5C),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: size.width * 0.03),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1F6AFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 6,
                      shadowColor: const Color(0xFF1F6AFF).withOpacity(0.6),
                    ),
                    child: const Text(
                      'Accept',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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
