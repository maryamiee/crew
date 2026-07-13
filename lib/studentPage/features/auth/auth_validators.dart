/// Shared validation rules for the auth screens (Login, Signup,
/// Forgot Password). Kept framework-free (pure Dart) so they're easy
/// to unit test independently of any widget.
class AuthValidators {
  AuthValidators._();

  /// Registration Number format: SP24-BSE-000
  /// SP = intake season code, 24 = year, BSE = program code, 000 = roll number.
  static final RegExp regNoFormat = RegExp(r'^[A-Z]{2}\d{2}-[A-Z]{3}-\d{3}$');

  static final RegExp emailFormat = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

  static final RegExp _upperCase = RegExp(r'[A-Z]');
  static final RegExp _specialChar = RegExp(r'[!@#\$%^&*(),.?":{}|<>_\-+=~`\[\]/\\;]');

  /// Accepts either a university email OR a Registration Number
  /// (SP24-BSE-000 format) — matches the combined login field.
  static String? loginIdentifier(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your email or registration number';
    }
    final v = value.trim().toUpperCase();
    if (emailFormat.hasMatch(value.trim()) || regNoFormat.hasMatch(v)) {
      return null;
    }
    return 'Enter a valid email or format like SP24-BSE-000';
  }

  static String? registrationNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Enter your registration number';
    }
    if (!regNoFormat.hasMatch(value.trim().toUpperCase())) {
      return 'Format should look like SP24-BSE-000';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter your university email';
    if (!emailFormat.hasMatch(value.trim())) return 'Enter a valid email address';
    return null;
  }

  static String? fullName(String? value) {
    if (value == null || value.trim().isEmpty) return 'Enter your full name';
    if (value.trim().length < 2) return 'Name is too short';
    return null;
  }

  /// Password rules, checked individually so the UI can show a live
  /// checklist (matches the reference design): min 6 chars, one
  /// uppercase letter, one special character.
  static bool hasMinLength(String value) => value.length >= 6;
  static bool hasUppercase(String value) => _upperCase.hasMatch(value);
  static bool hasSpecialChar(String value) => _specialChar.hasMatch(value);

  static bool isPasswordValid(String value) =>
      hasMinLength(value) && hasUppercase(value) && hasSpecialChar(value);

  static String? password(String? value) {
    if (value == null || value.isEmpty) return 'Enter a password';
    if (!isPasswordValid(value)) return 'Password does not meet all requirements';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if (value != original) return 'Passwords do not match';
    return null;
  }
}
