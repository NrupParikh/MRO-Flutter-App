import 'package:dio/dio.dart';

class API {
  // Singleton instance of the API class
  static final API _instance = API._internal();

  factory API() => _instance;

  API._internal() {
    _dio.options.baseUrl =
        "https://staging-myreceipts.phxcloud.io/MROMobileApplication/api/";
    //_dio.interceptors.add(PrettyDioLogger());
    _dio.options.followRedirects = false;
  }

  final Dio _dio = Dio();

  Dio get sendRequest => _dio;
}
