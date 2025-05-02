import 'package:healthcare/core/data/models/requests/visits_reqs/clients_list_response.dart';

class ZClientPhoneModel  extends ClientPhone{
  final num? id;
  final num? companyId;
  final num? clientId;
  final String? clientPhoneType;
  final String? clientPhone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;

  ZClientPhoneModel({
    this.id,
    this.companyId,
    this.clientId,
    this.clientPhoneType,
    this.clientPhone,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ZClientPhoneModel.fromJson(Map<String, dynamic> json) {
    return ZClientPhoneModel(
      id: json['id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      clientPhoneType: json['ClientPhoneType'],
      clientPhone: json['ClientPhone'],
      createdAt: json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
      updatedAt: json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'client_id': clientId,
      'ClientPhoneType': clientPhoneType,
      'ClientPhone': clientPhone,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt,
    };
  }
}
