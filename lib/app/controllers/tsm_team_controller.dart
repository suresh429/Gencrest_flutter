import 'package:get/get.dart';

import '../data/models/team_member.dart';

class TsmTeamController extends GetxController {
  final mainTabs = ["Team Status", "Performance"].obs;
  final tabs = ["All", "Active", "On Visit", "Issues"].obs;
  final subTabs = ["Overall", "Zone Wise", "TSM Wise","MDo Wise"].obs;

  final mainSelectedTab = 0.obs;
  final selectedTab = 0.obs;
  var subSelectedTab = 0.obs;

  void mainSelectTab(int index) {
    mainSelectedTab.value = index;
  }

  void selectTab(int index) {
    selectedTab.value = index;
  }

  void subSelectTab(int index) {
    subSelectedTab.value = index;
  }

  /// 🔹 Team Members List
  var teamList = <TeamMember>[].obs;

  @override
  void onInit() {
    super.onInit();

    teamList.addAll([
      TeamMember(
        rank: 1,
        name: "Rajesh Kumar",
        status: "On Visit",
        isActive: true,
        progress: 85,
        startTime: "09:00 AM",
        avatarLetter: "R",
        location: "Green Valley, Sector 12",
      ),
      TeamMember(
        rank: 2,
        name: "Priya Sharma",
        status: "Active",
        isActive: true,
        progress: 72,
        startTime: "09:05 AM",
        avatarLetter: "P",
        location: "Market Road, Anand",
      ),
      TeamMember(
        rank: 3,
        name: "Amit Verma",
        status: "Issues",
        isActive: false,
        progress: 60,
        startTime: "09:10 AM",
        avatarLetter: "A",
        location: "City Center, Vadodara",
      ),
    ]);
  }
}
