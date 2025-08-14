import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/models/team_member.dart';

class TsmDashboardController extends GetxController {
  var teamMembers = <TeamMember>[
    TeamMember(
        name: "Rajesh Kumar",
        status: "Active - Green Valley",
        isActive: true,
        progress: 85),
    TeamMember(
        name: "Priya Sharma",
        status: "Location Disabled",
        isActive: false,
        progress: 23),
  ].obs;
}