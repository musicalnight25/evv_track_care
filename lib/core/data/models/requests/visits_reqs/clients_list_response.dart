

import 'dart:convert';

import 'package:healthcare/core/data/models/response/z_response/z_client_address_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_client_model.dart';

import '../../response/client_visits_response.dart';

class ClientsList {
  List<ClientListResponse>? list;

  ClientsList({this.list});
}

class ClientListResponse {
  final ProviderIdentification? providerIdentification;
  final Client? client;
  final List<ClientAddress>? clientAddress;
  final List<ClientPhone>? clientPhone;
  final List<Visit>? visitTime;

  ClientListResponse({
    this.providerIdentification,
    this.client,
    this.clientAddress,
    this.clientPhone,
    this.visitTime,
  }) ;

  factory ClientListResponse.fromRawJson(String str) => ClientListResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientListResponse.fromJson(Map<String, dynamic> json) => ClientListResponse(
    providerIdentification: json["ProviderIdentification"] == null ? null : ProviderIdentification.fromJson(json["ProviderIdentification"]),
    client: json["client"] == null ? null : Client.fromJson(json["client"]),
    clientAddress: json["ClientAddress"] == null ? [] : List<ClientAddress>.from(json["ClientAddress"]!.map((x) => ClientAddress.fromJson(x))),
    clientPhone: json["ClientPhone"] == null ? [] : List<ClientPhone>.from(json["ClientPhone"]!.map((x) => ClientPhone.fromJson(x))),
    visitTime: json["VisitTime"] == null ? [] : List<Visit>.from(json["VisitTime"]!.map((x) => Visit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ProviderIdentification": providerIdentification?.toJson(),
    "client": client?.toJson(),
    "ClientAddress": clientAddress == null ? [] : List<dynamic>.from(clientAddress!.map((x) => x.toJson())),
    "ClientPhone": clientPhone == null ? [] : List<dynamic>.from(clientPhone!.map((x) => x.toJson())),
    "VisitTime": visitTime == null ? [] : List<dynamic>.from(visitTime!.map((x) => x.toJson())),
  };
}

class Client {
  final num? id;
  final num? companyId;
  final num? userId;
  final String? clientId;
  final String? clientFirstName;
  final String? clientMiddleInitial;
  final String? clientLastName;
  final String? clientQualifier;
  final String? clientMedicaidId;
  final String? clientIdentifier;
  final num? missingMedicaidId;
  final String? sequenceId;
  final String? clientCustomId;
  final String? clientOtherId;
  final Zone? clientTimezone;
  final String? coordinator;
  final num? providerAssentContPlan;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ProviderIdentification? company;
  final List<ClientAddress>? clientAddresses;
  final List<ClientPhone>? clientPhones;
  final List<Visit>? visits;
  final String? avatar;

  Client({
    this.id,
    this.companyId,
    this.userId,
    this.clientId,
    this.clientFirstName,
    this.clientMiddleInitial,
    this.clientLastName,
    this.clientQualifier,
    this.clientMedicaidId,
    this.clientIdentifier,
    this.missingMedicaidId,
    this.sequenceId,
    this.clientCustomId,
    this.clientOtherId,
    this.clientTimezone,
    this.coordinator,
    this.providerAssentContPlan,
    this.createdAt,
    this.updatedAt,
    this.company,
    this.clientAddresses,
    this.clientPhones,
    this.visits,
    this.avatar,
  });

  factory Client.fromRawJson(String str) => Client.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["id"],
    companyId: json["company_id"],
    userId: json["user_id"],
    clientId: json["ClientID"],
    clientFirstName: json["ClientFirstName"],
    clientMiddleInitial: json["ClientMiddleInitial"],
    clientLastName: json["ClientLastName"],
    clientQualifier: json["ClientQualifier"],
    clientMedicaidId: json["ClientMedicaidID"],
    clientIdentifier: json["ClientIdentifier"],
    missingMedicaidId: json["MissingMedicaidID"],
    sequenceId: json["SequenceID"],
    clientCustomId: json["ClientCustomID"],
    clientOtherId: json["ClientOtherID"],
    clientTimezone: zoneValues.map[json["ClientTimezone"]]!,
    coordinator: json["Coordinator"],
    providerAssentContPlan: json["ProviderAssentContPlan"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    company: json["company"] == null ? null : ProviderIdentification.fromJson(json["company"]),
    clientAddresses: json["client_addresses"] == null ? [] : List<ClientAddress>.from(json["client_addresses"]!.map((x) => ClientAddress.fromJson(x))),
    clientPhones: json["client_phones"] == null ? [] : List<ClientPhone>.from(json["client_phones"]!.map((x) => ClientPhone.fromJson(x))),
    visits: json["visits"] == null ? [] : List<Visit>.from(json["visits"]!.map((x) => Visit.fromJson(x))),
    avatar: json["avatar"] ?? ""
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "user_id": userId,
    "ClientID": clientId,
    "ClientFirstName": clientFirstName,
    "ClientMiddleInitial": clientMiddleInitial,
    "ClientLastName": clientLastName,
    "ClientQualifier": clientQualifierValues.reverse[clientQualifier],
    "ClientMedicaidID": clientMedicaidId,
    "ClientIdentifier": clientIdentifier,
    "MissingMedicaidID": missingMedicaidId,
    "SequenceID": sequenceId,
    "ClientCustomID": clientCustomId,
    "ClientOtherID": clientOtherId,
    "ClientTimezone": zoneValues.reverse[clientTimezone],
    "Coordinator": coordinator,
    "ProviderAssentContPlan": providerAssentContPlan,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "company": company?.toJson(),
    "client_addresses": clientAddresses == null ? [] : List<dynamic>.from(clientAddresses!.map((x) => x.toJson())),
    "client_phones": clientPhones == null ? [] : List<dynamic>.from(clientPhones!.map((x) => x.toJson())),
    "visits": visits == null ? [] : List<dynamic>.from(visits!.map((x) => x.toJson())),
    "avatar": avatar == null ? "" : avatar.toString()
  };
}

class ClientAddress {
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

  ClientAddress({
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
  });

  factory ClientAddress.fromRawJson(String str) => ClientAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientAddress.fromJson(Map<String, dynamic> json) => ClientAddress(
    id: json["id"],
    companyId: json["company_id"],
    clientId: json["client_id"],
    clientAddressType: json["ClientAddressType"],
    clientAddressIsPrimary: json["ClientAddressIsPrimary"],
    clientAddressLine1: json["ClientAddressLine1"],
    clientAddressLine2: json["ClientAddressLine2"],
    clientCounty: json["ClientCounty"],
    clientCity: json["ClientCity"],
    clientState: json["ClientState"],
    clientZip: json["ClientZip"],
    clientAddressLongitude: json["ClientAddressLongitude"]?.toDouble(),
    clientAddressLatitude: json["ClientAddressLatitude"]?.toDouble(),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "client_id": clientId,
    "ClientAddressType": clientAddressType,
    "ClientAddressIsPrimary": clientAddressIsPrimary,
    "ClientAddressLine1": clientAddressLine1,
    "ClientAddressLine2": clientAddressLine2,
    "ClientCounty": clientCounty,
    "ClientCity": clientCity,
    "ClientState": clientState,
    "ClientZip": clientZip,
    "ClientAddressLongitude": clientAddressLongitude,
    "ClientAddressLatitude": clientAddressLatitude,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class ClientPhone {
  final num? id;
  final num? companyId;
  final num? clientId;
  final String? clientPhoneType;
  final String? clientPhone;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ClientPhone({
    this.id,
    this.companyId,
    this.clientId,
    this.clientPhoneType,
    this.clientPhone,
    this.createdAt,
    this.updatedAt,
  });

  factory ClientPhone.fromRawJson(String str) => ClientPhone.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ClientPhone.fromJson(Map<String, dynamic> json) => ClientPhone(
    id: json["id"],
    companyId: json["company_id"],
    clientId: json["client_id"],
    clientPhoneType: json["ClientPhoneType"],
    clientPhone: json["ClientPhone"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "client_id": clientId,
    "ClientPhoneType": clientPhoneTypeValues.reverse[clientPhoneType],
    "ClientPhone": clientPhone,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

enum ClientPhoneType {
  HOME,
  MOBILE,
  OFFICE,
  BUSINESS,
  OTHER,
}

final clientPhoneTypeValues = EnumValues({
  "Home": ClientPhoneType.HOME,
  "Mobile": ClientPhoneType.MOBILE,
  "Office": ClientPhoneType.OFFICE,
  "Business": ClientPhoneType.BUSINESS,
  "Other": ClientPhoneType.OTHER
});

enum ClientQualifier {
  CLIENT_MEDICAID_ID,
  CLIENT_CUSTOM_ID
}

final clientQualifierValues = EnumValues({
  "ClientMedicaidID": ClientQualifier.CLIENT_MEDICAID_ID,
  "ClientCustomID": ClientQualifier.CLIENT_CUSTOM_ID
});

enum Zone {
  US_EASTERN
}

final zoneValues = EnumValues({
  "US/Eastern": Zone.US_EASTERN
});

class ProviderIdentification {
  final num? id;
  final String? name;
  final String? email;
  final String? telephone;
  final dynamic addressLineOne;
  final dynamic addressLineTwo;
  final String? county;
  final String? city;
  final String? state;
  final String? zip;
  final dynamic website;
  final dynamic logo;
  final dynamic about;
  final String? providerQualifier;
  final String? providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ProviderIdentification({
    this.id,
    this.name,
    this.email,
    this.telephone,
    this.addressLineOne,
    this.addressLineTwo,
    this.county,
    this.city,
    this.state,
    this.zip,
    this.website,
    this.logo,
    this.about,
    this.providerQualifier,
    this.providerId,
    this.createdAt,
    this.updatedAt,
  });

  factory ProviderIdentification.fromRawJson(String str) => ProviderIdentification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProviderIdentification.fromJson(Map<String, dynamic> json) => ProviderIdentification(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    telephone: json["telephone"],
    addressLineOne: json["addressLineOne"],
    addressLineTwo: json["addressLineTwo"],
    county: json["county"],
    city: json["city"],
    state: json["state"],
    zip: json["zip"],
    website: json["website"],
    logo: json["logo"],
    about: json["about"],
    providerQualifier: json["ProviderQualifier"],
    providerId: json["ProviderID"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "telephone": telephone,
    "addressLineOne": addressLineOne,
    "addressLineTwo": addressLineTwo,
    "county": county,
    "city": city,
    "state": state,
    "zip": zip,
    "website": website,
    "logo": logo,
    "about": about,
    "ProviderQualifier": providerQualifier,
    "ProviderID": providerId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

// class Visit {
//   final num? id;
//   final num? companyId;
//   final num? visitClientId;
//   final num? userId;
//   final String? status;
//   final num? clientPayerId;
//   final String? visitOtherId;
//   final String? sequenceId;
//   final String? employeeQualifier;
//   final dynamic employeeOtherId;
//   final dynamic employeeIdentifier;
//   final String? groupCode;
//   final dynamic clientId;
//   final num? visitCancelledIndicator;
//   final String? payerId;
//   final String? payerProgram;
//   final String? procedureCode;
//   final dynamic modifier1;
//   final dynamic modifier2;
//   final dynamic modifier3;
//   final dynamic modifier4;
//   final String? visitTimeZone;
//   final DateTime? scheduleStartTime;
//   final DateTime? scheduleEndTime;
//   final String? contingencyPlan;
//   final num? reschedule;
//   final DateTime? adjInDateTime;
//   final DateTime? adjOutDateTime;
//   final num? billVisit;
//   final num? hoursToBill;
//   final num? hoursToPay;
//   final dynamic memo;
//   final num? clientVerifiedTimes;
//   final num? clientVerifiedService;
//   final num? clientSignatureAvailable;
//   final num? clientVoiceRecording;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//
//   Visit({
//     this.id,
//     this.companyId,
//     this.visitClientId,
//     this.userId,
//     this.status,
//     this.clientPayerId,
//     this.visitOtherId,
//     this.sequenceId,
//     this.employeeQualifier,
//     this.employeeOtherId,
//     this.employeeIdentifier,
//     this.groupCode,
//     this.clientId,
//     this.visitCancelledIndicator,
//     this.payerId,
//     this.payerProgram,
//     this.procedureCode,
//     this.modifier1,
//     this.modifier2,
//     this.modifier3,
//     this.modifier4,
//     this.visitTimeZone,
//     this.scheduleStartTime,
//     this.scheduleEndTime,
//     this.contingencyPlan,
//     this.reschedule,
//     this.adjInDateTime,
//     this.adjOutDateTime,
//     this.billVisit,
//     this.hoursToBill,
//     this.hoursToPay,
//     this.memo,
//     this.clientVerifiedTimes,
//     this.clientVerifiedService,
//     this.clientSignatureAvailable,
//     this.clientVoiceRecording,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory Visit.fromRawJson(String str) => Visit.fromJson(json.decode(str));
//
//   String toRawJson() => json.encode(toJson());
//
//   factory Visit.fromJson(Map<String, dynamic> json) => Visit(
//     id: json["id"],
//     companyId: json["company_id"],
//     visitClientId: json["client_id"],
//     userId: json["user_id"],
//     status: json["status"],
//     clientPayerId: json["client_payer_id"],
//     visitOtherId: json["VisitOtherID"],
//     sequenceId: json["SequenceID"],
//     employeeQualifier: json["EmployeeQualifier"],
//     employeeOtherId: json["EmployeeOtherID"],
//     employeeIdentifier: json["EmployeeIdentifier"],
//     groupCode: json["GroupCode"],
//     clientId: json["ClientID"],
//     visitCancelledIndicator: json["VisitCancelledIndicator"],
//     payerId: json["PayerID"],
//     payerProgram: json["PayerProgram"],
//     procedureCode: json["ProcedureCode"],
//     modifier1: json["Modifier1"],
//     modifier2: json["Modifier2"],
//     modifier3: json["Modifier3"],
//     modifier4: json["Modifier4"],
//     visitTimeZone: json["VisitTimeZone"],
//     scheduleStartTime: json["ScheduleStartTime"] == null ? null : DateTime.parse(json["ScheduleStartTime"]),
//     scheduleEndTime: json["ScheduleEndTime"] == null ? null : DateTime.parse(json["ScheduleEndTime"]),
//     contingencyPlan: json["ContingencyPlan"],
//     reschedule: json["Reschedule"],
//     adjInDateTime: json["AdjInDateTime"] == null ? null : DateTime.parse(json["AdjInDateTime"]),
//     adjOutDateTime: json["AdjOutDateTime"] == null ? null : DateTime.parse(json["AdjOutDateTime"]),
//     billVisit: json["BillVisit"],
//     hoursToBill: json["HoursToBill"],
//     hoursToPay: json["HoursToPay"],
//     memo: json["Memo"],
//     clientVerifiedTimes: json["ClientVerifiedTimes"],
//     clientVerifiedService: json["ClientVerifiedService"],
//     clientSignatureAvailable: json["ClientSignatureAvailable"],
//     clientVoiceRecording: json["ClientVoiceRecording"],
//     createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//     updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "company_id": companyId,
//     "client_id": visitClientId,
//     "user_id": userId,
//     "status": status,
//     "client_payer_id": clientPayerId,
//     "VisitOtherID": visitOtherId,
//     "SequenceID": sequenceId,
//     "EmployeeQualifier": employeeQualifierValues.reverse[employeeQualifier],
//     "EmployeeOtherID": employeeOtherId,
//     "EmployeeIdentifier": employeeIdentifier,
//     "GroupCode": clientQualifierValues.reverse[groupCode],
//     "ClientID": clientId,
//     "VisitCancelledIndicator": visitCancelledIndicator,
//     "PayerID": payerId,
//     "PayerProgram": payerProgram,
//     "ProcedureCode": procedureCode,
//     "Modifier1": modifier1,
//     "Modifier2": modifier2,
//     "Modifier3": modifier3,
//     "Modifier4": modifier4,
//     "VisitTimeZone": zoneValues.reverse[visitTimeZone],
//     "ScheduleStartTime": scheduleStartTime?.toIso8601String(),
//     "ScheduleEndTime": scheduleEndTime?.toIso8601String(),
//     "ContingencyPlan": contingencyPlanValues.reverse[contingencyPlan],
//     "Reschedule": reschedule,
//     "AdjInDateTime": adjInDateTime?.toIso8601String(),
//     "AdjOutDateTime": adjOutDateTime?.toIso8601String(),
//     "BillVisit": billVisit,
//     "HoursToBill": hoursToBill,
//     "HoursToPay": hoursToPay,
//     "Memo": memo,
//     "ClientVerifiedTimes": clientVerifiedTimes,
//     "ClientVerifiedService": clientVerifiedService,
//     "ClientSignatureAvailable": clientSignatureAvailable,
//     "ClientVoiceRecording": clientVoiceRecording,
//     "created_at": createdAt?.toIso8601String(),
//     "updated_at": updatedAt?.toIso8601String(),
//   };
// }

enum ContingencyPlan {
  CONTINGENCY_PLAN_N_A,
  NONE,
  N_A
}

final contingencyPlanValues = EnumValues({
  "n/a": ContingencyPlan.CONTINGENCY_PLAN_N_A,
  "None": ContingencyPlan.NONE,
  "N/A": ContingencyPlan.N_A
});

enum EmployeeQualifier {
  EMPLOYEE_CUSTOM_ID
}

final employeeQualifierValues = EnumValues({
  "EmployeeCustomID": EmployeeQualifier.EMPLOYEE_CUSTOM_ID
});



class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
