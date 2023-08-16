abstract class PasswordResetSchemaSelectionState {}

class LoadingState extends PasswordResetSchemaSelectionState {}

class PasswordResetSchemaStateInitialState extends PasswordResetSchemaSelectionState {}

class PasswordResetSchemaStateSuccessState extends PasswordResetSchemaSelectionState {}

class PasswordResetSchemaStateFailureState extends PasswordResetSchemaSelectionState {
  final String passwordResetSchemaErrorMessage;

  PasswordResetSchemaStateFailureState(this.passwordResetSchemaErrorMessage);
}
