class CompanyResponse {
  Company? company;
  List<Client>? clients;

  CompanyResponse({this.company, this.clients});

  CompanyResponse.fromJson(Map<String, dynamic> json) {
    company = json['company'] != null ? Company.fromJson(json['company']) : null;
    if (json['clients'] != null) {
      clients = <Client>[];
      json['clients'].forEach((v) {
        clients!.add(Client.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (clients != null) {
      data['clients'] = clients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Company {
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
  String? createdAt;
  String? updatedAt;
  List<Client>? clients;

  Company({
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
    this.clients,
  });

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    telephone = json['telephone'];
    addressLineOne = json['addressLineOne'];
    addressLineTwo = json['addressLineTwo'];
    county = json['county'];
    city = json['city'];
    state = json['state'];
    zip = json['zip'];
    website = json['website'];
    logo = json['logo'];
    about = json['about'];
    providerQualifier = json['ProviderQualifier'];
    providerID = json['ProviderID'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['clients'] != null) {
      clients = <Client>[];
      json['clients'].forEach((v) {
        clients!.add(Client.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['telephone'] = telephone;
    data['addressLineOne'] = addressLineOne;
    data['addressLineTwo'] = addressLineTwo;
    data['county'] = county;
    data['city'] = city;
    data['state'] = state;
    data['zip'] = zip;
    data['website'] = website;
    data['logo'] = logo;
    data['about'] = about;
    data['ProviderQualifier'] = providerQualifier;
    data['ProviderID'] = providerID;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (clients != null) {
      data['clients'] = clients!.map((v) => v.toJson()).toList();
    }
    return data;
  }
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
  String? createdAt;
  String? updatedAt;

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
  });

  Client.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyId = json['company_id'];
    userId = json['user_id'];
    clientID = json['ClientID'];
    clientFirstName = json['ClientFirstName'];
    clientMiddleInitial = json['ClientMiddleInitial'];
    clientLastName = json['ClientLastName'];
    clientQualifier = json['ClientQualifier'];
    clientMedicaidID = json['ClientMedicaidID'];
    clientIdentifier = json['ClientIdentifier'];
    missingMedicaidID = json['MissingMedicaidID'];
    sequenceID = json['SequenceID'];
    clientCustomID = json['ClientCustomID'];
    clientOtherID = json['ClientOtherID'];
    clientTimezone = json['ClientTimezone'];
    coordinator = json['Coordinator'];
    providerAssentContPlan = json['ProviderAssentContPlan'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_id'] = companyId;
    data['user_id'] = userId;
    data['ClientID'] = clientID;
    data['ClientFirstName'] = clientFirstName;
    data['ClientMiddleInitial'] = clientMiddleInitial;
    data['ClientLastName'] = clientLastName;
    data['ClientQualifier'] = clientQualifier;
    data['ClientMedicaidID'] = clientMedicaidID;
    data['ClientIdentifier'] = clientIdentifier;
    data['MissingMedicaidID'] = missingMedicaidID;
    data['SequenceID'] = sequenceID;
    data['ClientCustomID'] = clientCustomID;
    data['ClientOtherID'] = clientOtherID;
    data['ClientTimezone'] = clientTimezone;
    data['Coordinator'] = coordinator;
    data['ProviderAssentContPlan'] = providerAssentContPlan;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
