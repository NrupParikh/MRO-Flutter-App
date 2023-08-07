abstract class PasswordResetEvent {}

class PasswordResetFormEvent extends PasswordResetEvent {
  final String userName;

  PasswordResetFormEvent(this.userName);
}
