import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/config/exception_handling/api_error.dart';
import 'package:mro/config/shared_preferences/singleton/mro_shared_preference.dart';
import 'package:mro/features/data/data_sources/local/database/mro_database.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';
import 'package:mro/features/presentation/home/bloc/new_expense/new_expense_state.dart';

import '../../../../../config/constants/app_constants.dart';
import '../../../../data/models/sign_in/sign_in_response.dart';

class NewExpenseCubit extends Cubit<NewExpenseState> {
  final MroDatabase database;
  final MroRepository mroRepository;
  final MroSharedPreference preference;

  NewExpenseCubit(this.database, this.mroRepository, this.preference) : super(NewExpenseInitialState([], [], [])) {
    var loginResponse = preference.getString(AppConstants.prefKeyLoginResponse);
    var data = json.decode(loginResponse);
    var loginData = SignInResponse.fromJson(data);
    var employeeId = loginData.employee?.id;

    getInitialDataFromDB(database, employeeId!);
  }

  Future<void> getInitialDataFromDB(MroDatabase database, int employeeId) async {
    final organizations = await database.mroDao.getOrganizationsBasedOnEmployee(employeeId!);
    final currencies = await database.mroDao.getAllCurrencies();
    final accounts = await database.mroDao.getAccountsBasedOnOrganizations(employeeId);
    emit(NewExpenseInitialState(organizations, currencies, accounts));
  }

  Future<void> refreshUI() async {
    emit(NewExpenseRefreshState());
  }

  void submitForm(MroDatabase mroDatabase, MroRepository mroRepository, MroSharedPreference pref, bool isOnline) {
    if (!isOnline) {
      emit(NewExpenseFailureState(StringConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        emit(NewExpenseSuccessState());
      } on DioException catch (ex) {
        emit(NewExpenseFailureState(apiError(ex)));
      }
    }
  }
}
