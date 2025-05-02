import 'dart:convert';

EmployeeResponse employeeResponseFromJson(String str) =>
    EmployeeResponse.fromJson(json.decode(str));

String employeeResponseToJson(EmployeeResponse data) =>
    json.encode(data.toJson());

class EmployeeResponse {
  EmployeeResponse({
    required this.employee,
    required this.companies,
  });

  final Employee employee;
  final List<Company> companies;

  factory EmployeeResponse.fromJson(Map<String, dynamic> json) =>
      EmployeeResponse(
        employee: Employee.fromJson(json["employee"]),
        companies: List<Company>.from(
            json["companies"].map((x) => Company.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "employee": employee.toJson(),
    "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
  };
}

class Employee {
  Employee({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.avatar,
    required this.companyId,
    required this.type,
    required this.employeeQualifier,
    this.employeeIdentifier,
    this.employeeOtherId,
    this.sequenceId,
    this.employeeLastName,
    this.employeeFirstName,
    this.employeeEmail,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.temp,
    this.currentCompanyId,
    required this.companies,
  });

  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? avatar;
  final int companyId;
  final String type;
  final String employeeQualifier;
  final String? employeeIdentifier;
  final String? employeeOtherId;
  final String? sequenceId;
  final String? employeeLastName;
  final String? employeeFirstName;
  final String? employeeEmail;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? deletedAt;
  final String? temp;
  final int? currentCompanyId;
  final List<Company> companies;

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    emailVerifiedAt: json["email_verified_at"],
    avatar: json["avatar"],
    companyId: json["company_id"],
    type: json["type"],
    employeeQualifier: json["EmployeeQualifier"],
    employeeIdentifier: json["EmployeeIdentifier"],
    employeeOtherId: json["EmployeeOtherID"],
    sequenceId: json["SequenceID"],
    employeeLastName: json["EmployeeLastName"],
    employeeFirstName: json["EmployeeFirstName"],
    employeeEmail: json["EmployeeEmail"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    temp: json["temp"],
    currentCompanyId: json["current_company_id"],
    companies: List<Company>.from(
        json["companies"].map((x) => Company.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "email_verified_at": emailVerifiedAt,
    "avatar": avatar,
    "company_id": companyId,
    "type": type,
    "EmployeeQualifier": employeeQualifier,
    "EmployeeIdentifier": employeeIdentifier,
    "EmployeeOtherID": employeeOtherId,
    "SequenceID": sequenceId,
    "EmployeeLastName": employeeLastName,
    "EmployeeFirstName": employeeFirstName,
    "EmployeeEmail": employeeEmail,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "deleted_at": deletedAt,
    "temp": temp,
    "current_company_id": currentCompanyId,
    "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
  };
}

class Company {
  Company({
    required this.id,
    required this.name,
    required this.email,
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
    required this.providerQualifier,
    required this.providerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.pivot,
  });

  final int id;
  final String name;
  final String email;
  final String? telephone;
  final String? addressLineOne;
  final String? addressLineTwo;
  final String? county;
  final String? city;
  final String? state;
  final String? zip;
  final String? website;
  final String? logo;
  final String? about;
  final String providerQualifier;
  final String providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final Pivot pivot;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
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
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    pivot: Pivot.fromJson(json["pivot"]),
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
    "deleted_at": deletedAt,
    "pivot": pivot.toJson(),
  };
}

class Pivot {
  Pivot({
    required this.userId,
    required this.companyId,
  });

  final int userId;
  final int companyId;

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    userId: json["user_id"],
    companyId: json["company_id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "company_id": companyId,
  };
}
