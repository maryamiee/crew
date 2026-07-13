import 'package:flutter/material.dart';

/// Holds the in-progress incident report as the student moves through
/// the 5-step flow. Kept intentionally simple (no state management
/// package) since this is a linear wizard scoped to one flow.
class ReportDraft extends ChangeNotifier {
  String? category;
  String description = '';
  DateTime? dateTime;
  String location = '';
  final List<String> evidenceFileNames = [];
  bool submitAnonymously = true;
  bool allowAdminContact = true;

  void setCategory(String value) {
    category = value;
    notifyListeners();
  }
}

class CategoryOption {
  const CategoryOption(this.icon, this.label);
  final IconData icon;
  final String label;
}

const reportCategories = [
  CategoryOption(Icons.groups_rounded, 'Bullying'),
  CategoryOption(Icons.diversity_3_rounded, 'Harassment'),
  CategoryOption(Icons.school_rounded, 'Teacher Misconduct'),
  CategoryOption(Icons.shield_rounded, 'Cyber Bullying'),
  CategoryOption(Icons.sports_kabaddi_rounded, 'Physical Abuse'),
  CategoryOption(Icons.warning_rounded, 'Threats'),
  CategoryOption(Icons.record_voice_over_rounded, 'Verbal Abuse'),
  CategoryOption(Icons.balance_rounded, 'Discrimination'),
  CategoryOption(Icons.more_horiz_rounded, 'Other'),
];
