class VerificationEntryModel {
  final String title;
  final String mdo;
  final String flow;
  final String quantity;
  final String date;
  final String priority; // "high", "medium", "low"
  bool isSelected;


  VerificationEntryModel({
    required this.title,
    required this.mdo,
    required this.flow,
    required this.quantity,
    required this.date,
    required this.priority,
    this.isSelected = false,
  });
}
