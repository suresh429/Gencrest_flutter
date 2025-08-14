import 'package:gencrest/app/controllers/reports_controller.dart';
import 'package:gencrest/app/controllers/task_controller.dart';
import 'package:gencrest/app/controllers/tsm_dashboard_controller.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/data_controller.dart';
import '../controllers/liquidation_controller.dart';
import '../controllers/mdo_schedule_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => DataController());
    Get.lazyPut(() => MDOScheduleController());
    Get.lazyPut(() => TaskController());
    Get.lazyPut(() => ReportsController());
    Get.lazyPut(() => LiquidationController());
    Get.lazyPut(() => TsmDashboardController());
  }
}
