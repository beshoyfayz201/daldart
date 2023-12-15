import 'package:daldart/core/errors/api_error_handler.dart';
import 'package:daldart/home/data/data_source/api/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

abstract class DioHelper {
  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  });
}

class DioImpl extends DioHelper {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: Endpoints.baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 8),
    ),
  );

  @override
  Future<dynamic> get({
    String? base,
    required String endPoint,
    dynamic data,
    dynamic query,
    String? token,
    CancelToken? cancelToken,
    int? timeOut,
    bool isMultipart = false,
  }) async {
    if (timeOut != null) {
      dio.options.connectTimeout = Duration(seconds: timeOut);
    }

    dio.options.headers = {

      if (isMultipart) 'Content-Type': 'multipart/form-data',
      if (!isMultipart) 'Content-Type': 'application/json',
      if (!isMultipart) 'Accept': 'application/json',
      'User-Agent':'Beshoy'
    };
    //just for test
    dio.options.baseUrl = base ?? dio.options.baseUrl;
    debugPrint('URL => ${dio.options.baseUrl + endPoint}');
    debugPrint('Header => ${dio.options.headers.toString()}');
    debugPrint('Body => $data');
    debugPrint('Query => $query');

    dio.options.baseUrl = base ?? dio.options.baseUrl;
    return await request(
      call: () async => await dio.get(
        endPoint,
        queryParameters: query,
        cancelToken: cancelToken,
      ),
    );
  }
}

extension on DioHelper {
  Future request({
    required Future<Response> Function() call,
  }) async {
    try {
      final r = await call.call();
      debugPrint("Response_Data => ${r.data}");
      debugPrint("Response_Code => ${r.statusCode}");

      return r.data;
    } on DioException catch (e) {
      debugPrint("Error_Message => ${e.message}");
      debugPrint("Error_Error => ${e.error.toString()}");
      debugPrint("Error_Type => ${e.type.toString()}");

      switch (e.type) {
        case DioExceptionType.cancel:
          throw PrimaryServerException(
            code: 100,
            error: e.toString(),
            message: "request has been canceled",
          );

        case DioExceptionType.connectionTimeout:
          throw PrimaryServerException(
            code: 100,
            error: e.toString(),
            message: "sorry! your connection has timed out!",
          );
        case DioExceptionType.sendTimeout:
          throw PrimaryServerException(
              code: 100,
              error: e.toString(),
              message: "sorry! your send request has timed out!");
        case DioExceptionType.receiveTimeout:
          throw PrimaryServerException(
              code: 100,
              error: e.toString(),
              message: "sorry! your recieve request has timed out!");
        case DioExceptionType.badResponse:
          throw PrimaryServerException(
              code: 405,
              error: e.toString(),
              message: "Not Allowed");

        default:
          throw PrimaryServerException(
              code: 400,
              error: e.toString(),
              message: "there is an Error");
      }
    } catch (e) {
      PrimaryServerException exception = e as PrimaryServerException;

      throw PrimaryServerException(
        code: exception.code,
        error: exception.error,
        message: exception.message,
      );
    }
  }
}
