import 'package:flutter/material.dart';

import '../../../utils/gradient_appbar.dart';

class ViewAuditTrailScreen extends StatelessWidget {
  final List<AuditLog> auditLogs = [
    AuditLog(
      status: "Created",
      color: Colors.blue,
      dateTime: "2024-01-15 at 10:30 AM",
      description:
      "Initial liquidation entry created for Cotton Hybrid-101",
      user: "Rajesh Kumar",
      role: "MDO",
      location: "Green Valley, Sector 12",
      device: "Mobile App - Android",
      ip: "192.168.1.100",
      dataChanges: {
        "Distributor": ["Added: Dynamic Agro"],
        "Retailer": ["Added: Kumar Seeds"],
        "Quantity": ["Added: 50 kgs"],
        "Status": ["Added: Pending"]
      },
    ),
    AuditLog(
      status: "Updated",
      color: Colors.orange,
      dateTime: "2024-01-15 at 11:00 AM",
      description:
      "Added verification photos and retailer signature",
      user: "Rajesh Kumar",
      role: "MDO",
      location: "Green Valley, Sector 12",
      device: "Mobile App - Android",
      ip: "192.168.1.100",
      dataChanges: {
        "Photos": ["Before: 0 photos", "After: 2 photos uploaded"],
        "Signature": ["Before: No signature", "After: Digital signature captured"]
      },
    ),
    AuditLog(
      status: "Verified",
      color: Colors.green,
      dateTime: "2024-01-16 at 2:15 PM",
      description:
      "Entry verified and approved by TSM after field verification",
      user: "Priya Sharma",
      role: "TSM",
      location: "TSM Office, North Delhi",
      device: "Web Portal - Chrome",
      ip: "192.168.1.200",
      dataChanges: {
        "Status": ["Before: Pending", "After: Verified"],
        "Verification Notes": [
          "Added: Cross-verified with distributor records. All documents in order"
        ]
      },
    ),
    AuditLog(
      status: "Reviewed",
      color: Colors.purple,
      dateTime: "2024-01-17 at 9:30 AM",
      description:
      "Entry reviewed as part of regional audit",
      user: "Amit Singh",
      role: "RSM",
      location: "Regional Office, Delhi",
      device: "Web Portal - Chrome",
      ip: "192.168.1.250",
      dataChanges: {},
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppBar(title: "Complete Entry History"),
      body: ListView.builder(
        padding: EdgeInsets.all(12),
        itemCount: auditLogs.length,
        itemBuilder: (context, index) {
          return AuditLogCard(log: auditLogs[index]);
        },
      ),
    );
  }
}

class AuditLog {
  final String status;
  final Color color;
  final String dateTime;
  final String description;
  final String user;
  final String role;
  final String location;
  final String device;
  final String ip;
  final Map<String, List<String>> dataChanges;

  AuditLog({
    required this.status,
    required this.color,
    required this.dateTime,
    required this.description,
    required this.user,
    required this.role,
    required this.location,
    required this.device,
    required this.ip,
    required this.dataChanges,
  });
}

class AuditLogCard extends StatelessWidget {
  final AuditLog log;

  const AuditLogCard({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Status + Date
            Row(
              children: [
                Icon(Icons.circle, color: log.color, size: 14),
                SizedBox(width: 8),
                Text(
                  log.status,
                  style: TextStyle(
                    color: log.color,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 8),
                Text(log.dateTime,
                    style: TextStyle(color: Colors.grey[700])),
              ],
            ),
            SizedBox(height: 8),

            /// Description
            Text(log.description,
                style: TextStyle(color: Colors.black87, fontSize: 14)),
            SizedBox(height: 12),

            /// User + Location
            Row(
              children: [
                Text("User: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(log.user),
                SizedBox(width: 12),
                Chip(
                  label: Text(log.role),
                  padding: EdgeInsets.symmetric(horizontal: 6),
                ),
              ],
            ),
            Row(
              children: [
                Text("Location: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(log.location)),
              ],
            ),
            SizedBox(height: 6),

            /// Device + IP
            Row(
              children: [
                Text("Device: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(child: Text(log.device)),
              ],
            ),
            Row(
              children: [
                Text("IP: ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(log.ip),
              ],
            ),
            SizedBox(height: 12),

            /// Data Changes
            if (log.dataChanges.isNotEmpty) ...[
              Text("Data Changes:",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87)),
              SizedBox(height: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: log.dataChanges.entries.map((entry) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.key,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600])),
                        ...entry.value.map((change) => Text(change,
                            style: TextStyle(
                              color: change.startsWith("Before")
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 13,
                            ))),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
