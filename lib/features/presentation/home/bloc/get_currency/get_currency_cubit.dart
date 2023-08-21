import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mro/config/constants/app_constants.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/config/exception_handling/api_error.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';
import '../../../../../config/shared_preferences/singleton/mro_shared_preference.dart';
import '../../../../data/data_sources/local/database/mro_database.dart';
import '../../../../data/models/currency/get_currency.dart';
import 'get_currency_state.dart';

class GetCurrencyCubit extends Cubit<GetCurrencyState> {
  GetCurrencyCubit() : super(GetCurrencyInitialState());

  void getCurrency(MroDatabase database, MroRepository mroRepository, MroSharedPreference pref, bool isOnline) async {
    if (!isOnline) {
      emit(GetCurrencyFailureState(StringConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        var token = pref.getString(AppConstants.prefKeyToken);
        List<GetCurrency> currencyList = await mroRepository.getCurrency(token);
        debugPrint("Currency List ${currencyList.toString()}");

        // Storing all currency to table
        database.mroDao.insertAllCurrency(currencyList);

        emit(GetCurrencySuccessState(currencyList));
      } on DioException catch (ex) {
        emit(GetCurrencyFailureState(apiError(ex)));
      }
    }
  }
}
