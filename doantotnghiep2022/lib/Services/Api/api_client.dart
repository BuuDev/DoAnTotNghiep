import 'package:dio/dio.dart';
import 'package:doantotnghiep/Services/Helper/custom_loading.dart';
import 'package:doantotnghiep/Services/Helper/notify_helper.dart';
import 'package:doantotnghiep/Services/LocalStorage/local_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

// const _routesExcludeRefreshToken = [
//   '/login',
//   '/active-account',
//   '/login-facebook',
//   '/login-google'
// ];

class ClientApi {
  Dio initDio() {
    Dio _dio = Dio();
    _dio.interceptors.add(CustomInterceptor(_dio));
    _dio.options.baseUrl = 'https://hrm-api.didotek.vn/v2';
    _dio.options.receiveTimeout = 100000;
    return _dio;
  }

  // static EnvironmentMode mode() {
  //   return kDebugMode ? EnvironmentMode.dev : EnvironmentMode.production;
  // }
}

//enum EnvironmentMode { dev, production }

class CustomInterceptor extends QueuedInterceptor {
  final Dio _dio;
  CustomInterceptor(this._dio);
  var context = GetIt.instance<GlobalKey<NavigatorState>>().currentState;

  void showLoading() {
    if (_dio.options.headers['isLoading'] ?? true) {
      customLoading(context!.context);
    }
  }

  void hideLoading() {
    if (_dio.options.headers['isLoading'] ?? true) {
      hideLoadingCustom(context!.context);
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    debugPrint(
      'REQUEST[${options.method}] => PATH: ${options.path}',
    );
    showLoading();
    //await LocalStorage.init();
    String accessToken = LocalStorage().token;
    if (accessToken.isNotEmpty) {
      // options.headers['Authorization'] = 'Bearer $accessToken';
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    return super.onRequest(options, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) {
    hideLoading();
    if (kDebugMode) {
      // print("In File: api_client.dart, Line: 21 $response ");
      print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
      );
    }
    // dòng này chỉ lấy ra response key là data
    // if (response.data['data'] != null &&
    //     !_routesExcludeRefreshToken.contains(response.requestOptions.path)) {
    //   response.data = response.data['data'];
    // }

    super.onResponse(response, handler);
    return Future.value(response);
  }

  // @override
  // Future onError(DioError err, ErrorInterceptorHandler handler) async {
  //   hideLoading(context!.context);
  //   debugPrint(
  //     'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
  //   );
  //   // Do something with response error
  //   if (LocalStorage().token.isNotEmpty && err.response?.statusCode == 401
  //       // &&
  //       // !_routesExcludeRefreshToken.contains(err.requestOptions.path)
  //       ) {
  //     RequestOptions options = err.response!.requestOptions;
  //     // RequestOptions options2 = err.requestOptions;
  //     Options _options = Options(
  //       method: options.method,
  //       headers: options.headers,
  //       extra: options.extra,
  //     );
  //     // UserInfo info =
  //     //     await UserService.client().refreshToken(LocalStorage().token);

  //     // GetIt.instance<AppVM>().refreshSuccess(info);
  //     // _options.headers!["Authorization"] = "Bearer " + info.accessToken!;

  //     return _dio.request(
  //       options.path,
  //       options: _options,
  //       data: options.data,
  //       queryParameters: options.queryParameters,
  //     );
  //   }

  //   // hideLoading();

  //   debugPrint('$err');

  //   if (err.response?.data is String) {
  //     // NotifyHelper.showSnackBar('Đã xảy ra lỗi, vui lòng thử lại!');
  //     super.onError(err, handler);
  //     return Future.error(err);
  //   }

  //   Map<String, dynamic>? data = err.response?.data;

  //   // if (data != null) {
  //   //   // if (data["error"] != null) {
  //   //   //   NotifyHelper.showSnackBar(data['error']);
  //   //   // } else if (err.requestOptions.extra['isShowMessage'] ??
  //   //   //     true && data["message"] != null) {
  //   //   //   // email không tồn tại
  //   //   //   NotifyHelper.showSnackBar(data['message']);
  //   //   // }
  //   // }
  //   NotifyHelper.showSnackBar(data!['message']);
  //   // if (data != null && LocalStorage().token.isNotEmpty) {
  //   //   if (data['message'] != null) {
  //   //     NotifyHelper.showSnackBar(data['message']);
  //   //   }
  //   // }

  //   // if (kDebugMode) {
  //   //   print("In File: api_client.dart, Line: 39 ${err.response} ");
  //   // }

  //   super.onError(err, handler);
  //   return Future.error(err);
  // }
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    // Do something with response error
    hideLoading();
    if (LocalStorage().token.isNotEmpty && err.response?.statusCode == 401) {
      RequestOptions options = err.response!.requestOptions;
      // RequestOptions options2 = err.requestOptions;
      Options _options = Options(
        method: options.method,
        headers: options.headers,
        extra: options.extra,
      );
      _options.headers!["Authorization"] = "Bearer " + LocalStorage().token;

      return _dio.request(
        options.path,
        options: _options,
        data: options.data,
        queryParameters: options.queryParameters,
      );
    }

    Map<String, dynamic>? data = err.response?.data;
    if (data!['message'].isNotEmpty) {
      NotifyHelper.showSnackBar(data['message']);
    }
    super.onError(err, handler);
    return Future.error(err);
  }
}
