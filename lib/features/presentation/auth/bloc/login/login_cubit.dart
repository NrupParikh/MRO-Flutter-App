import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/config/constants/app_constants.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/config/shared_preferences/singleton/mro_shared_preference.dart';

import '../../../../data/models/user_schemas/user_schemas.dart';
import 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitialState());

  void submitForm(String userName, mroRepository, MroSharedPreference pref,
      bool isOnline) async {
    if (userName.isEmpty) {
      emit(LogInFailureState(StringConstants.valMsgEnterUserName));
    } else if (!isOnline) {
      emit(LogInFailureState(AppConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        // Fetching Users Schema with use of Repository Instance
        UserSchemas data = await mroRepository.getUserSchema(userName);
        if (data.success == true) {
          // Storing [User schema ] Tenant in shared preference
          pref.setString(AppConstants.prefKeyUserSchema, json.encode(data));

          emit(LogInSuccessState());
        } else {
          emit(LogInFailureState(data.message.toString()));
        }
      } on DioException catch (ex) {
        print("Error : ${ex.response?.statusCode.toString()}");
        handleException(ex);
      }
    }
  }

  void handleException(DioException ex) {
    if (ex.type == DioExceptionType.connectionError) {
      emit(LogInFailureState(AppConstants.mgsNoInternet));
    } else if (ex.type == DioExceptionType.connectionTimeout ||
        ex.type == DioExceptionType.receiveTimeout) {
      {
        emit(LogInFailureState(AppConstants.msgConnectionTimeOut));
      }
    } else if (ex.type == DioExceptionType.unknown) {
      {
        emit(LogInFailureState(AppConstants.msgUnknownError));
      }
    } else {
      emit(LogInFailureState(ex.type.toString()));
    }
  }
}
