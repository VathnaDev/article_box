import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'logger_utils.dart';

/// [LoggingInterceptor] is used to print logs during network requests.
/// It's better to add [LoggingInterceptor] to the tail of the interceptor queue,
/// otherwise the changes made in the interceptor behind A will not be printed out.
/// This is because the execution of interceptors is in the order of addition.

class LoggingInterceptor extends Interceptor {
  final _tag = "LoggingInterceptor";

  LoggingInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Logger.debug(tag: _tag, '===========================>');
    Logger.debug(tag: _tag, '*** API 🚀 - Start ***');
    Logger.debug(tag: _tag, 'URI: ${options.uri}');
    Logger.debug(tag: _tag, 'METHOD: ${options.method}');
    Logger.debug(tag: _tag, 'HEADERS: ${options.headers}');
    Logger.debug(tag: _tag, 'BODY: ${options.data.toString()}');

    Logger.debug(tag: _tag, '*** API 🚀 - End ***');
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Logger.debug(tag: _tag, '<==========================');
    Logger.debug(tag: _tag, '*** Api 💥 - Start ***:');
    Logger.debug(tag: _tag, 'URI: ${err.requestOptions.uri}');
    if (err.response != null) {
      Logger.debug(
        tag: _tag,
        'STATUS CODE: ${err.response?.statusCode?.toString()}',
      );
    }
    Logger.debug(tag: _tag, '$err');
    if (err.response != null) {
      Logger.debug(tag: _tag, 'REDIRECT: ${err.response?.realUri}');
      Logger.debug(tag: _tag, 'BODY:');
      Logger.debug(tag: _tag, err.response?.toString());
    }

    Logger.debug(tag: _tag, '*** Api 💥 - End ***:');
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Logger.debug(tag: _tag, '<==========================');
    Logger.debug(tag: _tag, '*** Api ✅ - Start ***');
    Logger.debug(tag: _tag, 'URI: ${response.requestOptions.uri}');
    Logger.debug(tag: _tag, 'STATUS CODE: ${response.statusCode}');
    Logger.debug(tag: _tag, 'REDIRECT: ${response.isRedirect}');
    Logger.debug(tag: _tag, 'BODY:');
    Logger.debug(tag: _tag, response.data);

    Logger.debug(tag: _tag, '*** Api ✅ - End ***');

    return handler.next(response);
  }
}
