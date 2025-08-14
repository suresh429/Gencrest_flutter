import 'package:get/get.dart';
import '../data/models/task_model.dart';

class TaskController extends GetxController {
  var tasks = <TaskModel>[].obs;
  var selectedTab = 'All'.obs;

  @override
  void onInit() {
    super.onInit();
    loadTasks();
  }

  void loadTasks() {
    tasks.value = [
      TaskModel(
        title: "Visit Green Valley Farm",
        subtitle: "Farmer Meeting",
        dateLabel: "Today",
        points: 50,
        status: "Pending",
        isToday: true,
      ),
      TaskModel(
        title: "Product Demo at Sunrise Agro",
        subtitle: "Product Demo",
        dateLabel: "Tomorrow",
        points: 40,
        status: "In Progress",
      ),
      TaskModel(
        title: "Complete Sales Report",
        subtitle: "Office Work",
        dateLabel: "Yesterday",
        points: 30,
        status: "Completed",
      ),
    ];
  }

  List<TaskModel> get filteredTasks {
    if (selectedTab.value == 'All') {
      return tasks;
    } else {
      return tasks.where((t) => t.status == selectedTab.value).toList();
    }
  }

  int get totalTasks => tasks.length;
  int get completedTasks =>
      tasks.where((t) => t.status == "Completed").length;
  double get progressPercent =>
      totalTasks == 0 ? 0 : completedTasks / totalTasks;
}
