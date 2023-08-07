import 'package:dio/dio.dart';
import 'package:mro/config/constants/api_constants.dart';

import '../../data/models/user_schemas/user_schemas.dart';
import '../api/api.dart';

class MroRepository {
  API api = API();

  Future<UserSchemas> getUserSchema(String userName) async {
    try {
      Future.delayed(const Duration(seconds: 3));
      Map<String, dynamic> queryParams = {"username": userName};

      Response response = await api.sendRequest
          .get(APIConstants.getUserSchema, queryParameters: queryParams);
      Map<String, dynamic> data = response.data;
      return UserSchemas.fromJson(data);
    } catch (ex) {
      rethrow;
    }
  }
}
