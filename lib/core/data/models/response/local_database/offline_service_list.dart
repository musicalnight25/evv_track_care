import '../api_response/service_list_reaponse.dart';

class OfflineServiceList {
  String? companyId;
  List<Service>? services;

  OfflineServiceList({this.companyId, this.services});

  factory OfflineServiceList.fromJson(Map<String, dynamic> json) {
    return OfflineServiceList(
      companyId: json['company_id'],
      services: (json['services'] as List<dynamic>?)
          ?.map((item) => Service.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId,
      'services': services?.map((service) => service.toJson()).toList(),
    };
  }

  // Convert instance to Map
  Map<String, dynamic> toMap() {
    return {
      'company_id': companyId,
      'services': services?.map((service) => service.toMap()).toList(),
    };
  }
}