import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/config/constants/app_constants.dart';
import 'package:mro/config/constants/string_constants.dart';

import '../../../../data/models/user_schemas/user_schemas.dart';
import '../../../../domain/repository/mro_repository.dart';
import 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitialState());

  void submitForm(String userName) async {
    if (userName.isEmpty) {
      emit(LogInFailureState(StringConstants.valMsgEnterUserName));
    } else {
      try {
        MroRepository mroRepository = MroRepository();
        emit(LoadingState());
        UserSchemas data = await mroRepository.getUserSchema(userName);
        if (data.success == true) {
          emit(LogInSuccessState());
        } else {
          emit(LogInFailureState(data.message.toString()));
        }
      } on DioException catch (ex) {
        print("Error : ${ex.response?.statusCode.toString()}");
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
  }
}
