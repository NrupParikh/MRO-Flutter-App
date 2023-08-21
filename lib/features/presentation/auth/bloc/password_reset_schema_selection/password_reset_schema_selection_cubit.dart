import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';

import '../../../../../config/exception_handling/api_error.dart';
import '../../../../../config/shared_preferences/singleton/mro_shared_preference.dart';
import 'password_reset_schema_selection_state.dart';

class PasswordResetSchemaSelectionCubit extends Cubit<PasswordResetSchemaSelectionState> {
  PasswordResetSchemaSelectionCubit() : super(PasswordResetSchemaStateInitialState());

  void submitForm(String userName, String schemaId, MroRepository mroRepository, MroSharedPreference pref, bool isOnline) async {
    if (!isOnline) {
      emit(PasswordResetSchemaStateFailureState(StringConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        String data = await mroRepository.resetPassword(userName, schemaId);
        emit(PasswordResetSchemaStateSuccessState());
      } on DioException catch (ex) {
        emit(PasswordResetSchemaStateFailureState(apiError(ex)));
      }
    }
  }
}
