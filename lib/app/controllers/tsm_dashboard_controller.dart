import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../data/models/team_member.dart';

class TsmDashboardController extends GetxController {
  var isLiveMeetingsExpanded = true.obs; // default expanded

  var liveMeetings = <TeamMember>[
    TeamMember(
      rank: 1,
      name: "Rajesh Kumar",
      status: "Ram Kumar Farm\nGreen Valley, Sector 12",
      isActive: true,
      progress: 25, // meeting duration in mins
      startTime: "10:45 AM",
      avatarLetter: 'R',
      location: 'Green Valley, Sector 12',
    ),
    TeamMember(
      rank: 2,
      name: "Priya Sharma",
      status: "Sunrise Agro Store\nMarket Road, Anand",
      isActive: true,
      progress: 15,
      startTime: "11:20 AM",
      avatarLetter: 'P',
      location: 'Market Road, Anand',
    ),
  ].obs;
}