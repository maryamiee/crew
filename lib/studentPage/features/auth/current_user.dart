import 'package:flutter/foundation.dart';

/// Holds the signed-in student's identity for the lifetime of the app
/// session. Populated by SignupScreen or LoginScreen, read by
/// DashboardScreen for the greeting. Kept as a lightweight ValueNotifier
/// singleton — matches the same pattern already used for report_draft_scope.dart
/// (no state-management package needed at this app size).
class CurrentUser {
  CurrentUser._();

  static final ValueNotifier<String> name = ValueNotifier('Student');
  static final ValueNotifier<String> identifier = ValueNotifier(''); // email or reg. no.

  static void signIn({required String name, required String identifier}) {
    CurrentUser.name.value = name;
    CurrentUser.identifier.value = identifier;
  }

  static void signOut() {
    name.value = 'Student';
    identifier.value = '';
  }
}
