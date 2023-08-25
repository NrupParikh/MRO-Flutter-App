import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/features/data/data_sources/local/database/mro_database.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';
import 'package:mro/features/presentation/auth/bloc/password/password_state.dart';

import '../../../../../config/exception_handling/api_error.dart';
import '../../../../../config/shared_preferences/singleton/mro_shared_preference.dart';
import '../../store_login_info.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitialState());

  void submitForm(
      String userName, String password, String schemaId,MroDatabase mroDatabase, MroRepository mroRepository, MroSharedPreference pref, bool isOnline) async {
    if (password.isEmpty) {
      emit(PasswordFailureState(StringConstants.valMsgEnterPassword));
    } else if (!isOnline) {
      emit(PasswordFailureState(StringConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        await storeLoginResponse(userName, schemaId, mroDatabase, mroRepository, password, pref);
        emit(PasswordSuccessState());
      } on DioException catch (ex) {
        emit(PasswordFailureState(apiError(ex)));
      }
    }
  }
}
