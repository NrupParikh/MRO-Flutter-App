abstract class PasswordEvent {}

class PasswordSubmitFormEvent extends PasswordEvent {
  final String password;

  PasswordSubmitFormEvent(this.password);
}
