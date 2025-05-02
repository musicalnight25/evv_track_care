import 'package:healthcare/core/data/models/response/z_response/z_company_model.dart';

class ZFetchResponse {
  final ZCompanyModel? company;

  ZFetchResponse({this.company});

  factory ZFetchResponse.fromJson(Map<String, dynamic> json) {
    return ZFetchResponse(
      company: json['company'] != null ? ZCompanyModel.fromJson(json['company']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company': company?.toJson(),
    };
  }
}
