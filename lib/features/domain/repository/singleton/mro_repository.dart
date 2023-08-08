import 'package:dio/dio.dart';

import '../../../../config/constants/api_constants.dart';
import '../../../data/models/user_schemas/user_schemas.dart';
import '../../api/singleton/api.dart';

class MroRepository {
  // Singleton instance of the MroRepository class
  static final MroRepository _instance = MroRepository._internal();

  factory MroRepository() => _instance;

  MroRepository._internal();

  final API _api = API();

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
}
