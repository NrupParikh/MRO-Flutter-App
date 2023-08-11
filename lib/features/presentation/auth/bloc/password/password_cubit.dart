import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/features/presentation/auth/bloc/password/password_state.dart';

import '../../../../../config/constants/app_constants.dart';
import '../../../../../config/exception_handling/api_error.dart';
import '../../../../../config/shared_preferences/singleton/mro_shared_preference.dart';
import '../../../../data/models/sign_in/sign_in_response.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitialState());

  void submitForm(String userName, String password, String schemaId,
      mroRepository, MroSharedPreference pref, bool isOnline) async {
    if (password.isEmpty) {
      emit(PasswordFailureState(StringConstants.valMsgEnterPassword));
    } else if (!isOnline) {
      emit(PasswordFailureState(StringConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        SignInResponse data =
            await mroRepository.signIn(userName, password, schemaId);
        // Storing [User schema ] Tenant in shared preference
        pref.setString(AppConstants.prefKeyLoginResponse, json.encode(data));
        emit(PasswordSuccessState());
      } on DioException catch (ex) {
        emit(PasswordFailureState(apiError(ex)));
      }
    }
  }
}
