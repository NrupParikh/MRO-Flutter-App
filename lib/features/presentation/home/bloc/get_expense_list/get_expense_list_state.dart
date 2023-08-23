import 'package:mro/features/data/models/get_expense_list/get_expense_list.dart';

abstract class GetExpenseListState {}

class LoadingState extends GetExpenseListState {}

class GetExpenseListInitialState extends GetExpenseListState {}

class GetExpenseListSuccessState extends GetExpenseListState {
  final GetExpenseList getExpenseList;

  GetExpenseListSuccessState(this.getExpenseList);
}

class GetExpenseListFailureState extends GetExpenseListState {
  final String getExpenseListFailureMessage;

  GetExpenseListFailureState(this.getExpenseListFailureMessage);
}
