import 'package:flutter/material.dart';

import '../../../utils/gradient_appbar.dart';

class VerifyLiquidationEntryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> skuList = [
    {"name": "Cotton Hybrid-101", "original": 50, "verified": 50, "discrepancy": 0},
    {"name": "Wheat Seeds Premium", "original": 75, "verified": 75, "discrepancy": 0},
    {"name": "Fertilizer NPK", "original": 100, "verified": 98, "discrepancy": 2},
    {"name": "CropShield Pesticide", "original": 25, "verified": 25, "discrepancy": 0},
  ];

  VerifyLiquidationEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: const GradientAppBar(title: "Verify Liquidation Entry"),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header Card
            _buildHeaderCard(),

            const SizedBox(height: 12),

            /// Total Stock Summary
            _buildStockSummaryCard(),

            const SizedBox(height: 12),

            /// SKU-wise Verification
            _buildSkuWiseVerification(),

            /// Overall Verification Notes
            _buildVerificationNotes(),

            const SizedBox(height: 12),

            /// Proof of Verification
            _buildProofOfVerification(),

            const SizedBox(height: 12),

            /// Action Buttons
            Container(
              margin: const EdgeInsets.only(bottom: 16), // margin on all sides
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text("Submit Verification"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Header
  Widget _buildHeaderCard() {
    return SizedBox(
      width: double.infinity,
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Verify Liquidation Entry",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text("Kumar Seeds via Dynamic Agro",
                  style: TextStyle(color: Colors.black54)),
              SizedBox(height: 4),
              Text("Entry Date: 1/15/2024",
                  style: TextStyle(color: Colors.black54)),
            ],
          ),
        ),
      ),
    );
  }

  /// Stock Summary
  Widget _buildStockSummaryCard() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: const [
              Icon(Icons.inventory, color: Colors.blue),
              SizedBox(width: 8),
              Text("Total Stock Summary",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("Original Total\n250 kgs",
                  style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
              Text("Verified Total\n248 kgs",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.orange),
            ),
            child: Row(
              children: const [
                Icon(Icons.warning, color: Colors.orange),
                SizedBox(width: 8),
                Expanded(
                  child: Text("Discrepancy detected: 2 kgs difference",
                      style: TextStyle(color: Colors.orange)),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }

  /// SKU Verification List
  Widget _buildSkuWiseVerification() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        const Text("  SKU-wise Stock Verification",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: skuList.length,
          itemBuilder: (context, index) {
            final sku = skuList[index];
            return Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              margin: EdgeInsets.only(bottom: index == skuList.length - 1 ? 0 : 10), // ✅ Fix
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Title + Verified Qty
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(sku["name"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Row(
                          children: [
                            const Text("Verified Qty: "),
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                initialValue: sku["verified"].toString(),
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  isDense: true,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text("Original: ${sku["original"]} kgs",
                        style: const TextStyle(color: Colors.black54)),

                    /// Discrepancy Warning
                    if (sku["discrepancy"] > 0) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.orange),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.warning, color: Colors.orange),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "Discrepancy: Expected ${sku["original"]}, Found ${sku["verified"]}",
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],

                    const SizedBox(height: 8),

                    /// Photo & Notes Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.camera_alt, color: Colors.blue),
                            label: const Text("Photo",
                                style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit, color: Colors.purple),
                            label: const Text("Notes",
                                style: TextStyle(color: Colors.purple)),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        )
      ],
    );
  }

  /// Verification Notes
  Widget _buildVerificationNotes() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
     // margin: const EdgeInsets.only(bottom: 12), // ✅ consistent spacing
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
          Text("Overall Verification Notes",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          TextField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText:
              "Add overall verification notes (e.g., stock counts verified, retailer present, no issues found...)",
              border: OutlineInputBorder(),
            ),
          )
        ]),
      ),
    );
  }

  /// Proof of Verification
  Widget _buildProofOfVerification() {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text("Proof of Verification",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt),
                  label: const Text("Capture Photo"),
                ),
              ),
              const SizedBox(height:15),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.edit_document),
                  label: const Text("Get E-Signature"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                Text("Verification Status",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("✔ Photos captured: 3 photos", style: TextStyle(color: Colors.green)),
                Text("✔ E-Signature: Captured", style: TextStyle(color: Colors.green)),
                Text("✔ Retailer verification: Confirmed",
                    style: TextStyle(color: Colors.green)),
              ]),
            ),
          )
        ]),
      ),
    );
  }
}
