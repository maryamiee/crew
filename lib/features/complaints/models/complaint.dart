import '../../../core/widgets/status_chip.dart';

/// Complaint/report model as seen by Admin.
/// IMPORTANT PRIVACY RULE: when [isAnonymous] is true, [studentName] and
/// [studentId] must NEVER be displayed anywhere in the UI. Always check
/// isAnonymous before rendering identity fields.
class Complaint {
  final String id;
  final String category;
  final String description;
  final DateTime submittedAt;
  final ReportStatus status;
  final bool isAnonymous;
  final String? studentName; // null-safe even if populated; check isAnonymous first
  final String? studentId;
  final List<String> evidenceUrls;
  final String? adminRemarks;
  final bool isUrgent;

  const Complaint({
    required this.id,
    required this.category,
    required this.description,
    required this.submittedAt,
    required this.status,
    required this.isAnonymous,
    this.studentName,
    this.studentId,
    this.evidenceUrls = const [],
    this.adminRemarks,
    this.isUrgent = false,
  });

  /// Safe display name — enforces the privacy rule in one place so no
  /// screen can accidentally leak identity.
  String get displayName => isAnonymous ? 'Anonymous Student' : (studentName ?? 'Unknown');

  static List<Complaint> demoList() => [
        Complaint(
          id: 'CRW-1042',
          category: 'Harassment',
          description: 'Repeated unwanted contact near the library block.',
          submittedAt: DateTime.now().subtract(const Duration(hours: 2)),
          status: ReportStatus.urgent,
          isAnonymous: true,
          isUrgent: true,
          evidenceUrls: const ['evidence_1.jpg'],
        ),
        Complaint(
          id: 'CRW-1041',
          category: 'Facility Issue',
          description: 'Broken light fixture in hostel corridor B.',
          submittedAt: DateTime.now().subtract(const Duration(hours: 6)),
          status: ReportStatus.underReview,
          isAnonymous: false,
          studentName: 'Ahmed Raza',
          studentId: 'STD-2201',
        ),
        Complaint(
          id: 'CRW-1039',
          category: 'Theft',
          description: 'Laptop reported missing from library reading room.',
          submittedAt: DateTime.now().subtract(const Duration(days: 1)),
          status: ReportStatus.resolved,
          isAnonymous: false,
          studentName: 'Sana Malik',
          studentId: 'STD-2078',
          adminRemarks: 'Recovered and returned to owner.',
        ),
        Complaint(
          id: 'CRW-1037',
          category: 'Bullying',
          description: 'Group targeting a junior student in the cafeteria.',
          submittedAt: DateTime.now().subtract(const Duration(days: 2)),
          status: ReportStatus.submitted,
          isAnonymous: true,
        ),
      ];
}
