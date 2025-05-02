import 'dart:convert';

// Function to parse JSON to Visit object
SendSignatureResponse visitFromJson(String str) => SendSignatureResponse.fromJson(json.decode(str));
String visitToJson(SendSignatureResponse data) => json.encode(data.toJson());

class SendSignatureResponse {
  int? id;
  int? companyId;
  int? clientId;
  int? userId;
  String? status;
  int? clientPayerId;
  String? visitOtherId;
  String? sequenceId;
  String? employeeQualifier;
  String? employeeOtherId;
  String? employeeIdentifier;
  String? groupCode;
  String? clientIdAlt;
  int? visitCancelledIndicator;
  String? payerId;
  String? payerProgram;
  String? procedureCode;
  String? modifier1;
  String? modifier2;
  String? modifier3;
  String? modifier4;
  String? visitTimeZone;
  String? scheduleStartTime;
  String? scheduleEndTime;
  String? contingencyPlan;
  int? reschedule;
  String? adjInDateTime;
  String? adjOutDateTime;
  int? billVisit;
  int? hoursToBill;
  int? hoursToPay;
  String? memo;
  int? clientVerifiedTimes;
  int? clientVerifiedService;
  int? clientSignatureAvailable;
  int? clientVoiceRecording;
  String? createdAt;
  String? updatedAt;
  String? signatureFile;
  String? audioFile;

  SendSignatureResponse({
    required this.id,
    required this.companyId,
    required this.clientId,
    required this.userId,
    required this.status,
    required this.clientPayerId,
    this.visitOtherId,
    required this.sequenceId,
    required this.employeeQualifier,
    this.employeeOtherId,
    this.employeeIdentifier,
    required this.groupCode,
    this.clientIdAlt,
    required this.visitCancelledIndicator,
    required this.payerId,
    this.payerProgram,
    this.procedureCode,
    this.modifier1,
    this.modifier2,
    this.modifier3,
    this.modifier4,
    required this.visitTimeZone,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
    this.contingencyPlan,
    required this.reschedule,
    this.adjInDateTime,
    this.adjOutDateTime,
    required this.billVisit,
    this.hoursToBill,
    this.hoursToPay,
    this.memo,
    required this.clientVerifiedTimes,
    required this.clientVerifiedService,
    required this.clientSignatureAvailable,
    required this.clientVoiceRecording,
    required this.createdAt,
    required this.updatedAt,
    this.signatureFile,
    this.audioFile,
  });

  factory SendSignatureResponse.fromJson(Map<String, dynamic> json) => SendSignatureResponse(
    id: json["id"],
    companyId: json["company_id"],
    clientId: json["client_id"],
    userId: json["user_id"],
    status: json["status"],
    clientPayerId: json["client_payer_id"],
    visitOtherId: json["VisitOtherID"],
    sequenceId: json["SequenceID"],
    employeeQualifier: json["EmployeeQualifier"],
    employeeOtherId: json["EmployeeOtherID"],
    employeeIdentifier: json["EmployeeIdentifier"],
    groupCode: json["GroupCode"],
    clientIdAlt: json["ClientID"],
    visitCancelledIndicator: json["VisitCancelledIndicator"],
    payerId: json["PayerID"],
    payerProgram: json["PayerProgram"],
    procedureCode: json["ProcedureCode"],
    modifier1: json["Modifier1"],
    modifier2: json["Modifier2"],
    modifier3: json["Modifier3"],
    modifier4: json["Modifier4"],
    visitTimeZone: json["VisitTimeZone"],
    scheduleStartTime: json["ScheduleStartTime"],
    scheduleEndTime: json["ScheduleEndTime"],
    contingencyPlan: json["ContingencyPlan"],
    reschedule: json["Reschedule"],
    adjInDateTime: json["AdjInDateTime"],
    adjOutDateTime: json["AdjOutDateTime"],
    billVisit: json["BillVisit"],
    hoursToBill: json["HoursToBill"],
    hoursToPay: json["HoursToPay"],
    memo: json["Memo"],
    clientVerifiedTimes: json["ClientVerifiedTimes"],
    clientVerifiedService: json["ClientVerifiedService"],
    clientSignatureAvailable: json["ClientSignatureAvailable"],
    clientVoiceRecording: json["ClientVoiceRecording"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    signatureFile: json["signature_file"],
    audioFile: json["audio_file"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "client_id": clientId,
    "user_id": userId,
    "status": status,
    "client_payer_id": clientPayerId,
    "VisitOtherID": visitOtherId,
    "SequenceID": sequenceId,
    "EmployeeQualifier": employeeQualifier,
    "EmployeeOtherID": employeeOtherId,
    "EmployeeIdentifier": employeeIdentifier,
    "GroupCode": groupCode,
    "ClientID": clientIdAlt,
    "VisitCancelledIndicator": visitCancelledIndicator,
    "PayerID": payerId,
    "PayerProgram": payerProgram,
    "ProcedureCode": procedureCode,
    "Modifier1": modifier1,
    "Modifier2": modifier2,
    "Modifier3": modifier3,
    "Modifier4": modifier4,
    "VisitTimeZone": visitTimeZone,
    "ScheduleStartTime": scheduleStartTime,
    "ScheduleEndTime": scheduleEndTime,
    "ContingencyPlan": contingencyPlan,
    "Reschedule": reschedule,
    "AdjInDateTime": adjInDateTime,
    "AdjOutDateTime": adjOutDateTime,
    "BillVisit": billVisit,
    "HoursToBill": hoursToBill,
    "HoursToPay": hoursToPay,
    "Memo": memo,
    "ClientVerifiedTimes": clientVerifiedTimes,
    "ClientVerifiedService": clientVerifiedService,
    "ClientSignatureAvailable": clientSignatureAvailable,
    "ClientVoiceRecording": clientVoiceRecording,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "signature_file": signatureFile,
    "audio_file": audioFile,
  };
}
