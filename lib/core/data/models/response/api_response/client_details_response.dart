class ClientResponse {
  final Client? client;
  final List<ClientPhone>? phone;
  final List<ClientAddress>? address;
  final List<Payer>? payer;

  ClientResponse({
     this.client,
     this.phone,
     this.address,
     this.payer,
  });

  factory ClientResponse.fromJson(Map<String, dynamic> json) {
    return ClientResponse(
      client: Client.fromJson(json['client']),
      phone: List<ClientPhone>.from(json['phone'].map((x) => ClientPhone.fromJson(x))),
      address: List<ClientAddress>.from(json['address'].map((x) => ClientAddress.fromJson(x))),
      payer: json['payer'] == null && json['payer'].isEmpty ? [] : List<Payer>.from(json['payer'].map((x) => Payer.fromJson(x))),
    );
  }
}

class Client {
  final int? id;
  final int? companyId;
  final int? userId;
  final String? clientID;
  final String? clientFirstName;
  final String? clientMiddleInitial;
  final String? clientLastName;
  final String? clientQualifier;
  final String? clientMedicaidID;
  final String? clientIdentifier;
  final int? missingMedicaidID;
  final String? sequenceID;
  final String? clientCustomID;
  final String? clientOtherID;
  final String? clientTimezone;
  final String? coordinator;
  final dynamic providerAssentContPlan;
  final String? avatar;
  final String? sandata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;
  final String? clientBirthDate;
  final List<ClientPhone>? clientPhones;
  final List<ClientAddress>? clientAddresses;
  final List<ClientPayerInformation>? clientPayerInformations;

  Client({
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
     this.clientPhones,
     this.clientAddresses,
     this.clientPayerInformations,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      companyId: json['company_id'],
      userId: json['user_id'],
      clientID: json['ClientID'],
      clientFirstName: json['ClientFirstName'],
      clientMiddleInitial: json['ClientMiddleInitial'],
      clientLastName: json['ClientLastName'],
      clientQualifier: json['ClientQualifier'],
      clientMedicaidID: json['ClientMedicaidID'],
      clientIdentifier: json['ClientIdentifier'],
      missingMedicaidID: json['MissingMedicaidID'],
      sequenceID: json['SequenceID'],
      clientCustomID: json['ClientCustomID'],
      clientOtherID: json['ClientOtherID'],
      clientTimezone: json['ClientTimezone'],
      coordinator: json['Coordinator'],
      providerAssentContPlan: json['ProviderAssentContPlan'],
      avatar: json['avatar'],
      sandata: json['sandata'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      clientBirthDate: json['ClientBirthDate'],
      clientPhones: List<ClientPhone>.from(json['client_phones'].map((x) => ClientPhone.fromJson(x))),
      clientAddresses: List<ClientAddress>.from(json['client_addresses'].map((x) => ClientAddress.fromJson(x))),
      clientPayerInformations: List<ClientPayerInformation>.from(json['client_payer_informations'].map((x) => ClientPayerInformation.fromJson(x))),
    );
  }
}

class ClientPhone {
  final int? id;
  final int? companyId;
  final int? clientId;
  final String? clientPhoneType;
  final String? clientPhone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  ClientPhone({
     this.id,
     this.companyId,
     this.clientId,
     this.clientPhoneType,
     this.clientPhone,
     this.createdAt,
     this.updatedAt,
     this.deletedAt,
  });

  factory ClientPhone.fromJson(Map<String, dynamic> json) {
    return ClientPhone(
      id: json['id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      clientPhoneType: json['ClientPhoneType'],
      clientPhone: json['ClientPhone'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }
}

class ClientAddress {
  final int? id;
  final int? companyId;
  final int? clientId;
  final String? clientAddressType;
  final int? clientAddressIsPrimary;
  final String? clientAddressLine1;
  final String? clientAddressLine2;
  final String? clientCounty;
  final String? clientCity;
  final String? clientState;
  final String? clientZip;
  final String? clientAddressLongitude;
  final String? clientAddressLatitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

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
     this.deletedAt,
  });

  factory ClientAddress.fromJson(Map<String, dynamic> json) {
    return ClientAddress(
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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }
}

class ClientPayerInformation {
  final int? id;
  final int? companyId;
  final int? clientId;
  final String? payerID;
  final String? payerProgram;
  final String? procedureCode;
  final String? clientPayerID;
  final String? clientEligibilityDateBegin;
  final String? clientEligibilityDateEnd;
  final String? clientStatus;
  final String? effectiveStartDate;
  final String? effectiveEndDate;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final DateTime? deletedAt;

  ClientPayerInformation({
     this.id,
     this.companyId,
     this.clientId,
     this.payerID,
     this.payerProgram,
     this.procedureCode,
     this.clientPayerID,
     this.clientEligibilityDateBegin,
     this.clientEligibilityDateEnd,
     this.clientStatus,
     this.effectiveStartDate,
     this.effectiveEndDate,
     this.createdAt,
     this.updatedAt,
     this.deletedAt,
  });

  factory ClientPayerInformation.fromJson(Map<String, dynamic> json) {
    return ClientPayerInformation(
      id: json['id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      payerID: json['PayerID'],
      payerProgram: json['PayerProgram'],
      procedureCode: json['ProcedureCode'],
      clientPayerID: json['ClientPayerID'],
      clientEligibilityDateBegin: json['ClientEligibilityDateBegin'],
      clientEligibilityDateEnd: json['ClientEligibilityDateEnd'],
      clientStatus: json['ClientStatus'],
      effectiveStartDate: json['EffectiveStartDate'],
      effectiveEndDate: json['EffectiveEndDate'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
    );
  }
}

class Payer {
  int? id;
  String? payerID;

  Payer({this.id, this.payerID});

  Payer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    payerID = json['PayerID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['PayerID'] = this.payerID;
    return data;
  }
}

