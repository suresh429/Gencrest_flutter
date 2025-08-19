
import '../data/models/verification_entry_model.dart';

class BulkVerificationController {
  List<VerificationEntryModel> entries = [
    VerificationEntryModel(
      title: "Cotton Hybrid-101",
      mdo: "Rajesh Kumar",
      flow: "Dynamic Agro → Kumar Seeds",
      quantity: "50 kgs",
      date: "15/01/2024",
      priority: "high",
    ),
    VerificationEntryModel(
      title: "Wheat Seeds Premium",
      mdo: "Sunil Verma",
      flow: "AgroTech → Green Seeds",
      quantity: "25 kgs",
      date: "16/01/2024",
      priority: "medium",
    ),
    VerificationEntryModel(
      title: "Rice Hybrid-202",
      mdo: "Anil Sharma",
      flow: "AgroFarm → Agro World",
      quantity: "40 kgs",
      date: "17/01/2024",
      priority: "low",
    ),
    VerificationEntryModel(
      title: "Maize Hybrid-505",
      mdo: "Prakash Rao",
      flow: "Dynamic Agro → Fresh Seeds",
      quantity: "60 kgs",
      date: "18/01/2024",
      priority: "medium",
    ),
    VerificationEntryModel(
      title: "Millet Hybrid-888",
      mdo: "Ramesh Kumar",
      flow: "FarmTech → Organic Seeds",
      quantity: "35 kgs",
      date: "19/01/2024",
      priority: "high",
    ),
  ];

  void toggleSelectAll(bool select) {
    for (var entry in entries) {
      entry.isSelected = select;
    }
  }

  int get selectedCount => entries.where((e) => e.isSelected).length;

  void clearSelection() {
    for (var entry in entries) {
      entry.isSelected = false;
    }
  }
}
