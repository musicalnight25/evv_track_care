import 'package:healthcare/core/data/models/response/z_response/z_client_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_service_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_tasklists_model.dart';

class ZCompanyModel {
  final num? id;
  final String? name;
  final String? slug;
  final String? email;
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
  final String? providerQualifier;
  final String? providerId;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;
  List<ZServiceModel>? services;
  List<ZTaskListModel>? taskLists;
  List<ZClientModel>? clients;

  ZCompanyModel({
    this.id,
    this.name,
    this.slug,
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
    this.deletedAt,
    this.services,
    this.taskLists,
    this.clients,
  });

  ZCompanyModel copyWith({
    num? id,
    String? name,
    String? slug,
    String? email,
    String? telephone,
    String? addressLineOne,
    String? addressLineTwo,
    String? county,
    String? city,
    String? state,
    String? zip,
    String? website,
    String? logo,
    String? about,
    String? providerQualifier,
    String? providerId,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    List<ZServiceModel>? services,
    List<ZTaskListModel>? taskLists,
    List<ZClientModel>? clients,
  }) {
    return ZCompanyModel(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      email: email ?? this.email,
      telephone: telephone ?? this.telephone,
      addressLineOne: addressLineOne ?? this.addressLineOne,
      addressLineTwo: addressLineTwo ?? this.addressLineTwo,
      county: county ?? this.county,
      city: city ?? this.city,
      state: state ?? this.state,
      zip: zip ?? this.zip,
      website: website ?? this.website,
      logo: logo ?? this.logo,
      about: about ?? this.about,
      providerQualifier: providerQualifier ?? this.providerQualifier,
      providerId: providerId ?? this.providerId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      services: services ?? this.services,
      taskLists: taskLists ?? this.taskLists,
      clients: clients ?? this.clients,
    );
  }

  factory ZCompanyModel.fromJson(Map<String, dynamic> json) {
    return ZCompanyModel(
      id: json['id'],
      name: json['name']?.toString(),
      slug: json['slug']?.toString(),
      email: json['email']?.toString(),
      telephone: json['telephone']?.toString(),
      addressLineOne: json['address_line_one']?.toString(),
      addressLineTwo: json['address_line_two']?.toString(),
      county: json['county']?.toString(),
      city: json['city']?.toString(),
      state: json['state']?.toString(),
      zip: json['zip']?.toString(),
      website: json['website']?.toString(),
      logo: json['logo']?.toString(),
      about: json['about']?.toString(),
      providerQualifier: json['provider_qualifier']?.toString(),
      providerId: json['provider_id']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
      services: (json['services'] as List?)?.map((e) => ZServiceModel.fromJson(e)).toList(),
      taskLists: (json['task_lists'] as List?)?.map((e) => ZTaskListModel.fromJson(e)).toList(),
      clients: (json['clients'] as List?)?.map((e) => ZClientModel.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'email': email,
      'telephone': telephone,
      'address_line_one': addressLineOne,
      'address_line_two': addressLineTwo,
      'county': county,
      'city': city,
      'state': state,
      'zip': zip,
      'website': website,
      'logo': logo,
      'about': about,
      'provider_qualifier': providerQualifier,
      'provider_id': providerId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      // 'services': services?.map((e) => e.toJson()).toList(),
      // 'task_lists': taskLists?.map((e) => e.toJson()).toList(),
      // 'clients': clients?.map((e) => e.toJson()).toList(),
    };
  }
}
