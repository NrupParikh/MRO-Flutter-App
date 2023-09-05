class StringConstants {
  static const String appFullName = "My Receipt Online";
  static const String msgPasswordResetSuccess = "An email with password reset instruction has been sent to you.";
  static const String loginWithCredentials = "Login with credentials";
  static const String loginWithBioMetric = "Login with biometric";

  static const String userName = "User Name";
  static const String passwordReset = "Password Reset";
  static const String next = "Next";
  static const String save = "Save";
  static const String password = "Password";
  static const String login = "Login";
  static const String selectSchema = "Select schema";
  static const String organization = "Organization";
  static const String expenseDate = "Expense Date";
  static const String expenseAmount = "Expense Amount";
  static const String vat1Amount = "VAT1 Amount";
  static const String vat2Amount = "VAT2 Amount";
  static const String totalOfVAT1andVAT2 = "Total Amount incl. VAT1 and VAT2";
  static const String account = "Account";

  static const String hintEnterUserName = "Enter User Name";
  static const String hintEnterPassword = "Enter Password";
  static const String hintSelectExpenseDate = "Select Expense Date";
  static const String hintEnterAmount = "Enter Amount";

  static const String newExpense = "New Expense";
  static const String addExpense = "Add Expense";
  static const String archive = "Archive";
  static const String myApproval = "My Approval";
  static const String settings = "Settings";
  static const String biometricAuthentication = "Biometric Authentication";
  static const String logout = "Logout";
  static const String syncMessage = "Sync MRO";
  static const String modify = "Modify";
  static const String or = "Or";
  static const String radioButtonLblCreditCard = "Company Credit Card";
  static const String radioButtonLblPersonal = "Personal";

  // Choose Option Dialog
  static const String chooseOption = "Choose Option";
  static const String optionTakeAPhoto = "Take a Photo";
  static const String optionChooseFromGallery = "Choose from Gallery";
  static const String optionChooseDocument = "Choose Document";
  static const String optionCancel = "Cancel";

  // =========== TAB
  static const String tabDraft = "Draft";
  static const String tabPendingUpload = "Pending Upload";
  static const String tabPendingApproval = "Pending Approval";
  static const String tabApproved = "Approved";

  // =========== BIOMETRIC
  static const String localizedReason = "Please authenticate";
  static const String notEnrolled = "The user has not enrolled any biometrics on the device.";
  static const String lockedOut = "The API is temporarily locked out due to too many attempts.";
  static const String biometricOnlyNotSupported = "The biometric Only parameter can't be true on Windows.";
  static const String notAvailable = "The device does not have hardware support for biometrics or no biometric are added.";
  static const String otherOperatingSystem = "The device operating system is unsupported.";
  static const String passcodeNotSet =
      "The user has not yet configured a passcode (iOS) or PIN/pattern/password (Android) on the device.";
  static const String permanentlyLockedOut =
      "The API is locked out more persistently than [lockedOut]. Strong authentication like PIN/Pattern/Password is required to unlock.";

  // ============ MESSAGES
  static const String valMsgEnterUserName = "Please enter User name";
  static const String valMsgEnterPassword = "Please enter Password";

  static const String valMsgSelectExpenseDate = "Please Select Expense Date";
  static const String valMsgVat1= "Please Enter VAT1 Amount";
  static const String valMsgVat2= "Please Enter VAT2 Amount";
  static const String valMsgVatTotal= "Please Enter Total Amount";

  // ============ common
  static const String mgsNoInternet = "Please check your internet connection.";
  static const String msgConnectionTimeOut = "Connection timeout occurred";
  static const String msgUnknownError = "Unknown error occurred";
  static const String msgLogoutConfirmation = "Are you sure you want to Log Out of MRO?";
  static const String expenseStatus = "Status:";
  static const String valMsgVat1MustBeLessThanVat1 = "VAT1 amount must be less than VAT2 amount";
  static const String valMsgTotalMount = "Total Amount always bigger or equal to (VAT1+VAT2) Amount";
}
