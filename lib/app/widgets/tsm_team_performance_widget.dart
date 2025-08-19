import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/tsm_team_controller.dart';
import '../data/models/team_member.dart';

class TsmTeamPerformanceWidget extends StatelessWidget {
  final TsmTeamController controller = Get.put(TsmTeamController());

  TsmTeamPerformanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔹 Sub Tabs
          Obx(() => SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                controller.subTabs.length,
                    (index) => GestureDetector(
                  onTap: () => controller.subSelectTab(index),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: controller.subSelectedTab.value == index
                          ? Colors.purple
                          : Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: controller.subSelectedTab.value == index
                            ? Colors.transparent
                            : Colors.grey.shade300,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      controller.subTabs[index],
                      style: TextStyle(
                        color: controller.subSelectedTab.value == index
                            ? Colors.white
                            : Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
          const SizedBox(height: 16),

          /// 🔹 Score Cards
          Row(
            children: [
              Expanded(
                child: _buildScoreCard(
                  title: "Overall Score",
                  value: "85",
                  color: Colors.purple,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildScoreCard(
                  title: "Target Reached",
                  value: "98%",
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          /// 🔹 Leaderboard
          Obx(() => _buildLeaderBoard(controller.teamList)),
        ],
      ),
    );
  }

  /// 🔹 Score Card Widget
  Widget _buildScoreCard({
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  /// 🔹 Leaderboard Section
  Widget _buildLeaderBoard(List<TeamMember> members) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header
          Row(
            children: const [
              Icon(Icons.emoji_events, color: Colors.orange),
              SizedBox(width: 8),
              Text(
                "Leaderboard",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),

          /// Dynamic Leaderboard Items
          ...members.map((member) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _buildLeaderItem(
                rank: member.rank,
                name: member.name,
                location: member.location,
                score: member.progress.toString(),
                isTopper: member.rank == 1,
                avatarLetter: member.name[0].toUpperCase(),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  /// 🔹 Leaderboard Item Widget
  Widget _buildLeaderItem({
    required int rank,
    required String name,
    required String location,
    required String score,
    required bool isTopper,
    required String avatarLetter,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9F9),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 24,
            child: isTopper
                ? const Icon(Icons.emoji_events, color: Colors.orange, size: 20)
                : Text(
              rank.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            child: Text(
              avatarLetter,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                Text(
                  location,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              score,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
