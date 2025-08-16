import 'dart:ui';
import 'package:flutter/material.dart';

class Alert {
  final String name;
  final String priority;
  final Color priorityColor;
  final String timeAgo;
  final IconData icon;
  final String description;
  final String category;

  Alert({
    required this.name,
    required this.priority,
    required this.priorityColor,
    required this.timeAgo,
    required this.icon,
    required this.description,
    required this.category,
  });
}
