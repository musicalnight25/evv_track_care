class TaskListsResponse {
  List<TaskList> taskLists;
  Company company;
  Client? client;

  TaskListsResponse({required this.taskLists, required this.company, required this.client});

  factory TaskListsResponse.fromJson(Map<String, dynamic> json) {
    return TaskListsResponse(
      taskLists: (json['services'] as List?)?.map((i) => TaskList.fromJson(i)).toList() ?? [],
      company: Company.fromJson(json['company']),
      client: Client.fromJson(json['client']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'taskLists': taskLists.map((e) => e.toJson()).toList(),
      'company': company.toJson(),
      'client': client?.toJson(),
    };
  }
}

// class TaskList {
//   int? id;
//   String? name;
//   String? code;
//   String? about;
//   int? serviceId;
//   int? companyId;
//   String? createdAt;
//   String? updatedAt;
//
//   TaskList({
//      this.id,
//     this.name,
//     this.code,
//     this.about,
//      this.serviceId,
//      this.companyId,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   factory TaskList.fromJson(Map<String, dynamic> json) {
//     return TaskList(
//       id: json['id'],
//       name: json['name'],
//       code: json['code'],
//       about: json['about'],
//       serviceId: json['service_id'],
//       companyId: json['company_id'],
//       createdAt: json['created_at'],
//       updatedAt: json['updated_at'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'code': code,
//       'about': about,
//       'service_id': serviceId,
//       'company_id': companyId,
//       'created_at': createdAt,
//       'updated_at': updatedAt,
//     };
//   }
// }

class TaskList {
  int? companyId;
  int? clientId;
  String? payerId;
  int? serviceId;
  String? taskName;
  String? taskCode;

  TaskList({
     this.companyId,
     this.clientId,
     this.payerId,
     this.serviceId,
     this.taskName,
     this.taskCode,
  });

  factory TaskList.fromJson(Map<String, dynamic> json) {
    return TaskList(
      companyId: json['company_id'],
      clientId: json['client_id'],
      payerId: json['PayerID'],
      serviceId: json['service_id'],
      taskName: json['task_name'],
      taskCode: json['task_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'company_id': companyId,
      'client_id': clientId,
      'PayerID': payerId,
      'service_id': serviceId,
      'task_name': taskName,
      'task_code': taskCode,
    };
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
 // List<TaskList>? taskLists;

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
  //  this.taskLists,
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
      providerQualifier: json['ProviderQualifier'],
      providerID: json['ProviderID'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
//taskLists: (json['task_lists'] as List).map((i) => TaskList.fromJson(i)).toList(),
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
      'ProviderQualifier': providerQualifier,
      'ProviderID': providerID,
      'created_at': createdAt,
      'updated_at': updatedAt,
    //  'task_lists': taskLists?.map((e) => e.toJson()).toList(),
    };
  }
}

class Client {
  int? id;
  int? companyId;
  int? userId;
  String? clientId;
  String? clientFirstName;
  String? clientMiddleInitial;
  String? clientLastName;
  String? clientQualifier;
  String? clientMedicaidId;
  String? clientIdentifier;
  int? missingMedicaidId;
  String? sequenceId;
  String? clientCustomId;
  String? clientOtherId;
  String? clientTimezone;
  String? coordinator;
  int? providerAssentContPlan;
  String? avatar;
  String? sandata;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  DateTime? clientBirthDate;

  Client({
    this.id,
    this.companyId,
    this.userId,
    this.clientId,
    this.clientFirstName,
    this.clientMiddleInitial,
    this.clientLastName,
    this.clientQualifier,
    this.clientMedicaidId,
    this.clientIdentifier,
    this.missingMedicaidId,
    this.sequenceId,
    this.clientCustomId,
    this.clientOtherId,
    this.clientTimezone,
    this.coordinator,
    this.providerAssentContPlan,
    this.avatar,
    this.sandata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.clientBirthDate,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      companyId: json['company_id'],
      userId: json['user_id'],
      clientId: json['ClientID'],
      clientFirstName: json['ClientFirstName'],
      clientMiddleInitial: json['ClientMiddleInitial'],
      clientLastName: json['ClientLastName'],
      clientQualifier: json['ClientQualifier'],
      clientMedicaidId: json['ClientMedicaidID'],
      clientIdentifier: json['ClientIdentifier'],
      missingMedicaidId: json['MissingMedicaidID'],
      sequenceId: json['SequenceID'],
      clientCustomId: json['ClientCustomID'],
      clientOtherId: json['ClientOtherID'],
      clientTimezone: json['ClientTimezone'],
      coordinator: json['Coordinator'],
      providerAssentContPlan: json['ProviderAssentContPlan'],
      avatar: json['avatar'],
      sandata: json['sandata'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      deletedAt: json['deleted_at'] != null
          ? DateTime.parse(json['deleted_at'])
          : null,
      clientBirthDate: DateTime.parse(json['ClientBirthDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'user_id': userId,
      'ClientID': clientId,
      'ClientFirstName': clientFirstName,
      'ClientMiddleInitial': clientMiddleInitial,
      'ClientLastName': clientLastName,
      'ClientQualifier': clientQualifier,
      'ClientMedicaidID': clientMedicaidId,
      'ClientIdentifier': clientIdentifier,
      'MissingMedicaidID': missingMedicaidId,
      'SequenceID': sequenceId,
      'ClientCustomID': clientCustomId,
      'ClientOtherID': clientOtherId,
      'ClientTimezone': clientTimezone,
      'Coordinator': coordinator,
      'ProviderAssentContPlan': providerAssentContPlan,
      'avatar': avatar,
      'sandata': sandata,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'deleted_at': deletedAt?.toIso8601String(),
      'ClientBirthDate': clientBirthDate?.toIso8601String(),
    };
  }
}
