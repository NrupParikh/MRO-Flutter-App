abstract class LogInState {}

class LogInInitialState extends LogInState {}

class LogInFailureState extends LogInState {
  final String userNameErrorMessage;

  LogInFailureState(this.userNameErrorMessage);
}

class LoginSuccessState extends LogInState {}
