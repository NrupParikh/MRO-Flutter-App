abstract class LogInState {}

class LogInInitialState extends LogInState {}

class LoginSuccessState extends LogInState {}

class LogInFailureState extends LogInState {
  final String userNameErrorMessage;

  LogInFailureState(this.userNameErrorMessage);
}
