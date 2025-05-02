import 'package:healthcare/core/data/models/response/api_response/service_list_reaponse.dart';

class ZServiceModel extends Service {
  final num? id;
  final String? name;
  final String? programName;
  final String? payerProgram;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final ZServicePivotModel? pivot2;

  ZServiceModel({
    this.id,
    this.name,
    this.programName,
    this.payerProgram,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.pivot2,
  });

  factory ZServiceModel.fromJson(Map<String, dynamic> json) {
    return ZServiceModel(
      id: json['id'],
      name: json['name']?.toString(),
      programName: json['ProgramName']?.toString(),
      payerProgram: json['PayerProgram']?.toString(),
      deletedAt: json['deleted_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
      pivot2: json['pivot'] != null ? ZServicePivotModel.fromJson(json['pivot']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'ProgramName': programName,
      'PayerProgram': payerProgram,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      // 'pivot': pivot?.toJson(),
    };
  }
}

class ZServicePivotModel {
  final num? companyId;
  final num? programId;

  ZServicePivotModel({this.companyId, this.programId});

  factory ZServicePivotModel.fromJson(Map<String, dynamic> json) {
    return ZServicePivotModel(
      companyId: json['company_id'],
      programId: json['program_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId,
      'program_id': programId,
    };
  }
}
