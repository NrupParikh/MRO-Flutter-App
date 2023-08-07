import 'package:bloc/bloc.dart';
import 'package:mro/config/constants/string_constants.dart';
import 'package:mro/features/presentation/auth/bloc/password/password_state.dart';

class PasswordCubit extends Cubit<PasswordState> {
  PasswordCubit() : super(PasswordInitialState());

  void submitForm(String password) {
    if (password.isEmpty) {
      emit(PasswordFailureState(StringConstants.valMsgEnterPassword));
      return;
    }
    emit(PasswordSuccessState());
  }
}
