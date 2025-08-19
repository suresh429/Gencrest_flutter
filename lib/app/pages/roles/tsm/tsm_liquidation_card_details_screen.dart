import 'package:flutter/material.dart';
import 'package:gencrest/app/pages/roles/tsm/verify_liquidationentry_screen.dart';
import 'package:gencrest/app/pages/roles/tsm/view_audit_trail.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../utils/gradient_appbar.dart';

class TsmLiquidationCardDetailsScreen extends StatelessWidget {
  const TsmLiquidationCardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> outlets = [
      {
        "name": "Kumar Seeds",
        "company": "Dynamic Agro",
        "status": "verified",
        "sku": "Cotton Hybrid-101",
        "quantity": "50 kgs",
        "entryDate": "1/15/2024",
      },
      {
        "name": "Happy Agro Traders",
        "company": "Agro Chemicals",
        "status": "pending",
        "sku": "Pesticide-X",
        "quantity": "25 kgs",
        "entryDate": "1/10/2024",
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: const GradientAppBar(title: "Liquidation Details"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔹 Header Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ],
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Rajesh Kumar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "Liquidation Entries for North Delhi Territory",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.warehouse_outlined,
                    label: "Total",
                    value: "1,250",
                    subText: "kgs this month",
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    icon: Icons.trending_up,
                    label: "Rate",
                    value: "85%",
                    subText: "vs target",
                    color: Colors.green,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            /// 🔹 Section Title
            const Text(
              "Outlet Breakdown",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 12),

            /// 🔹 Dynamic Outlet Cards
            Column(
              children: outlets
                  .map((outlet) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: OutletCard(
                  outletName: outlet["name"],
                  company: outlet["company"],
                  status: outlet["status"],
                  sku: outlet["sku"],
                  quantity: outlet["quantity"],
                  entryDate: outlet["entryDate"],
                ),
              ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  /// 🔹 Reusable Stat Card
  Widget _buildStatCard({
    required IconData icon,
    required String label,
    required String value,
    required String subText,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subText,
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          )
        ],
      ),
    );
  }
}

/// 🔹 Outlet Card Widget
class OutletCard extends StatelessWidget {
  final String outletName;
  final String company;
  final String sku;
  final String quantity;
  final String entryDate;
  final String status;

  const OutletCard({
    super.key,
    required this.outletName,
    required this.company,
    required this.sku,
    required this.quantity,
    required this.entryDate,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isVerified = status.toLowerCase() == "verified";
    final isPending = status.toLowerCase() == "pending";

    return Container(
     // margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Outlet Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    outletName,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    company,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: isVerified
                      ? Colors.green.shade100
                      : Colors.yellow.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isVerified ? Colors.green : Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          const Divider(),

          /// SKU, Quantity, Date
          Row(
            children: [
              const Text("SKU: ", style: TextStyle(color: Colors.grey)),
              Expanded(
                child: Text(sku, style: const TextStyle(fontWeight: FontWeight.w500)),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text("Quantity: ", style: TextStyle(color: Colors.grey)),
              Text(quantity, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Text("Entry Date: ", style: TextStyle(color: Colors.grey)),
              Text(entryDate, style: const TextStyle(fontWeight: FontWeight.w500)),
            ],
          ),

          const SizedBox(height: 16),

          /// Buttons
          Row(
            children: [
              if (isVerified) ...[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(ViewAuditTrailScreen());
                    },
                    icon: const Icon(Icons.receipt_long),
                    label: const Text("View Audit Trail"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(VerifyLiquidationEntryScreen());
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text("Re-verify"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ] else if (isPending) ...[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.to(VerifyLiquidationEntryScreen());
                    },
                    icon: const Icon(Icons.verified),
                    label: const Text("Verify Entry"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ]
            ],
          ),
        ],
      ),
    );
  }
}
