import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String name;
  final String location;
  final VoidCallback? onNotificationTap;
  final VoidCallback? onMenuTap;

  const GradientAppBar({
    super.key,
    required this.name,
    required this.location,
    this.onNotificationTap,
    this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF9434e7), Color(0xFFdb2778)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
      ),
      title: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor: Colors.grey.withValues(alpha: 0.3),
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                location,
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
          const Spacer(),

          // ✅ Show notification only if onNotificationTap is not null
          if (onNotificationTap != null)
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: onNotificationTap,
            ),

          // ✅ Optional menu button
          if (onMenuTap != null)
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: onMenuTap,
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
