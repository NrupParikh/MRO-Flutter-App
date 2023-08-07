import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class API {

  // DIO for Network calling
  final Dio _dio = Dio();

  // Getter method
  Dio get sendRequest => _dio;

  API() {
    _dio.options.baseUrl =
        "https://staging-myreceipts.phxcloud.io/MROMobileApplication/api/";
    _dio.interceptors.add(PrettyDioLogger());
    _dio.options.followRedirects = false;
  }
}
