import 'dart:io';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import '../../../generated/l10n.dart';

import '../utils.dart';

/// This wrapper class parse different types of exceptions so our view only needs to know the error message and error code
/// First, it will try to parse to [SetelStandardError], if fails, it will return the actual response code and message
/// If you need the response in a custom class, you can use [custom] function and pass in the class you want to convert to
/// For example, if I know the response is in [LoginError] format, i can write
/// throw ApiException(exception: e).custom(LoginError());
/// Feel free to modify this class to add more error implementation and properties if need

class ApiException {
  String errorCode;
  String errorMessage = '';
  DioError exception;

  String get displayError {
    if (exception.type == DioErrorType.CONNECT_TIMEOUT) {
      return S.current.connectTimeout;
    }

    if (exception.type == DioErrorType.RECEIVE_TIMEOUT) {
      return S.current.receiveTimeout;
    }

    if (exception.type == DioErrorType.SEND_TIMEOUT) {
      return S.current.sendTimeout;
    }

    if (exception.type == DioErrorType.DEFAULT) {
      if (exception.error is SocketException) {
        return S.current.pleaseCheckYourInternetConnection;
      }
      return exception.error.toString();
    }

    // Prioritize error returned in response body
    final responseData = exception.response.data;
    if (responseData is Map && responseData['message'] != null) {
      final message = responseData['message'];
      if (message is List) {
        return message
            .map((e) => toBeginningOfSentenceCase(e.toString()))
            .join('\n');
      }

      return toBeginningOfSentenceCase(message.toString());
    }

    if (responseData is Map && responseData['error'] != null) {
      return responseData['error'].toString();
    }

    // Fallback to request error if no error returned in response body
    return exception.error?.toString() ?? exception?.response?.statusMessage;
  }

  ApiException({DioError exception}) {
    switch (exception.type) {
      case DioErrorType.RESPONSE:
        {
          dynamic errorBody = exception.response.data;
          try {
            // try to parse to setel standard error
            var standardError =
                StandardError.fromJson(errorBody);

            errorMessage = standardError.message;
            errorCode = standardError.errorCode;
            ;

            // map 401 to meaningful messages
            if (TokenInterceptor.unauthorizedTokenCodes
                .contains(standardError.statusCode)) {
              errorMessage = S.current.invalidCredentials;
            }
          } catch (e) {
            errorMessage = e.toString();

            // Try to get Dio internal error which might due to service not available
            if (exception.error != null) {
              errorMessage = exception.error.toString();
            }

            if (exception.response.statusMessage != null &&
                exception.response.statusMessage.isNotEmpty) {
              errorMessage = exception.response.statusMessage;
            }
          }
        }
        break;
      default:
        {
          switch (exception.type) {
            case DioErrorType.CANCEL:
              {
                errorMessage = S.current.cancelled;
                break;
              }
            case DioErrorType.CONNECT_TIMEOUT:
            case DioErrorType.RECEIVE_TIMEOUT:
            case DioErrorType.SEND_TIMEOUT:
              {
                errorMessage = S.current.connectionTimedOut;
              }
              break;
            default:
              {
                errorMessage = S.current.connectionProblem;
              }
          }
        }
    }
  }


}
