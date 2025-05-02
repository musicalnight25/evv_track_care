import 'package:healthcare/core/data/models/response/agency_response.dart';

class OfflineGetAgencyList {
  OfflineGetAgencyList({
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

  factory OfflineGetAgencyList.fromJson(Map<String, dynamic> json) => OfflineGetAgencyList(
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

  Map<String, dynamic> toMap() => {
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
    "pivot": pivot, // Ensure `pivot` has its own `toMap()` method.
  };

}