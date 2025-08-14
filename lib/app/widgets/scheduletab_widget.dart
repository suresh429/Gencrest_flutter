import 'package:flutter/material.dart';

class ScheduleTab extends StatelessWidget {
  final String title;
  final bool selected;
  const ScheduleTab({required this.title, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 21),
      decoration: BoxDecoration(
        color: selected ? const Color(0xFF8C43F7) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE9E9E9)),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black87,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
