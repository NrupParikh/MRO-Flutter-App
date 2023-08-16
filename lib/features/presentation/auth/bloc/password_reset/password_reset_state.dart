import 'package:mro/features/data/models/user_schemas/user_tenant_list.dart';

abstract class PasswordResetState {}

class LoadingState extends PasswordResetState {}

class PasswordResetInitialState extends PasswordResetState {}

class PasswordResetSuccessState extends PasswordResetState {
  final List<UserTenantList> userTenantList;

  PasswordResetSuccessState(this.userTenantList);
}

class PasswordResetFinalSuccessState extends PasswordResetState {
  PasswordResetFinalSuccessState();
}

class PasswordResetFailureState extends PasswordResetState {
  final String passwordResetErrorMessage;

  PasswordResetFailureState(this.passwordResetErrorMessage);
}
