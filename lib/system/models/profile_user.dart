/// Simple data model for the currently signed-in student.
/// Replace [ProfileUserStore.current] with a real Firestore/API-backed
/// value once auth + backend are wired up — every Profile screen reads
/// from this single source so the swap only needs to happen here.
class ProfileUser {
  final String name;
  final String department;
  final String email;
  final String phone;
  final String? avatarUrl;
  final String studentId;
  final bool notificationsEnabled;
  final bool biometricLockEnabled;

  const ProfileUser({
    required this.name,
    required this.department,
    required this.email,
    required this.phone,
    required this.studentId,
    this.avatarUrl,
    this.notificationsEnabled = true,
    this.biometricLockEnabled = false,
  });

  ProfileUser copyWith({
    String? name,
    String? department,
    String? email,
    String? phone,
    String? avatarUrl,
    String? studentId,
    bool? notificationsEnabled,
    bool? biometricLockEnabled,
  }) {
    return ProfileUser(
      name: name ?? this.name,
      department: department ?? this.department,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      studentId: studentId ?? this.studentId,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      biometricLockEnabled: biometricLockEnabled ?? this.biometricLockEnabled,
    );
  }
}

/// A tiny in-memory store so Edit Profile / Settings changes are
/// visible immediately across the module without a state-management
/// package. Swap the internals for Provider/Riverpod/Bloc later —
/// screens only ever call [ProfileUserStore.current] and [update].
class ProfileUserStore {
  ProfileUserStore._();

  static ProfileUser current = const ProfileUser(
    name: 'Ayesha Khan',
    department: 'Computer Science',
    email: 'ayesha.khan@university.edu',
    phone: '+92 300 1234567',
    studentId: 'CS-2023-041',
  );

  static void update(ProfileUser user) {
    current = user;
  }
}

/// A single item in "My Reports". Mirrors the shared [ReportStatus]
/// enum from core/widgets/status_chip.dart so the chip styling is
/// identical to what Admin sees on their side.
class ReportSummary {
  final String id;
  final String category;
  final String date;
  final String status; // matches ReportStatus.name

  const ReportSummary({
    required this.id,
    required this.category,
    required this.date,
    required this.status,
  });
}

/// A single in-app notification.
class NotificationItem {
  final String title;
  final String body;
  final String time;
  final bool read;

  const NotificationItem({
    required this.title,
    required this.body,
    required this.time,
    this.read = false,
  });
}
