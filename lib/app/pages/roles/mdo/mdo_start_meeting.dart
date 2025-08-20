import 'package:flutter/material.dart';

import '../../../utils/gradient_appbar.dart';

class MdoStartMeeting extends StatefulWidget {
  const MdoStartMeeting({super.key});

  @override
  State<MdoStartMeeting> createState() => _MdoStartMeetingState();
}

class _MdoStartMeetingState extends State<MdoStartMeeting> {
  // Checklist states
  bool intro = false;
  bool demo = false;
  bool discussion = false;
  bool photos = false;
  bool signature = false;

  // Notes controller
  final TextEditingController notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: GradientAppBar(title: "Start Meeting"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // Top Card
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                title: const Text(
                  "Ram Kumar Farm Visit",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: const Text("Ram Kumar\nGreen Valley, Sector 12"),
                trailing: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.pink.shade100,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text("In Progress",
                      style: TextStyle(color: Colors.pink)),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Visit Duration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Colors.orange, Colors.red],
                ),
              ),
              child: const Column(
                children: [
                  Text("Visit Duration",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  SizedBox(height: 8),
                  Text("00:19",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Visit Checklist
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Visit Checklist",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    CheckboxListTile(
                      title: const Text("Introduction & Greeting"),
                      value: intro,
                      onChanged: (val) =>
                          setState(() => intro = val ?? false),
                    ),
                    CheckboxListTile(
                      title: const Text("Product Demonstration"),
                      value: demo,
                      onChanged: (val) =>
                          setState(() => demo = val ?? false),
                    ),
                    CheckboxListTile(
                      title: const Text("Needs Discussion"),
                      value: discussion,
                      onChanged: (val) =>
                          setState(() => discussion = val ?? false),
                    ),
                    CheckboxListTile(
                      title: const Text("Take Photos"),
                      value: photos,
                      onChanged: (val) =>
                          setState(() => photos = val ?? false),
                    ),
                    CheckboxListTile(
                      title: const Text("Get Signature"),
                      value: signature,
                      onChanged: (val) =>
                          setState(() => signature = val ?? false),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.purple.shade100,
                              foregroundColor: Colors.purple,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.camera_alt),
                            label: const Text("Take Photo"),
                            onPressed: () {},
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink.shade100,
                              foregroundColor: Colors.pink,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.edit_document),
                            label: const Text("Signature"),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Notes Input
                    TextField(
                      controller: notesController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: "Add visit notes (min 5 characters)...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Completion Requirements
                    Card(
                      color: Colors.blueGrey[50],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text("Completion Requirements:",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.close, color: Colors.red, size: 18),
                                SizedBox(width: 8),
                                Text("Capture at least one photo"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.close, color: Colors.red, size: 18),
                                SizedBox(width: 8),
                                Text("Capture e-Signature"),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.close, color: Colors.red, size: 18),
                                SizedBox(width: 8),
                                Text("Add visit notes (min 5 chars)"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Stop & Complete Visit Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black54,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: null, // disabled until requirements met
                      child: const Center(
                        child: Text("Stop & Complete Visit"),
                      ),
                    ),
                  ],
                ),
              ),
            )
            
            
          ],
        ),
      ),
    );
  }
}
