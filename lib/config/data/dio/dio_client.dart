import 'package:healthcare/core/constants/app_constants.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/helper/api_error_handler.dart';
import '../../../core/utils/devlog.dart';
import '../../error/exceptions.dart';
import 'content_types.dart';
import 'logging_intercepter.dart';

class DioClient {
  final String baseUrl;
  final LoggingInterceptor loggingInterceptor;
  final SharedPreferences sharedPreferences;

  final Dio _dio;
  String? _token;

  DioClient(
    this.baseUrl, {
    required Dio dio,
    required this.loggingInterceptor,
    required this.sharedPreferences,
  }) : _dio = dio {
    _dio
      ..options.baseUrl = baseUrl
      ..options.connectTimeout = const Duration(minutes: 1)
      ..options.receiveTimeout = const Duration(minutes: 1)
      ..options.validateStatus = (status) {
        return status! < 500;
      }
      ..httpClientAdapter;
    dio.interceptors.add(loggingInterceptor);
  }

  Future<Response> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    CType contentType = CType.json,
  }) async {
    _token = sharedPreferences.getString(AppConsts.token);
    try {
      var response = await _dio.get(
        uri,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: {
                if (_token != null && _token?.trim() != "") 'Authorization': 'Bearer $_token',
                'Content-Type': contentType.value,
              },
            ),
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      devlog("Token::$_token");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else {
        throw DioException.badResponse(statusCode: response.statusCode ?? 401, requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      devlogError("GET API ERROR message : ");
      final message = await ApiErrorHandler.getMessage(e);
      devlogError("GET API ERROR message : $message");
      throw ServerException(message);
    }
  }

  Future<Response> post(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CType contentType = CType.json,
  }) async {
    try {
      _token = sharedPreferences.getString(AppConsts.token);
      var response = await _dio.post(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: {
                if (_token != null && _token?.trim() != "") 'Authorization': 'Bearer $_token',
                'Content-Type': contentType.value,
              },
            ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      devlog("Token::$_token");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else {
        throw DioException.badResponse(statusCode: response.statusCode ?? 401, requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      final message = await ApiErrorHandler.getMessage(e);
      throw ServerException(message);
    }
  }

  Future<Response> put(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    CType contentType = CType.json,
  }) async {
    try {
      _token = sharedPreferences.getString(AppConsts.token);
      var response = await _dio.put(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: {
                if (_token != null && _token?.trim() != "") 'Authorization': 'Bearer $_token',
                'Content-Type': contentType.value,
              },
            ),
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      devlog("Token::$_token");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else {
        throw DioException.badResponse(statusCode: response.statusCode ?? 401, requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      final message = await ApiErrorHandler.getMessage(e);
      throw ServerException(message);
    }
  }

  Future<Response> delete(
    String uri, {
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    CType contentType = CType.json,
  }) async {
    try {
      _token = sharedPreferences.getString(AppConsts.token);
      var response = await _dio.delete(
        uri,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: {
                if (_token != null && _token?.trim() != "") 'Authorization': 'Bearer $_token',
                'Content-Type': contentType.value,
              },
            ),
        cancelToken: cancelToken,
      );
      devlog("Token::$_token");
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response;
      } else {
        throw DioException.badResponse(statusCode: response.statusCode ?? 401, requestOptions: response.requestOptions, response: response);
      }
    } catch (e) {
      final message = await ApiErrorHandler.getMessage(e);
      throw ServerException(message);
    }
  }
}
