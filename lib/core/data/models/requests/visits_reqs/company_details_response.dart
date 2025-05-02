class CompanyDetailsRes {
  int? id;
  String? name;
  String? email;
  String? telephone;
  String? addressLineOne;
  String? addressLineTwo;
  String? county;
  String? city;
  String? state;
  String? zip;
  String? website;
  String? logo;
  String? about;
  String? providerQualifier;
  String? providerID;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  List<Client>? clients;

  CompanyDetailsRes({
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
    this.providerID,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.clients,
  });

  factory CompanyDetailsRes.fromJson(Map<String, dynamic> json) => CompanyDetailsRes(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        telephone: json['telephone'],
        addressLineOne: json['addressLineOne'],
        addressLineTwo: json['addressLineTwo'],
        county: json['county'],
        city: json['city'],
        state: json['state'],
        zip: json['zip'],
        website: json['website'],
        logo: json['logo'],
        about: json['about'],
        providerQualifier: json['ProviderQualifier'],
        providerID: json['ProviderID'],
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
        clients: (json['clients'] as List<dynamic>).map((client) => Client.fromJson(client)).toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'telephone': telephone,
        'addressLineOne': addressLineOne,
        'addressLineTwo': addressLineTwo,
        'county': county,
        'city': city,
        'state': state,
        'zip': zip,
        'website': website,
        'logo': logo,
        'about': about,
        'ProviderQualifier': providerQualifier,
        'ProviderID': providerID,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
        'clients': clients?.map((client) => client.toJson()).toList(),
      };
}

class Client {
  int? id;
  int? companyId;
  int? userId;
  String? clientID;
  String? clientFirstName;
  String? clientMiddleInitial;
  String? clientLastName;
  String? clientQualifier;
  String? clientMedicaidID;
  String? clientIdentifier;
  int? missingMedicaidID;
  String? sequenceID;
  String? clientCustomID;
  String? clientOtherID;
  String? clientTimezone;
  String? coordinator;
  int? providerAssentContPlan;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Client.fromJson(Map<String, dynamic> json) => Client(
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
        createdAt: DateTime.parse(json['created_at']),
        updatedAt: DateTime.parse(json['updated_at']),
        deletedAt: json['deleted_at'] != null ? DateTime.parse(json['deleted_at']) : null,
      );

  Map<String, dynamic> toJson() => {
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
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'deleted_at': deletedAt?.toIso8601String(),
      };
}
