
class ServiceListReaponse {
  final List<Service>? services;
  final Company? company;

  ServiceListReaponse({
    this.services,
    this.company,
  });

  factory ServiceListReaponse.fromJson(Map<String, dynamic> json) {
    return ServiceListReaponse(
      services: (json['services'] as List)
          .map((item) => Service.fromJson(item))
          .toList(),
      company: Company.fromJson(json['company']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'services': services?.map((e) => e.toJson()).toList(),
      'company': company?.toJson(),
    };
  }
}

class Company {
  num? id;
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
  String? ProviderQualifier;
  String? ProviderID;
  String? created_at;
  String? updated_at;
  String? deleted_at;
  List<Service>? services;

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
     this.ProviderQualifier,
     this.ProviderID,
    this.created_at,
    this.updated_at,
    this.deleted_at,
     this.services,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
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
      ProviderQualifier: json['ProviderQualifier'],
      ProviderID: json['ProviderID'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      deleted_at: json['deleted_at'],
      services: (json['services'] as List)
          .map((item) => Service.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
      'ProviderQualifier': ProviderQualifier,
      'ProviderID': ProviderID,
      'created_at': created_at,
      'updated_at': updated_at,
      'deleted_at': deleted_at,
      'services': services?.map((e) => e.toJson()).toList(),
    };
  }
}

class Service {
  num? id;
  String? name;
  String? code;
  String? about;
  num? company_id;
  String? created_at;
  String? updated_at;
  String? deleted_at;
  Pivot? pivot;

  Service({
    this.id,
    this.name,
    this.code,
    this.about,
    this.company_id,
    this.created_at,
    this.updated_at,
    this.deleted_at,
    this.pivot,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      about: json['about'],
      company_id: json['company_id'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
      deleted_at: json['deleted_at'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'about': about,
      'company_id': company_id,
      'created_at': created_at,
      'updated_at': updated_at,
      'deleted_at': deleted_at,
      'deleted_at': deleted_at,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'about': about,
      'company_id': company_id,
      'created_at': created_at,
      'updated_at': updated_at,
      'deleted_at': deleted_at,
      'pivot': pivot?.toJson(),
    };
  }

}

class Pivot {

  num? company_id;
  num? program_id;


  Pivot({
    this.company_id,
    this.program_id,

  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(

      company_id: json['company_id'],
      program_id: json['program_id'],

    );
  }

  Map<String, dynamic> toJson() {
    return {

      'company_id': company_id,
      'program_id': program_id,

    };
  }

  Map<String, dynamic> toMap() {
    return {
      'company_id': company_id,
      'program_id': program_id,

    };
  }

}