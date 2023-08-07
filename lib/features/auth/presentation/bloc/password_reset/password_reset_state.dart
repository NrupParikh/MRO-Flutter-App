abstract class PasswordResetState {}

class PasswordResetInitialState extends PasswordResetState {}

class PasswordResetSuccessState extends PasswordResetState {}

class PasswordResetFailureState extends PasswordResetState {
  final String passwordResetErrorMessage;

  PasswordResetFailureState(this.passwordResetErrorMessage);
}
