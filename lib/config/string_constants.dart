class StringConstants {
  static const String appFullName = "My Receipt Online";
  static const String msgPasswordResetSuccess =
      "An email with password reset instruction has been sent to you.";
  static const String loginWithCredentials = "Login with credentials";
  static const String loginWithBioMetric = "Login with biometric";

  static const String userName = "User Name";
  static const String passwordReset = "Password Reset";
  static const String password = "Password";
  static const String login = "Login";

  static const String hintEnterUserName = "Enter User Name";
  static const String hintEnterPassword = "Enter Password";

  static const String newExpense = "New Expense";
  static const String archive = "Archive";
  static const String myApproval = "My Approval";
  static const String settings = "Settings";
  static const String biometricAuthentication = "Biometric Authentication";
  static const String logout = "Logout";
  static const String syncMessage = "Sync MRO";
  static const String modify = "Modify";

  // =========== BIOMETRIC
  static const String localizedReason = "Please authenticate";
  static const String notEnrolled = "The user has not enrolled any biometrics on the device.";
  static const String lockedOut = "The API is temporarily locked out due to too many attempts.";
  static const String biometricOnlyNotSupported = "The biometric Only parameter can't be true on Windows.";
  static const String notAvailable = "The device does not have hardware support for biometrics or no biometric are added.";
  static const String otherOperatingSystem = "The device operating system is unsupported.";
  static const String passcodeNotSet = "The user has not yet configured a passcode (iOS) or PIN/pattern/password (Android) on the device.";
  static const String permanentlyLockedOut = "The API is locked out more persistently than [lockedOut]. Strong authentication like PIN/Pattern/Password is required to unlock.";
}
