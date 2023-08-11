import 'package:dio/dio.dart';

import '../constants/string_constants.dart';

String apiError(DioException ex) {
  if (ex.type == DioExceptionType.connectionError) {
    return StringConstants.mgsNoInternet;
  } else if (ex.type == DioExceptionType.connectionTimeout ||
      ex.type == DioExceptionType.receiveTimeout) {
    {
      return StringConstants.msgConnectionTimeOut;
    }
  } else if (ex.type == DioExceptionType.unknown) {
    {
      return StringConstants.msgUnknownError;
    }
  } else if (ex.type == DioExceptionType.badResponse) {
    return ex.response.toString();
  } else {
    return ex.type.toString();
  }
}
