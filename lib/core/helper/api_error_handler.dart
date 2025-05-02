import 'dart:io';

import 'package:healthcare/config/routes/app_router/route_extensions.dart';
import 'package:healthcare/config/routes/app_router/router.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../di_container.dart';
import '../../src/auth/screens/login_screen.dart';
import '../data/models/response/base/error_response.dart';
import '../utils/devlog.dart';

class ApiErrorHandler {
  static Future<String> getMessage(error) async {
    String? errorMessage;
    if (error is Exception) {
      try {
        if (error is DioException) {
          switch (error.type) {
            case DioExceptionType.cancel:
              errorMessage = "Request to API server was cancelled";
              break;
            case DioExceptionType.connectionTimeout:
              errorMessage = "Connection timeout with API server";
              break;
            case DioExceptionType.unknown:
              errorMessage = "Connection to API server failed due to internet connection";
              break;
            case DioExceptionType.receiveTimeout:
              errorMessage = "Receive timeout in connection with API server";
              break;
            case DioExceptionType.connectionError:
              errorMessage = "Connection error with API server";
              break;
            case DioExceptionType.badCertificate:
              errorMessage = "Bad certificate from API server";
              break;
            case DioExceptionType.badResponse:
              switch (error.response!.statusCode) {
                case 404:
                  errorMessage = 'Resource not found.';
                  break;
                case 500:
                  errorMessage = 'Internal server error. Please try again later.';
                  break;
                case 401:
                  errorMessage = 'Unauthorized access. Please check your credentials.';
                 rootNavigatorKey.currentContext?.pushReplacementNamed(LoginRoute());
                  // TODO :  CLEAR SHARED_PREFS DATA AS PER YOUR NEED
                  Di.sl<SharedPreferences>().clear();
                  break;
                case 503:
                  errorMessage = "Can't connect to server. Try again later.";
                  break;
                default:
                  ErrorResponse errorResponse = ErrorResponse.fromJson(error.response?.data ?? {});
                  if (errorResponse.errors.isNotEmpty) {
                    errorMessage = errorResponse.errors.first.message;
                  } else {
                    errorMessage = "Failed to load data - status code: ${error.response!.statusCode}";
                  }
              }
              break;
            case DioExceptionType.sendTimeout:
              errorMessage = "Send timeout with server";
              break;
          }
        } else if (error is FormatException) {
          errorMessage = "Data format error. Please try again.";
        } else if (error is SocketException) {
          errorMessage = "Network error. Please check your internet connection and try again.";
        } else {
          errorMessage = "Unexpected error occurred. Please try again.";
        }
      } on FormatException catch (e) {
        errorMessage = "Data format error: ${e.message}";
      }
    } else {
      devlogError("ERROR : $error");
      errorMessage = "Something went wrong.!";
    }
    return errorMessage;
  }
}
