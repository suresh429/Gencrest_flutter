import 'package:flutter/material.dart';

class RBHHomeDashboard extends StatelessWidget {
  const RBHHomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.account_tree, size: 64, color: Colors.orange),
        const SizedBox(height: 16),
        const Text('RBH Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Access RBH-specific features here.'),
      ],
    );
  }
}
