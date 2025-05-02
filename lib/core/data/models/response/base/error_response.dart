class ErrorResponse {
  final List<ErrorDetail> errors;

  ErrorResponse({required this.errors});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    var errorsJson = json['errors'] as List<dynamic>?;
    var errors = errorsJson != null
        ? errorsJson.map((e) => ErrorDetail.fromJson(e)).toList()
        : <ErrorDetail>[];
    return ErrorResponse(errors: errors);
  }
}

class ErrorDetail {
  final String message;

  ErrorDetail({required this.message});

  factory ErrorDetail.fromJson(Map<String, dynamic> json) {
    return ErrorDetail(message: json['message']);
  }
}
