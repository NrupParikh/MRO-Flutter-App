import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/config/constants/app_constants.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';
import 'package:mro/features/presentation/auth/bloc/password_reset/password_reset_state.dart';

import '../../../../../config/exception_handling/api_error.dart';
import '../../../../../config/shared_preferences/singleton/mro_shared_preference.dart';
import '../../../../data/models/user_schemas/user_schemas.dart';
import '../../../../data/models/user_schemas/user_tenant_list.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  PasswordResetCubit() : super(PasswordResetInitialState());

  void submitForm(String userName, MroRepository mroRepository, MroSharedPreference pref, bool isOnline) async {
    if (userName.isEmpty) {
      emit(PasswordResetFailureState(StringConstants.valMsgEnterUserName));
    } else if (!isOnline) {
      emit(PasswordResetFailureState(StringConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        UserSchemas data = await mroRepository.getUserSchema(userName);
        if (data.success == true) {
          // Storing [User schema ] Tenant in shared preference
          pref.setString(AppConstants.prefKeyUserSchema, json.encode(data));
          var userSchema = pref.getString(AppConstants.prefKeyUserSchema);
          Map<String, dynamic> decodedPerson = json.decode(userSchema);
          UserSchemas userSchemas = UserSchemas.fromJson(decodedPerson);
          if (userSchemas.success == true) {
            List<UserTenantList>? userTenantList = userSchemas.userTenantList;
            if (userTenantList!.isNotEmpty) {
              emit(PasswordResetSuccessState(userTenantList));
            } else {
              emit(PasswordResetFailureState(data.message.toString()));
            }
          } else {
            emit(PasswordResetFailureState(data.message.toString()));
          }
        } else {
          emit(PasswordResetFailureState(data.message.toString()));
        }
      } on DioException catch (ex) {
        emit(PasswordResetFailureState(apiError(ex)));
      }
    }
  }

  void callResetPasswordAPI(String userName, String tenantId,MroRepository mroRepository) async {
    try {
      emit(LoadingState());
      String data = await mroRepository.resetPassword(userName,tenantId);
      emit(PasswordResetFinalSuccessState());
    } on DioException catch (ex) {
      emit(PasswordResetFailureState(apiError(ex)));
    }
  }
}
