import 'package:mro/features/data/models/sign_in/accounts.dart';
import 'package:mro/features/data/models/sign_in/organizations.dart';

import '../../../../data/models/currency/currency.dart';

abstract class NewExpenseState {}

class LoadingState extends NewExpenseState {}

class NewExpenseInitialState extends NewExpenseState {
  final List<Organizations> organizations;
  final List<Currency> currencies;
  final List<Accounts> accounts;

  NewExpenseInitialState(this.organizations, this.currencies, this.accounts);
}

class NewExpenseSuccessState extends NewExpenseState {}

class NewExpenseFailureState extends NewExpenseState {
  final String newExpenseErrorMessage;

  NewExpenseFailureState(this.newExpenseErrorMessage);
}
