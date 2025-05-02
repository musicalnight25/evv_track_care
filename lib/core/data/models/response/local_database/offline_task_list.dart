class OfflineTaskList {
  int id;
  String name;
  String? code;
  String? about;
  int serviceId;
  int companyId;
  String? createdAt;
  String? updatedAt;

  OfflineTaskList({
    required this.id,
    required this.name,
    this.code,
    this.about,
    required this.serviceId,
    required this.companyId,
    this.createdAt,
    this.updatedAt,
  });

  // Factory method to create an instance from JSON
  factory OfflineTaskList.fromJson(Map<String, dynamic> json) {
    return OfflineTaskList(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      about: json['about'],
      serviceId: json['serviceId'],
      companyId: json['companyId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'about': about,
      'serviceId': serviceId,
      'companyId': companyId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  // Method to convert the instance to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'about': about,
      'serviceId': serviceId,
      'companyId': companyId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}
