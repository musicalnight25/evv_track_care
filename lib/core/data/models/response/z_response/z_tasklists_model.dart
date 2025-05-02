class ZTaskListModel {
  final num? id;
  final String? name;
  final String? code;
  final String? about;
  final num? serviceId;
  final num? companyId;
  final num? programId;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;

  ZTaskListModel({
    this.id,
    this.name,
    this.code,
    this.about,
    this.serviceId,
    this.companyId,
    this.programId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ZTaskListModel.fromJson(Map<String, dynamic> json) {
    return ZTaskListModel(
      id: json['id'],
      name: json['name']?.toString(),
      code: json['code']?.toString(),
      about: json['about']?.toString(),
      serviceId: json['service_id'],
      companyId: json['company_id'],
      programId: json['program_id'],
      deletedAt: json['deleted_at']?.toString(),
      createdAt: json['created_at']?.toString(),
      updatedAt: json['updated_at']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'about': about,
      'service_id': serviceId,
      'company_id': companyId,
      'program_id': programId,
      'deleted_at': deletedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
