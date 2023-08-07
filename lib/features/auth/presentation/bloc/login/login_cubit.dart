import 'package:bloc/bloc.dart';
import 'package:mro/config/constants/string_constants.dart';

import 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitialState());

  void submitForm(String userName) {
    if (userName.isEmpty) {
      emit(LogInFailureState(StringConstants.valMsgEnterUserName));
      return;
    }
    emit(LoginSuccessState());
  }
}
