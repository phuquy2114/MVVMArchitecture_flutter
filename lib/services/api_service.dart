import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:mvvmarchitecture_flutter/services/response/user_response.dart';
import 'package:mvvmarchitecture_flutter/settings.dart' as settings;
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://reqres.in/api")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) {
    dio.options = BaseOptions(receiveTimeout: 5000, connectTimeout: 5000);
    return _ApiClient(dio, baseUrl: settings.BASE_API_URL);
  }

  @GET('/users?page={id}')
  Future<UserResponse> getUsers(@Path('id') String id);
}

class Api {
  ApiClient client;

  Api() {
    final dio = Dio();

    dio.options.connectTimeout = 30000;
    dio.options.receiveTimeout = 30000;
    dio.options.sendTimeout = 30000;
    dio.options.baseUrl = settings.BASE_API_URL;
    dio.options.headers['Content-Type'] = 'application/json';
    dio.interceptors.add(
      InterceptorsWrapper(onRequest: (options) {
        options.headers['Content-Language'] = 'vi';
        options.headers['Client-TimeZone'] = DateTime.now().timeZoneName;

        final token = 'token';

        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        return options;
      }, onError: (DioError error) async {
        Logger().e(
            '${error.request.uri.toString()}\n${error.request.data}\n${error.message}');

        final connectivityResult = await (Connectivity().checkConnectivity());

        if (connectivityResult == ConnectivityResult.none) {
          return DioError(
              request: error.request,
              response: error.response,
              error: 'Not Connect Internet');
        }

        if (error.response?.statusCode == 401) {
          return DioError(
              request: error.request,
              response: error.response,
              error: 'Not Data');
        }

        try {
          String message = error.response.data['errors']['message'].toString();

          return DioError(
              request: error.request, response: error.response, error: message);
        } catch (e) {}

        try {
          String message = error.response.data['errors']['message'].values
              .toList()[0][0]
              .toString();

          return DioError(
              request: error.request, response: error.response, error: message);
        } catch (e) {}

        return DioError(
            request: error.request,
            response: error.response,
            error: 'Not Data');
      }, onResponse: (response) {
        Logger().d(
            '${response.request.uri.toString()}\n${response.request.data}\n$response');
        return response;
      }),
    );

    client = ApiClient(dio, baseUrl: settings.BASE_API_URL);
  }
}
