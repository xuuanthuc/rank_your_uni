import 'dart:io';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:template/global/storage/storage_keys.dart';
import 'package:template/global/storage/storage_provider.dart';
import 'package:template/global/utilities/static_variable.dart';
import '../../global/flavor/app_flavor.dart';
import '../../global/utilities/logger.dart';
import 'error_code.dart';
import 'exception.dart';

@singleton
class ApiProvider {
  var dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
      baseUrl: AppFlavor.baseApi,
      contentType: Headers.jsonContentType,
    ),
  );

  void _addInterceptors(Dio dio, {bool? needToken}) {
    dio
      ..interceptors.clear()
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) =>
              _requestInterceptor(options, handler, needToken: needToken),
        ),
      );
  }

  void _requestInterceptor(
    RequestOptions options,
    RequestInterceptorHandler handler, {
    bool? needToken,
  }) async {
    String? token;
    if (needToken ?? true && AppFlavor.appFlavor != Flavor.admin) {
      token = await StorageProvider.instance.get(StorageKeys.token);
    } else if (needToken ?? true && AppFlavor.appFlavor == Flavor.admin) {
      token = StaticVariable.dashboardToken;
    }
    LoggerUtils.i(options.uri);
    if (token != null) {
      LoggerUtils.i(token);
      options.headers.addAll({'Authorization': 'Bearer $token'});
    }
    options.headers.addAll({'Content-Type': 'application/json; charset=utf-8'});
    handler.next(options);
  }

  Future<dynamic> request({
    String? rawData,
    Map<String, dynamic>? queryParams,
    Map<String, dynamic>? data,
    FormData? formParams,
    required Method method,
    required String url,
    bool? needToken,
  }) async {
    var responseJson = {};
    try {
      _addInterceptors(dio, needToken: needToken);
      final response = await dio.request(
        url,
        queryParameters: queryParams,
        data: (formParams != null)
            ? formParams
            : (data != null)
                ? data
                : rawData,
        options: Options(
          method: method.name,
          validateStatus: (code) {
            return code! >= 200 && code < 300;
          },
        ),
      );
      LoggerUtils.i(response.data);
      responseJson = _formatRes(
        response.statusCode,
        response.data,
        response.headers,
      );
    } on SocketException {
      throw ResponseException(ErrorCode.NO_NETWORK, 'NO_NETWORK');
    } on DioException catch (e) {
      LoggerUtils.e(e.response);
      throw ResponseException(
        e.response?.statusCode,
        e.response?.data['title'],
      );
    }
    return responseJson;
  }

  Future get(
    String url, {
    Map<String, dynamic>? params,
    bool? needToken,
  }) async {
    return await request(
      method: Method.get,
      url: url,
      queryParams: params,
      needToken: needToken,
    );
  }

  Future postMultiPart(
    String url,
    FormData formData, {
    bool? needToken,
  }) async {
    return await request(
      method: Method.post,
      url: url,
      formParams: formData,
      needToken: needToken,
    );
  }

  Future putMultiPart(
    String url,
    FormData formData, {
    bool? needToken,
  }) async {
    return await request(
      method: Method.put,
      url: url,
      formParams: formData,
      needToken: needToken,
    );
  }

  Future post(
    String url, {
    Map<String, dynamic>? params,
    bool? needToken,
  }) async {
    return await request(
      method: Method.post,
      url: url,
      data: params,
      needToken: needToken,
    );
  }

  Future put(
    String url, {
    Map<String, dynamic>? params,
    bool? needToken,
  }) async {
    return await request(
      method: Method.put,
      url: url,
      data: params,
      needToken: needToken ?? true,
    );
  }

  Future delete(String url,
      {Map<String, dynamic>? params, bool? needToken}) async {
    return await request(
      method: Method.delete,
      url: url,
      data: params,
      needToken: needToken,
    );
  }

  Future patch(
    String url, {
    Map<String, dynamic>? params,
    bool? needToken,
  }) async {
    return await request(
      method: Method.patch,
      url: url,
      data: params,
      needToken: needToken,
    );
  }

  dynamic _formatRes(int? code, dynamic data, Headers header) {
    switch (code) {
      case ErrorCode.HTTP_OK:
      case ErrorCode.HTTP_CREATED:
        if (data is List<dynamic>) {
          return {"listItem": data};
        } else {
          return data;
        }
      default:
        throw ResponseException(
          code,
          'Error occured while Communication with Server with StatusCode : $code',
        );
    }
  }
}

enum Method { get, post, patch, put, delete }
