import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoutePlanningBottomSheet extends StatefulWidget {
  final bool isMdo;
  const RoutePlanningBottomSheet({super.key, required this.isMdo});

  static Future<void> show(BuildContext context, {bool isMdo = false}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => RoutePlanningBottomSheet(isMdo: isMdo),
    );
  }

  @override
  State<RoutePlanningBottomSheet> createState() =>
      _RoutePlanningBottomSheetState();
}

class _RoutePlanningBottomSheetState extends State<RoutePlanningBottomSheet> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  final int _daysToShow = 7; // Show 7 days at a time
  late List<DateTime> _dates;
  String _selectedMdo = "Rajesh Kumar";


  @override
  void initState() {
    super.initState();
    _dates = List.generate(
      _daysToShow,
          (index) => DateTime.now().add(Duration(days: index)),
    );
  }

  void _onDateSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _scrollLeft() {
    _scrollController.animateTo(
      _scrollController.offset - 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollRight() {
    _scrollController.animateTo(
      _scrollController.offset + 100,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Widget _dateChip(DateTime date, bool isSelected, int index) {
    final label = index == 0
        ? "Today"
        : DateFormat("dd MMM").format(date); // Today, 20 Aug, 21 Aug...

    return GestureDetector(
      onTap: () => _onDateSelected(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 6),
        decoration: BoxDecoration(
          color: isSelected ? Colors.pinkAccent : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Grab handle
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),

                  // Title
                  const Text(
                    "Route Planning",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Date Tabs
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.chevron_left),
                        onPressed: _scrollLeft,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              _dates.length,
                                  (index) => _dateChip(
                                _dates[index],
                                _selectedIndex == index,
                                index,
                              ),
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.chevron_right),
                        onPressed: _scrollRight,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // 👇 New design section
                  widget.isMdo
                      ? Column(
                    children: [
                      // Distance & Efficiency Cards
                      Row(
                        children: [
                          _statCard(
                            "Distance",
                            "87.5 km",
                            "of 95 km",
                            Colors.green.shade700,
                            Colors.green.shade50,
                          ),
                          const SizedBox(width: 12),
                          _statCard(
                            "Efficiency",
                            "92%",
                            "4/5 visits",
                            Colors.blue.shade700,
                            Colors.blue.shade50,
                          ),
                        ],
                      ),
                    ],
                  )
                      : Column(
                    children: [
                      _mdoSelectorCard(),
                      const SizedBox(height: 12),
                      _mdoRouteCard(),
                    ],
                  ),





                  const SizedBox(height: 24),

                  const Text(
                    "Today's Timeline",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Timeline Items
                  _timelineItem("Office Start", "9:30 AM • 0 km", false),
                  _timelineItem("Ram Kumar Farm", "10:15 AM • 18.5 km", false),
                  _timelineItem("Green Valley Store", "11:45 AM • 32.8 km", false),
                  _timelineItem("Lunch Break", "1:30 PM • 45.2 km", false),
                  _timelineItem("Sunrise Agro", "2:45 PM • 67.1 km", false),
                  _timelineItem("Current Location", "—", true),// Example filler content
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Stat card widget
  Widget _statCard(String title, String value, String subtitle, Color color, Color bg) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 4),
            Text(value,
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(subtitle,
                style: const TextStyle(fontSize: 12, color: Colors.black45)),
          ],
        ),
      ),
    );
  }

  // Timeline item widget
  Widget _timelineItem(String title, String subtitle, bool isLast) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.green,
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                color: Colors.grey.shade300,
              ),
          ],
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: const TextStyle(fontSize: 13, color: Colors.black54)),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }


  Widget _mdoSelectorCard() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.person_outline, color: Colors.blue),
              SizedBox(width: 8),
              Text(
                "Select MDO to View Route",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black54),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedMdo,
                isExpanded: true,
                items: ["Rajesh Kumar", "Amit Sharma", "Sunil Verma"]
                    .map((mdo) => DropdownMenuItem(
                  value: mdo,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                            mdo,
                            overflow: TextOverflow.ellipsis,
                          )),
                      const SizedBox(width: 8),
                      const Text(
                        "Active",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.circle,
                          size: 10, color: Colors.green),
                    ],
                  ),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedMdo = value!;
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mdoRouteCard() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$_selectedMdo's Route",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              _routeStat("Distance", "87.5 km"),
              _routeStat("Efficiency", "92%"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const _routeStat("Visits", "4"),
              Row(
                children: [
                  const Text(
                    "Status ",
                    style: TextStyle(
                        fontSize: 13, color: Colors.black54),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Active",
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }


}

class _routeStat extends StatelessWidget {
  final String label;
  final String value;
  const _routeStat(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: const TextStyle(fontSize: 13, color: Colors.black54)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            )),
      ],
    );
  }
}
