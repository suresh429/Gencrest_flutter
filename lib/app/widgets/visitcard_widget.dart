import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../pages/roles/mdo/mdo_visit_details.dart';

class VisitCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String? time;
  final String? location;
  final String priority;
  final Color priorityColor;

  const VisitCard({
    required this.title,
    required this.subtitle,
    this.time,
    this.location,
    required this.priority,
    required this.priorityColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Row
            Row(
              children: [
                const Icon(Icons.circle, color: Color(0xFF8C43F7), size: 12),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                  decoration: BoxDecoration(
                    color: priorityColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    priority,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 15)),
            const SizedBox(height: 9),

            // Time & Location
            Row(
              children: [
                if (time != null) ...[
                  const Icon(Icons.access_time_rounded, color: Colors.black38, size: 19),
                  const SizedBox(width: 6),
                  Text(time!, style: const TextStyle(color: Colors.black54)),
                ],
                if (location != null) ...[
                  const SizedBox(width: 22),
                  const Icon(Icons.location_on, color: Colors.black38, size: 19),
                  const SizedBox(width: 6),
                  Text(location!, style: const TextStyle(color: Colors.black54)),
                ],
              ],
            ),
            const SizedBox(height: 11),

            const Divider(color: Color(0xFFE9E9E9), thickness: 1),
            const SizedBox(height: 11),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF8C43F7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      Get.to(MdoVisitDetailsPage());
                    },
                    child: const Text(
                      'Start Visit',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Reschedule',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
