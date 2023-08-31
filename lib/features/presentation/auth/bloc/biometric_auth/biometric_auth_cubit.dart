import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:mro/features/data/data_sources/local/database/mro_database.dart';
import 'package:mro/features/domain/repository/singleton/mro_repository.dart';
import 'package:mro/features/presentation/auth/bloc/biometric_auth/biometric_auth_state.dart';

import '../../../../../config/constants/string_constants.dart';
import '../../../../../config/exception_handling/api_error.dart';
import '../../../../../config/shared_preferences/singleton/mro_shared_preference.dart';
import '../../store_login_info.dart';

class BiometricAuthCubit extends Cubit<BiometricAuthState> {
  BiometricAuthCubit() : super(BiometricInitialState());

  void submitForm(String userName, String password, String schemaId, MroDatabase mroDatabase, MroRepository mroRepository,
      MroSharedPreference pref, bool isOnline) async {
    if (!isOnline) {
      emit(BiometricFailureState(StringConstants.mgsNoInternet));
    } else {
      try {
        emit(LoadingState());
        await storeLoginResponse(userName, schemaId, mroDatabase, mroRepository, password, pref);
        emit(BiometricSuccessState());
      } on DioException catch (ex) {
        emit(BiometricFailureState(apiError(ex)));
      }
    }
  }
}
