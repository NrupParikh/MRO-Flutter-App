import 'dart:convert';

import 'package:mro/features/domain/repository/singleton/mro_repository.dart';

import '../../../config/constants/app_constants.dart';
import '../../../config/shared_preferences/singleton/mro_shared_preference.dart';
import '../../data/models/sign_in/sign_in_response.dart';

Future<void> storeLoginResponse(String userName, String schemaId, MroRepository mroRepository, String password, MroSharedPreference pref) async {
  var userNameWithSchemaId = "$userName|$schemaId";
  SignInResponse data = await mroRepository.signIn("$userName|$schemaId", password);
  // Storing [User schema ] Tenant in shared preference
  pref.setString(AppConstants.prefKeyToken, data.token.toString());
  pref.setString(AppConstants.prefKeyLoginResponse, json.encode(data));
  pref.setString(AppConstants.prefKeyUserNameWithSchemaId, userNameWithSchemaId);
  pref.setString(AppConstants.prefKeyPassword, password);
}