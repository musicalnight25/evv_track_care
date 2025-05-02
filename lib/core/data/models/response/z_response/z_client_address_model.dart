import 'package:healthcare/core/data/models/requests/visits_reqs/clients_list_response.dart';

class ZClientAddressModel extends ClientAddress {
  final num? id;
  final num? companyId;
  final num? clientId;
  final String? clientAddressType;
  final num? clientAddressIsPrimary;
  final String? clientAddressLine1;
  final String? clientAddressLine2;
  final String? clientCounty;
  final String? clientCity;
  final String? clientState;
  final String? clientZip;
  final num? clientAddressLongitude;
  final num? clientAddressLatitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;

  ZClientAddressModel({
    this.id,
    this.companyId,
    this.clientId,
    this.clientAddressType,
    this.clientAddressIsPrimary,
    this.clientAddressLine1,
    this.clientAddressLine2,
    this.clientCounty,
    this.clientCity,
    this.clientState,
    this.clientZip,
    this.clientAddressLongitude,
    this.clientAddressLatitude,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory ZClientAddressModel.fromJson(Map<String, dynamic> json) {
    return ZClientAddressModel(
      id: json['id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      clientAddressType: json['ClientAddressType'],
      clientAddressIsPrimary: json['ClientAddressIsPrimary'],
      clientAddressLine1: json['ClientAddressLine1'],
      clientAddressLine2: json['ClientAddressLine2'],
      clientCounty: json['ClientCounty'],
      clientCity: json['ClientCity'],
      clientState: json['ClientState'],
      clientZip: json['ClientZip'],
      clientAddressLongitude: json['ClientAddressLongitude'],
      clientAddressLatitude: json['ClientAddressLatitude'],
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
      'ClientAddressType': clientAddressType,
      'ClientAddressIsPrimary': clientAddressIsPrimary,
      'ClientAddressLine1': clientAddressLine1,
      'ClientAddressLine2': clientAddressLine2,
      'ClientCounty': clientCounty,
      'ClientCity': clientCity,
      'ClientState': clientState,
      'ClientZip': clientZip,
      'ClientAddressLongitude': clientAddressLongitude,
      'ClientAddressLatitude': clientAddressLatitude,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt,
    };
  }
}
