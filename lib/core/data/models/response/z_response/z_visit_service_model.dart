class ZVisitServiceModel {
  final num? companyId;
  final num? clientId;
  final String? payerId;
  final num? serviceId;
  final String? taskName;
  final String? taskCode;

  ZVisitServiceModel({
    this.companyId,
    this.clientId,
    this.payerId,
    this.serviceId,
    this.taskName,
    this.taskCode,
  });

  factory ZVisitServiceModel.fromJson(Map<String, dynamic> json) {
    return ZVisitServiceModel(
      companyId: json["company_id"],
      clientId: json["client_id"],
      payerId: json["PayerID"],
      serviceId: json["service_id"],
      taskName: json["task_name"],
      taskCode: json["task_code"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "company_id": companyId,
      "client_id": clientId,
      "PayerID": payerId,
      "service_id": serviceId,
      "task_name": taskName,
      "task_code": taskCode,
    };
  }
}
