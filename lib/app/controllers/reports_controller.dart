import 'package:get/get.dart';

class ReportsController extends GetxController {
  var thisMonthPoints = 420.obs;
  var successRate = 92.obs;

  var weeklyActivity = [5, 7, 3, 8, 6, 4, 9].obs; // placeholder for chart

  var achievements = [
    {
      "icon": "🏆",
      "title": "Task Master",
      "subtitle": "Completed 10 tasks in a row",
      "color": 0xFF9E9E9E
    },
    {
      "icon": "📍",
      "title": "Location Champion",
      "subtitle": "Perfect location tracking for 7 days",
      "color": 0xFF9E9E9E
    }
  ].obs;
}
