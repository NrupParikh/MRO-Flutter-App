import 'package:bloc/bloc.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/features/presentation/auth/bloc/password_reset/password_reset_state.dart';

class PasswordResetCubit extends Cubit<PasswordResetState> {
  PasswordResetCubit() : super(PasswordResetInitialState());

  void submitForm(String userName) {
    if (userName.isEmpty) {
      emit(PasswordResetFailureState(StringConstants.valMsgEnterUserName));
      return;
    }
    emit(PasswordResetSuccessState());
  }
}
