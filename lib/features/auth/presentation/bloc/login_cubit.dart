import 'package:bloc/bloc.dart';
import 'package:mro/features/auth/presentation/bloc/login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitialState());

  void submitForm(String userName) {
    if (userName.isEmpty) {
      emit(LogInFailureState("Please enter User name"));
      return;
    }
    emit(LoginSuccessState());
  }
}
