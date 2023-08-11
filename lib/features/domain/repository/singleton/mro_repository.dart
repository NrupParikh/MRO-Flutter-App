import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mro/features/data/models/sign_in/sign_in_response.dart';

import '../../../../config/constants/api_constants.dart';
import '../../../data/models/user_schemas/user_schemas.dart';
import '../../api/singleton/api.dart';

class MroRepository {
  // Singleton instance of the MroRepository class
  static final MroRepository _instance = MroRepository._internal();

  factory MroRepository() => _instance;

  MroRepository._internal();

  final API _api = API();

  // ================ USER SCHEMAS
  Future<UserSchemas> getUserSchema(String userName) async {
    try {
      // Future.delayed(const Duration(seconds: 3)); // Showing Loader for 3 seconds
      Map<String, dynamic> queryParams = {APIConstants.userName: userName};

      Response response = await _api.sendRequest
          .get(APIConstants.getUserSchema, queryParameters: queryParams);
      Map<String, dynamic> data = response.data;
      return UserSchemas.fromJson(data);
    } catch (ex) {
      rethrow;
    }
  }

  // ================ SIGN IN
  Future<SignInResponse> signIn(
      String userName, String password, String schemaId) async {
    try {
      Map<String, dynamic> data = {
        APIConstants.userName: "$userName|$schemaId",
        APIConstants.password: password
      };

      var body = json.encode(data);

      Response response =
          await _api.sendRequest.post(APIConstants.signIn, data: body);
      print("STATUS CODE ${response.statusCode}");
      print("BODY ${response.data}");
      Map<String, dynamic> responseData = response.data;
      return SignInResponse.fromJson(responseData);
    } catch (ex) {
      rethrow;
    }
  }
}
