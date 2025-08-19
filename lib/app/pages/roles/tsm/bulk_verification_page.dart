import 'package:flutter/material.dart';
import 'package:gencrest/app/utils/gradient_appbar.dart';

import '../../../controllers/bulk_verification_controller.dart';
import '../../../data/models/verification_entry_model.dart';


class BulkVerificationPage extends StatefulWidget {
  const BulkVerificationPage({super.key});

  @override
  State<BulkVerificationPage> createState() => _BulkVerificationPageState();
}

class _BulkVerificationPageState extends State<BulkVerificationPage> {
  final BulkVerificationController controller = BulkVerificationController();
  bool selectAll = false;

  /// Priority chip background color
  Color getPriorityColor(String priority) {
    switch (priority) {
      case "high":
        return Colors.red.shade100;
      case "medium":
        return Colors.yellow.shade100;
      case "low":
        return Colors.green.shade100;
      default:
        return Colors.grey.shade200;
    }
  }

  /// Priority text color
  Color getPriorityTextColor(String priority) {
    switch (priority) {
      case "high":
        return Colors.red;
      case "medium":
        return Colors.orange;
      case "low":
        return Colors.green;
      default:
        return Colors.black;
    }
  }

  /// Card border color (only left border)
  Color getCardBorderColor(VerificationEntryModel entry) {
    switch (entry.priority) {
      case "high":
        return Colors.red;
      case "medium":
        return Colors.orange;
      case "low":
        return Colors.green;
      default:
        return Colors.grey.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: GradientAppBar(title: 'Bulk Verification'),// ✅ White background
      body: SafeArea(
        child: SingleChildScrollView( // 🔥 Whole page scrolls
          child: Column(
            children: [
              // 🔹 Top Full Card Header
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 6,
                        spreadRadius: 1,
                        offset: const Offset(2, 3))
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Bulk Verification",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(
                      "${controller.entries.length} pending entries",
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "${controller.selectedCount} selected",
                        style: const TextStyle(
                            color: Colors.brown, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),

              // 🔹 Select All + Filter + Sort (inside card)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2))
                  ],
                ),
                child: Row(
                  children: [
                    Checkbox(
                      value: selectAll,
                      onChanged: (val) {
                        setState(() {
                          selectAll = val ?? false;
                          controller.toggleSelectAll(selectAll);
                        });
                      },
                    ),
                    const Text("Select All",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const Spacer(),
                    _buildTabButton(
                        "Filter", Colors.blue.shade50, Colors.blue),
                    const SizedBox(width: 10),
                    _buildTabButton(
                        "Sort", Colors.purple.shade50, Colors.purple),
                  ],
                ),
              ),

              // 🔹 List of Cards (inside parent scroll)
              ListView.builder(
                shrinkWrap: true, // ✅ make it fit inside scroll
                physics:
                const NeverScrollableScrollPhysics(), // ✅ disable inner scroll
                itemCount: controller.entries.length,
                itemBuilder: (context, index) {
                  final entry = controller.entries[index];
                  return Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: entry.isSelected
                          ? Colors.blue.shade50 // ✅ Fill highlight if selected
                          : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border(
                        left: BorderSide(
                          color: getCardBorderColor(entry),
                          width: 6,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: entry.isSelected,
                                onChanged: (val) {
                                  setState(() {
                                    entry.isSelected = val ?? false;
                                    selectAll = controller.entries
                                        .every((e) => e.isSelected);
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  entry.title,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                  color: getPriorityColor(entry.priority),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  entry.priority.toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: getPriorityTextColor(entry.priority),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text("MDO: ${entry.mdo}",
                              style: const TextStyle(fontSize: 13)),
                          Text("Flow: ${entry.flow}",
                              style: const TextStyle(fontSize: 13)),
                          Text("Quantity: ${entry.quantity}",
                              style: const TextStyle(fontSize: 13)),
                          Text("Date: ${entry.date}",
                              style: const TextStyle(fontSize: 13)),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey.shade200,
                                    foregroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("View Details",style: TextStyle(fontSize: 12),),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () {},
                                  child: const Text("Quick Verify",style: TextStyle(fontSize: 12),),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              const SizedBox(height: 80), // space above bottom bar
            ],
          ),
        ),
      ),

      // 🔹 Bottom Action Bar
      bottomNavigationBar: controller.selectedCount > 0
          ? Container(
        padding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, -3))
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade200,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  setState(() {
                    controller.clearSelection();
                    selectAll = false;
                  });
                },
                child: Text("Clear (${controller.selectedCount})",style: TextStyle(fontSize: 12),),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {},
                child: Text(
                    "Verify Selected (${controller.selectedCount})",style: TextStyle(fontSize: 12),),
              ),
            ),
          ],
        ),
      )
          : null,
    );
  }

  /// Small helper for Filter & Sort buttons
  Widget _buildTabButton(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(label,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w500)),
    );
  }
}
