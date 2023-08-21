import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mro/features/data/models/sign_in/sign_in_response.dart';

import '../../../../config/constants/api_constants.dart';
import '../../../data/models/currency/get_currency.dart';
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

      Response response = await _api.sendRequest.get(APIConstants.getUserSchema, queryParameters: queryParams);
      Map<String, dynamic> data = response.data;
      return UserSchemas.fromJson(data);
    } catch (ex) {
      rethrow;
    }
  }

  // ================ SIGN IN
  Future<SignInResponse> signIn(String userNameWithSchemaId, String password) async {
    try {
      Map<String, dynamic> data = {APIConstants.userName: userNameWithSchemaId, APIConstants.password: password};

      var body = json.encode(data);

      Response response = await _api.sendRequest.post(APIConstants.signIn, data: body);
      Map<String, dynamic> responseData = response.data;
      return SignInResponse.fromJson(responseData);
    } catch (ex) {
      rethrow;
    }
  }

  // ================ SIGN IN
  Future<String> resetPassword(String userName, String tenantId) async {
    try {
      Map<String, dynamic> queryParams = {APIConstants.userName: userName, APIConstants.tenantId: tenantId};
      Response response = await _api.sendRequest.get(APIConstants.resetPassword, queryParameters: queryParams);
      var data = response.data.toString();
      return data;
    } catch (ex) {
      rethrow;
    }
  }

  // ================ GET CURRENCY
  Future<List<GetCurrency>> getCurrency(String token) async {
    try {
      Response response = await _api.sendRequest.get(APIConstants.getCurrency,
          options: Options(headers: {
            APIConstants.authorization: "${APIConstants.bearer}${APIConstants.space}$token",
          }));
      List<dynamic> jsonData = response.data;
      List<GetCurrency> data = jsonData
          .map((data) => GetCurrency.fromJson(data))
          .toList();

      return data;
    } catch (ex) {
      rethrow;
    }
  }
}
