import 'package:mro/features/data/models/sign_in/organizations.dart';

abstract class NewExpenseState {}

class LoadingState extends NewExpenseState {}

class NewExpenseInitialState extends NewExpenseState {
  final List<Organizations> organizations;

  NewExpenseInitialState(this.organizations);
}

class NewExpenseSuccessState extends NewExpenseState {}

class NewExpenseFailureState extends NewExpenseState {
  final String newExpenseErrorMessage;

  NewExpenseFailureState(this.newExpenseErrorMessage);
}
