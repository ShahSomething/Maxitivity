import 'package:dio/dio.dart';
import 'package:maxitivity/app/app.logger.dart';
import 'package:maxitivity/models/request_response.dart';

class ApiService {
  final logger = getLogger('ApiService');
  final _baseUrl = 'https://maxvity-b42ce94fd190.herokuapp.com';
  //final _testUrl = 'http://192.168.1.23:3000';

  Future<Dio> launchDio() async {
    Dio dio = Dio();
    dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
    dio.options.headers['Content-Type'] = 'application/json';
    dio.options.headers["accept"] = 'application/json';

    dio.options.followRedirects = false;
    dio.options.validateStatus = (s) {
      if (s != null) {
        return s < 500;
      } else {
        return false;
      }
    };
    return dio;
  }

  get({required String endPoint, params}) async {
    Dio dio = await launchDio();
    try {
      final response =
          await dio.get('$_baseUrl/$endPoint', queryParameters: params);
      if (response.statusCode == 200) {
        return RequestResponse.fromJson(response.data);
      } else if (response.statusCode == 500) {
        return RequestResponse(false, message: 'Server Error');
      } else {
        return RequestResponse(false, message: 'Network Error');
      }
    } catch (e) {
      logger.e(e);
      return RequestResponse(false, message: e.toString());
    }
  }

  post({
    required String endPoint,
    dynamic data,
  }) async {
    Dio dio = await launchDio();
    final response = await dio.post('$_baseUrl/$endPoint', data: data);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return RequestResponse.fromJson(response.data);
    } else if (response.statusCode == 500) {
      return RequestResponse(false,
          message: response.data['message'] ?? 'Server Error');
    } else {
      return RequestResponse(false,
          message: response.data['message'] ?? 'Network Error');
    }
  }
}
