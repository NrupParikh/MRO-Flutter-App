import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mro/config/constants/app_constants.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/config/exception_handling/api_error.dart';
import 'package:mro/config/shared_preferences/singleton/mro_shared_preference.dart';
import 'package:mro/features/data/data_sources/local/database/mro_database.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';
import 'package:mro/features/presentation/home/bloc/get_expense_list/get_expense_list_state.dart';

class GetExpenseListCubit extends Cubit<GetExpenseListState> {
  GetExpenseListCubit() : super(GetExpenseListInitialState());

  void getExpenseList(MroDatabase database, MroRepository mroRepository, MroSharedPreference pref, bool isOnline) async {
    if (!isOnline) {
      emit(GetExpenseListFailureState(StringConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        var token = pref.getString(AppConstants.prefKeyToken);
        var expenseData = await mroRepository.getExpenseList(token);
        debugPrint("Expense List ${expenseData.list.toString()}");
        debugPrint("Expense List Count ${expenseData.count.toString()}");

        // ToDo store all expense list data in database
        emit(GetExpenseListSuccessState(expenseData));
      } on DioException catch (ex) {
        emit(GetExpenseListFailureState(apiError(ex)));
      }
    }
  }
}
