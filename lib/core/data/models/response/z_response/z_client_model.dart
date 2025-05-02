import 'package:healthcare/core/data/models/requests/visits_reqs/clients_list_response.dart';
import 'package:healthcare/core/data/models/response/z_response/z_client_address_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_client_phone_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_company_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_visit_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_visit_service_model.dart';

class ZClientModel extends ClientListResponse {
  final num? id;
  final num? companyId;
  final num? userId;
  final String? clientID;
  final String? clientFirstName;
  final String? clientMiddleInitial;
  final String? clientLastName;
  final String? clientQualifier;
  final String? clientMedicaidID;
  final String? clientIdentifier;
  final num? missingMedicaidID;
  final String? sequenceID;
  final String? clientCustomID;
  final String? clientOtherID;
  final String? clientTimezone;
  final String? coordinator;
  final String? providerAssentContPlan;
  final String? avatar;
  final String? sandata;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  final String? clientBirthDate;
  List<ZVisitModel>? visits;
  List<ZVisitServiceModel>? services;
  ZCompanyModel? company;
  List<ZClientAddressModel>? clientAddresses;
  List<ZClientPhoneModel>? clientPhones;

  ZClientModel({
    this.id,
    this.companyId,
    this.userId,
    this.clientID,
    this.clientFirstName,
    this.clientMiddleInitial,
    this.clientLastName,
    this.clientQualifier,
    this.clientMedicaidID,
    this.clientIdentifier,
    this.missingMedicaidID,
    this.sequenceID,
    this.clientCustomID,
    this.clientOtherID,
    this.clientTimezone,
    this.coordinator,
    this.providerAssentContPlan,
    this.avatar,
    this.sandata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.clientBirthDate,
    this.visits = const [],
    this.services,
    this.company,
    this.clientAddresses = const [],
    this.clientPhones,
  }) : super(
            providerIdentification: ProviderIdentification(
              name: "${clientFirstName}${(clientMiddleInitial?.trim() ?? "") == "" ? "" : " ${clientMiddleInitial}"} $clientLastName",
            ),
            clientAddress: clientAddresses,
            client: Client(
              id: id?.toInt(),
              userId: userId?.toInt(),
              avatar: avatar,
              clientFirstName: clientFirstName,
              clientMedicaidId: clientMedicaidID,
              clientLastName: clientLastName,
              clientId: clientID,
              companyId: companyId?.toInt(),
              missingMedicaidId: missingMedicaidID?.toInt(),
              sequenceId: sequenceID,
              clientAddresses: clientAddresses,
              clientPhones: clientPhones,
            ));

  ZClientModel copyWith({
    num? id,
    num? companyId,
    num? userId,
    String? clientID,
    String? clientFirstName,
    String? clientMiddleInitial,
    String? clientLastName,
    String? clientQualifier,
    String? clientMedicaidID,
    String? clientIdentifier,
    num? missingMedicaidID,
    String? sequenceID,
    String? clientCustomID,
    String? clientOtherID,
    String? clientTimezone,
    String? coordinator,
    String? providerAssentContPlan,
    String? avatar,
    String? sandata,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? clientBirthDate,
    List<ZVisitModel>? visits,
    List<ZVisitServiceModel>? services,
    ZCompanyModel? company,
    List<ZClientAddressModel>? clientAddresses,
    List<ZClientPhoneModel>? clientPhones,
  }) {
    return ZClientModel(
      id: id ?? this.id,
      companyId: companyId ?? this.companyId,
      userId: userId ?? this.userId,
      clientID: clientID ?? this.clientID,
      clientFirstName: clientFirstName ?? this.clientFirstName,
      clientMiddleInitial: clientMiddleInitial ?? this.clientMiddleInitial,
      clientLastName: clientLastName ?? this.clientLastName,
      clientQualifier: clientQualifier ?? this.clientQualifier,
      clientMedicaidID: clientMedicaidID ?? this.clientMedicaidID,
      clientIdentifier: clientIdentifier ?? this.clientIdentifier,
      missingMedicaidID: missingMedicaidID ?? this.missingMedicaidID,
      sequenceID: sequenceID ?? this.sequenceID,
      clientCustomID: clientCustomID ?? this.clientCustomID,
      clientOtherID: clientOtherID ?? this.clientOtherID,
      clientTimezone: clientTimezone ?? this.clientTimezone,
      coordinator: coordinator ?? this.coordinator,
      providerAssentContPlan: providerAssentContPlan ?? this.providerAssentContPlan,
      avatar: avatar ?? this.avatar,
      sandata: sandata ?? this.sandata,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      clientBirthDate: clientBirthDate ?? this.clientBirthDate,
      visits: visits ?? this.visits,
      services: services ?? this.services,
      company: company ?? this.company,
      clientAddresses: clientAddresses ?? this.clientAddresses,
      clientPhones: clientPhones ?? this.clientPhones,
    );
  }

  factory ZClientModel.fromJson(Map<String, dynamic> json) {
    return ZClientModel(
      id: json['id'],
      companyId: json['company_id'],
      userId: json['user_id'],
      clientID: json['ClientID']?.toString(),
      clientFirstName: json['ClientFirstName']?.toString(),
      clientMiddleInitial: json['ClientMiddleInitial']?.toString(),
      clientLastName: json['ClientLastName']?.toString(),
      clientQualifier: json['ClientQualifier']?.toString(),
      clientMedicaidID: json['ClientMedicaidID']?.toString(),
      clientIdentifier: json['ClientIdentifier']?.toString(),
      missingMedicaidID: json['MissingMedicaidID'],
      sequenceID: json['SequenceID']?.toString(),
      clientCustomID: json['ClientCustomID']?.toString(),
      clientOtherID: json['ClientOtherID']?.toString(),
      clientTimezone: json['ClientTimezone']?.toString(),
      coordinator: json['Coordinator']?.toString(),
      providerAssentContPlan: json['ProviderAssentContPlan']?.toString(),
      avatar: json['avatar']?.toString(),
      sandata: json['sandata']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
      clientBirthDate: json['ClientBirthDate']?.toString(),
      visits: (json['visits'] as List?)?.map((e) => ZVisitModel.fromJson(e)).toList(),
      services: (json['services'] as List?)?.map((e) => ZVisitServiceModel.fromJson(e)).toList(),
      company: json['company'] != null ? ZCompanyModel.fromJson(json['company']) : null,
      clientAddresses: (json['client_addresses'] as List?)?.map((e) => ZClientAddressModel.fromJson(e)).toList(),
      clientPhones: (json['client_phones'] as List?)?.map((e) => ZClientPhoneModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'user_id': userId,
      'ClientID': clientID,
      'ClientFirstName': clientFirstName,
      'ClientMiddleInitial': clientMiddleInitial,
      'ClientLastName': clientLastName,
      'ClientQualifier': clientQualifier,
      'ClientMedicaidID': clientMedicaidID,
      'ClientIdentifier': clientIdentifier,
      'MissingMedicaidID': missingMedicaidID,
      'SequenceID': sequenceID,
      'ClientCustomID': clientCustomID,
      'ClientOtherID': clientOtherID,
      'ClientTimezone': clientTimezone,
      'Coordinator': coordinator,
      'ProviderAssentContPlan': providerAssentContPlan,
      'avatar': avatar,
      'sandata': sandata,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'ClientBirthDate': clientBirthDate,
      // 'visits': visits?.map((e) => e.toJson()).toList(),
      // 'services': services?.map((e) => e.toJson()).toList(),
      // 'company': company?.toJson(),
      // 'client_addresses': clientAddresses?.map((e) => e.toJson()).toList(),
      // 'client_phones': clientPhones?.map((e) => e.toJson()).toList(),
    };
  }
}
