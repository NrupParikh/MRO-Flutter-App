import '../../../../data/models/currency/currency.dart';

abstract class GetCurrencyState {}

class LoadingState extends GetCurrencyState {}

class GetCurrencyInitialState extends GetCurrencyState {}

class GetCurrencySuccessState extends GetCurrencyState {
  final List<Currency> currencyList;

  GetCurrencySuccessState(this.currencyList);
}

class GetCurrencyFailureState extends GetCurrencyState {
  final String getCurrencyFailureMessage;

  GetCurrencyFailureState(this.getCurrencyFailureMessage);
}
