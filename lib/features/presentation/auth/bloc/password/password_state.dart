abstract class PasswordState {}

class LoadingState extends PasswordState {}

class PasswordInitialState extends PasswordState {}

class PasswordSuccessState extends PasswordState {}

class PasswordFailureState extends PasswordState {
  final String passwordErrorMessage;

  PasswordFailureState(this.passwordErrorMessage);
}
