class TaskModel {
  final String title;
  final String subtitle;
  final String dateLabel;
  final int points;
  final String status; // Pending, In Progress, Completed
  final bool isToday;

  TaskModel({
    required this.title,
    required this.subtitle,
    required this.dateLabel,
    required this.points,
    required this.status,
    this.isToday = false,
  });
}
