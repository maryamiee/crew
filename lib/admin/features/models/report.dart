import 'package:flutter/material.dart';
import '../widgets/status_badge.dart';

class AdminReport {
  final String id;
  final String title;
  final String category;
  final String location;
  final String date;
  final ReportStatus status;
  final bool isAnonymous;
  final String reportedBy;
  final String description;
  final int evidenceCount;
  final IconData icon;
  final Color iconColor;

  const AdminReport({
    required this.id,
    required this.title,
    required this.category,
    required this.location,
    required this.date,
    required this.status,
    required this.isAnonymous,
    required this.reportedBy,
    required this.description,
    this.evidenceCount = 0,
    required this.icon,
    required this.iconColor,
  });
}

/// Mock data mirroring the approved mockup content exactly (Bullying
/// Incident, Harassment Case, Cyber Bullying, Infrastructure Issue,
/// Safety Concern) so the Admin app looks identical to the design when
/// run, before a real backend is wired in.
class AdminMockData {
  AdminMockData._();

  static final ValueNotifier<List<AdminReport>> reports = ValueNotifier([
    const AdminReport(
      id: 'CRW-2024-0525-001', title: 'Bullying Incident', category: 'Bullying',
      location: 'Main Block, 2nd Floor', date: 'May 25, 2024', status: ReportStatus.pending,
      isAnonymous: true, reportedBy: 'Anonymous',
      description: 'Student is being bullied by a group of classmates in the corridor on regular basis.',
      evidenceCount: 4, icon: Icons.groups_rounded, iconColor: Color(0xFFEF4444),
    ),
    AdminReport(
      id: 'CRW-2024-0525-002', title: 'Harassment Case', category: 'Harassment',
      location: 'Cafeteria Area', date: 'May 25, 2024', status: ReportStatus.inProgress,
      isAnonymous: false, reportedBy: 'Ayesha Khan', description: 'Verbal harassment reported near the cafeteria.',
      evidenceCount: 2, icon: Icons.person_off_rounded, iconColor: const Color(0xFFF59E0B),
    ),
    const AdminReport(
      id: 'CRW-2024-0524-003', title: 'Cyber Bullying', category: 'Cyber Bullying',
      location: 'Online Report', date: 'May 24, 2024', status: ReportStatus.pending,
      isAnonymous: true, reportedBy: 'Anonymous', description: 'Student reported being targeted in a class group chat.',
      evidenceCount: 3, icon: Icons.smartphone_rounded, iconColor: Color(0xFFF59E0B),
    ),
    AdminReport(
      id: 'CRW-2024-0524-004', title: 'Infrastructure Issue', category: 'Infrastructure',
      location: 'Science Block, Room 301', date: 'May 24, 2024', status: ReportStatus.resolved,
      isAnonymous: false, reportedBy: 'Ali Raza', description: 'Broken projector and flickering lights in the lab.',
      evidenceCount: 1, icon: Icons.build_rounded, iconColor: const Color(0xFF2563EB),
    ),
    const AdminReport(
      id: 'CRW-2024-0524-005', title: 'Safety Concern', category: 'Safety',
      location: 'Parking Area', date: 'May 24, 2024', status: ReportStatus.inProgress,
      isAnonymous: true, reportedBy: 'Anonymous', description: 'Poor lighting in the parking area raises safety concerns at night.',
      evidenceCount: 2, icon: Icons.warning_amber_rounded, iconColor: Color(0xFFEF4444),
    ),
  ]);

  static void updateStatus(String id, ReportStatus status, {String? remark}) {
    reports.value = reports.value
        .map((r) => r.id == id
            ? AdminReport(
                id: r.id, title: r.title, category: r.category, location: r.location, date: r.date,
                status: status, isAnonymous: r.isAnonymous, reportedBy: r.reportedBy,
                description: r.description, evidenceCount: r.evidenceCount, icon: r.icon, iconColor: r.iconColor,
              )
            : r)
        .toList();
  }
}
