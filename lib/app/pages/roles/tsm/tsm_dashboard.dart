import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class TSMHomeDashboard extends StatelessWidget {
  const TSMHomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              // Team Overview
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("Team Overview",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text("8/10 Active", style: TextStyle(color: Colors.green)),
                ],
              ),
              const SizedBox(height: 8),
              const Text("Live team status", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _overviewCard(
                      title: "Visits Today",
                      value: "24",
                      icon: Icons.visibility,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _overviewCard(
                      title: "Sales Today",
                      value: "₹2.1L",
                      icon: Icons.currency_rupee,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _overviewCard(
                      title: "Pending Tasks",
                      value: "12",
                      icon: Icons.pending_actions,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Team Members
              const Text("Team Members",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),

              _teamMemberCard(
                initials: "RK",
                name: "Rajesh Kumar",
                territory: "Delhi North Territory",
                visits: "3/5 completed",
                sales: "₹45K",
                status: "Active",
                statusColor: Colors.green,
              ),
              const SizedBox(height: 12),
              _teamMemberCard(
                initials: "AS",
                name: "Amit Sharma",
                territory: "Delhi South Territory",
                visits: "2/4 completed",
                sales: "₹32K",
                status: "In Visit",
                statusColor: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Widget _overviewCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
          Text(title, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black87)),
        ],
      ),
    );
  }

  static Widget _teamMemberCard({
    required String initials,
    required String name,
    required String territory,
    required String visits,
    required String sales,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3))
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: statusColor.withOpacity(0.1),
            child: Text(initials,
                style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(status,
                          style: TextStyle(color: statusColor, fontSize: 12)),
                    ),
                  ],
                ),
                Text(territory, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text("Visits: $visits",
                        style: const TextStyle(fontSize: 12, color: Colors.black87)),
                    const SizedBox(width: 12),
                    Text("Sales: $sales",
                        style: const TextStyle(fontSize: 12, color: Colors.black87)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
