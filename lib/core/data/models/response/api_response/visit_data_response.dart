import 'dart:convert';

import '../../requests/visits_reqs/clients_list_response.dart';
import '../client_visits_response.dart';

// Top-level function to parse JSON numo VisitData object
VisitDataListResponse visitDataFromJson(String str) => VisitDataListResponse.fromJson(json.decode(str));
String visitDataToJson(VisitDataListResponse data) => json.encode(data.toJson());

// Main data model for VisitData
class VisitDataListResponse {
  Visit? visit;
  Company? company;
  Employee? employee;
  List<Task>? tasks;
  Service? services;

  VisitDataListResponse({
   this.visit,
   this.company,
   this.employee,
   this.tasks,
   this.services,
  });

  factory VisitDataListResponse.fromJson(Map<String, dynamic> json) => VisitDataListResponse(
    visit: Visit.fromJson(json["visit"]),
    company: Company.fromJson(json["company"]),
    employee: Employee.fromJson(json["employee"]),
    services: json["services"] == null ? null:Service.fromJson(json["services"]),
    tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "visit": visit?.toJson(),
    "company": company?.toJson(),
    "employee": employee?.toJson(),
    "services": services?.toJson(),
    "tasks": List<dynamic>.from(tasks!.map((x) => x.toJson())),
  };
}

// Model for Visit object
// class Visit {
//   final num? id;
//   final num? companyId;
//   final num? clientId;
//   final num? userId;
//   final String? status;
//   final num? clientPayerId;
//   final String? visitOtherId;
//   final String? sequenceId;
//   final String? employeeQualifier;
//   final dynamic employeeOtherId;
//   final dynamic employeeIdentifier;
//   final String? groupCode;
//   final dynamic clientIdAlt;
//   final dynamic visitCancelledIndicator;
//   final String? payerId;
//   final String? payerProgram;
//   final String? procedureCode;
//   final dynamic modifier1;
//   final dynamic modifier2;
//   final dynamic modifier3;
//   final dynamic modifier4;
//   final String? visitTimeZone;
//   final String? scheduleStartTime;
//   final String? scheduleEndTime;
//   final String? contingencyPlan;
//   final dynamic reschedule;
//   final String? adjInDateTime;
//   final String? adjOutDateTime;
//   final dynamic billVisit;
//   final num? hoursToBill;
//   final num? hoursToPay;
//   final dynamic memo;
//   final dynamic clientVerifiedTimes;
//   final dynamic clientVerifiedService;
//   final dynamic clientSignatureAvailable;
//   final dynamic clientVoiceRecording;
//   final String? createdAt;
//   final String? updatedAt;
//   final dynamic signatureFile;
//   final dynamic audioFile;
//   final Company? company;
//   final Employee? employee;
//   List<Task>? tasks;
//
//   Visit({
//     this.id,
//     this.companyId,
//     this.clientId,
//     this.userId,
//     this.status,
//     this.clientPayerId,
//     this.visitOtherId,
//     this.sequenceId,
//     this.employeeQualifier,
//     this.employeeOtherId,
//     this.employeeIdentifier,
//     this.groupCode,
//     this.clientIdAlt,
//     this.visitCancelledIndicator,
//     this.payerId,
//     this.payerProgram,
//     this.procedureCode,
//     this.modifier1,
//     this.modifier2,
//     this.modifier3,
//     this.modifier4,
//     this.visitTimeZone,
//     this.scheduleStartTime,
//     this.scheduleEndTime,
//     this.contingencyPlan,
//     this.reschedule,
//     this.adjInDateTime,
//     this.adjOutDateTime,
//     this.billVisit,
//     this.hoursToBill,
//     this.hoursToPay,
//     this.memo,
//     this.clientVerifiedTimes,
//     this.clientVerifiedService,
//     this.clientSignatureAvailable,
//     this.clientVoiceRecording,
//     this.createdAt,
//     this.updatedAt,
//     this.signatureFile,
//     this.audioFile,
//     this.company,
//     this.employee,
//     this.tasks,
//   });
//
//   factory Visit.fromJson(Map<String, dynamic> json) => Visit(
//     id: json["id"],
//     companyId: json["company_id"],
//     clientId: json["client_id"],
//     userId: json["user_id"],
//     status: json["status"],
//     clientPayerId: json["client_payer_id"],
//     visitOtherId: json["VisitOtherID"],
//     sequenceId: json["SequenceID"],
//     employeeQualifier: json["EmployeeQualifier"],
//     employeeOtherId: json["EmployeeOtherID"],
//     employeeIdentifier: json["EmployeeIdentifier"],
//     groupCode: json["GroupCode"],
//     clientIdAlt: json["ClientID"],
//     visitCancelledIndicator: json["VisitCancelledIndicator"],
//     payerId: json["PayerID"],
//     payerProgram: json["PayerProgram"],
//     procedureCode: json["ProcedureCode"],
//     modifier1: json["Modifier1"],
//     modifier2: json["Modifier2"],
//     modifier3: json["Modifier3"],
//     modifier4: json["Modifier4"],
//     visitTimeZone: json["VisitTimeZone"],
//     scheduleStartTime: json["ScheduleStartTime"],
//     scheduleEndTime: json["ScheduleEndTime"],
//     contingencyPlan: json["ContingencyPlan"],
//     reschedule: json["Reschedule"],
//     adjInDateTime: json["AdjInDateTime"],
//     adjOutDateTime: json["AdjOutDateTime"],
//     billVisit: json["BillVisit"],
//     hoursToBill: json["HoursToBill"],
//     hoursToPay: json["HoursToPay"],
//     memo: json["Memo"],
//     clientVerifiedTimes: json["ClientVerifiedTimes"],
//     clientVerifiedService: json["ClientVerifiedService"],
//     clientSignatureAvailable: json["ClientSignatureAvailable"],
//     clientVoiceRecording: json["ClientVoiceRecording"],
//     createdAt: json["created_at"],
//     updatedAt: json["updated_at"],
//     signatureFile: json["signature_file"],
//     audioFile: json["audio_file"],
//     company: Company.fromJson(json["company"]),
//     employee: Employee.fromJson(json["employee"]),
//     tasks: List<Task>.from(json["tasks"].map((x) => Task.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "company_id": companyId,
//     "client_id": clientId,
//     "user_id": userId,
//     "status": status,
//     "client_payer_id": clientPayerId,
//     "VisitOtherID": visitOtherId,
//     "SequenceID": sequenceId,
//     "EmployeeQualifier": employeeQualifier,
//     "EmployeeOtherID": employeeOtherId,
//     "EmployeeIdentifier": employeeIdentifier,
//     "GroupCode": groupCode,
//     "ClientID": clientIdAlt,
//     "VisitCancelledIndicator": visitCancelledIndicator,
//     "PayerID": payerId,
//     "PayerProgram": payerProgram,
//     "ProcedureCode": procedureCode,
//     "Modifier1": modifier1,
//     "Modifier2": modifier2,
//     "Modifier3": modifier3,
//     "Modifier4": modifier4,
//     "VisitTimeZone": visitTimeZone,
//     "ScheduleStartTime": scheduleStartTime,
//     "ScheduleEndTime": scheduleEndTime,
//     "ContingencyPlan": contingencyPlan,
//     "Reschedule": reschedule,
//     "AdjInDateTime": adjInDateTime,
//     "AdjOutDateTime": adjOutDateTime,
//     "BillVisit": billVisit,
//     "HoursToBill": hoursToBill,
//     "HoursToPay": hoursToPay,
//     "Memo": memo,
//     "ClientVerifiedTimes": clientVerifiedTimes,
//     "ClientVerifiedService": clientVerifiedService,
//     "ClientSignatureAvailable": clientSignatureAvailable,
//     "ClientVoiceRecording": clientVoiceRecording,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "signature_file": signatureFile,
//     "audio_file": audioFile,
//     "company": company?.toJson(),
//     "employee": employee?.toJson(),
//     "tasks": List<dynamic>.from(tasks?.map((x) => x.toJson())),
//   };
// }

class Service {
  num? id;
  String? name;
  String? code;
  String? about;
  num? companyId;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Service({
    this.id,
    this.name,
    this.code,
    this.about,
    this.companyId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      id: json['id'],
      name: json['name'],
      code: json['code'],
      about: json['about'],
      companyId: json['company_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'code': code,
      'about': about,
      'company_id': companyId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
    };
  }
}

// Model for Company
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
  String? providerQualifier;
  String? providerId;
  String? createdAt;
  String? updatedAt;

  Company({
    required this.id,
    required this.name,
    required this.email,
    required this.telephone,
    this.addressLineOne,
    this.addressLineTwo,
    required this.county,
    required this.city,
    required this.state,
    required this.zip,
    this.website,
    this.logo,
    this.about,
    required this.providerQualifier,
    required this.providerId,
    required this.createdAt,
    required this.updatedAt,
  });

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
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
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
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

// Model for Employee
class Employee {
  num? id;
  String? firstName;
  String? lastName;
  String? email;
  String? telephone;
  String? createdAt;
  String? updatedAt;

  Employee({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.telephone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    telephone: json["telephone"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "telephone": telephone,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

// Model for Task


class Task {
  final num? id;
  final num? companyId;
  final num? clientId;
  final num? userId;
  final num? visitId;
  final String? taskId;
  final String? taskReading;
  final num? taskRefused;
  final DateTime? createdAt;
  final String? updatedAt;

  Task({
    required this.id,
    required this.companyId,
    required this.clientId,
    required this.userId,
    required this.visitId,
    required this.taskId,
    required this.taskReading,
    required this.taskRefused,
    this.createdAt,
    required this.updatedAt,
  });

  // From JSON method
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      userId: json['user_id'],
      visitId: json['visit_id'],
      taskId: json['TaskID'],
      taskReading: json['TaskReading'],
      taskRefused: json['TaskRefused'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at'])?.toLocal() : null,
      updatedAt: json['updated_at'],
    );
  }

  // To JSON method (optional, if you need to send this object as JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'client_id': clientId,
      'user_id': userId,
      'visit_id': visitId,
      'TaskID': taskId,
      'TaskReading': taskReading,
      'TaskRefused': taskRefused,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}


/*class Task {
  num id;
  num visitId;
  String taskDescription;
  bool completed;
  String createdAt;
  String updatedAt;

  Task({
    required this.id,
    required this.visitId,
    required this.taskDescription,
    required this.completed,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json["id"],
    visitId: json["visit_id"],
    taskDescription: json["task_description"],
    completed: json["completed"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "visit_id": visitId,
    "task_description": taskDescription,
    "completed": completed,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}*/
