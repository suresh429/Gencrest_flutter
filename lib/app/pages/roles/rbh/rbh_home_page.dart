import 'package:flutter/material.dart';
import 'rbh_dashboard.dart';

class RBHHomePage extends StatefulWidget {
  const RBHHomePage({super.key});

  @override
  State<RBHHomePage> createState() => _RBHHomePageState();
}

class _RBHHomePageState extends State<RBHHomePage> {
  int _selectedIndex = 0;

  static final List<Widget> _tabs = [
    const RBHHomeDashboard(),
    const Center(child: Text('RBH Tree')),
    const Center(child: Text('RBH Profile')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RBH Home')),
      body: _tabs[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.account_tree), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Tree'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
