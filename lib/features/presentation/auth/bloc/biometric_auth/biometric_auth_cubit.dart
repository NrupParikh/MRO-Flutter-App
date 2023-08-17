import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/features/presentation/auth/bloc/biometric_auth/biometric_auth_state.dart';

import '../../../../../config/constants/app_constants.dart';
import '../../../../../config/constants/string_constants.dart';
import '../../../../../config/exception_handling/api_error.dart';
import '../../../../../config/shared_preferences/singleton/mro_shared_preference.dart';
import '../../../../data/models/sign_in/sign_in_response.dart';

class BiometricAuthCubit extends Cubit<BiometricAuthState> {
  BiometricAuthCubit() : super(BiometricInitialState());

  void submitForm(
      String userName, String password, String schemaId, mroRepository, MroSharedPreference pref, bool isOnline) async {
    if (!isOnline) {
      emit(BiometricFailureState(StringConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        var userNameWithSchemaId = "$userName|$schemaId";
        SignInResponse data = await mroRepository.signIn("$userName|$schemaId", password);
        // Storing [User schema ] Tenant in shared preference
        pref.setString(AppConstants.prefKeyLoginResponse, json.encode(data));
        pref.setString(AppConstants.prefKeyUserNameWithSchemaId, userNameWithSchemaId);
        pref.setString(AppConstants.prefKeyPassword, password);
        emit(BiometricSuccessState());
      } on DioException catch (ex) {
        emit(BiometricFailureState(apiError(ex)));
      }
    }
  }
}
