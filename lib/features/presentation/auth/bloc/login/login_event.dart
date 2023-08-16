abstract class LogInEvent {}

class LogInSubmitFormEvent extends LogInEvent {
  final String userName;

  LogInSubmitFormEvent(this.userName);
}
