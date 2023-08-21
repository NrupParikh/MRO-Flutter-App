import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/config/constants/app_constants.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/config/shared_preferences/singleton/mro_shared_preference.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';

import '../../../../../config/exception_handling/api_error.dart';
import '../../../../data/models/user_schemas/user_schemas.dart';
import 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitialState());

  void submitForm(String userName, MroRepository mroRepository, MroSharedPreference pref, bool isOnline) async {
    if (userName.isEmpty) {
      emit(LogInFailureState(StringConstants.valMsgEnterUserName));
    } else if (!isOnline) {
      emit(LogInFailureState(StringConstants.mgsNoInternet));
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
        emit(LogInFailureState(apiError(ex)));
      }
    }
  }
}
