class VisitDataResponse {
  int? id;
  int? companyId;
  int? visitDataResponseClientId;
  int? userId;
  String? status;
  int? clientPayerId;
  String? visitOtherId;
  String? sequenceId;
  EmployeeQualifier? employeeQualifier;
  dynamic employeeOtherId;
  dynamic employeeIdentifier;
  GroupCode? groupCode;
  dynamic clientId;
  int? visitCancelledIndicator;
  String? payerId;
  String? payerProgram;
  String? procedureCode;
  dynamic modifier1;
  dynamic modifier2;
  dynamic modifier3;
  dynamic modifier4;
  VisitTimeZone? visitTimeZone;
  String? scheduleStartTime;
  String? scheduleEndTime;
  ContingencyPlan? contingencyPlan;
  int? reschedule;
  DateTime? adjInDateTime;
  DateTime? adjOutDateTime;
  int? billVisit;
  int? hoursToBill;
  int? hoursToPay;
  dynamic memo;
  int? clientVerifiedTimes;
  int? clientVerifiedService;
  int? clientSignatureAvailable;
  int? clientVoiceRecording;
  DateTime? createdAt;
  DateTime? updatedAt;

  VisitDataResponse({
    this.id,
    this.companyId,
    this.visitDataResponseClientId,
    this.userId,
    this.status,
    this.clientPayerId,
    this.visitOtherId,
    this.sequenceId,
    this.employeeQualifier,
    this.employeeOtherId,
    this.employeeIdentifier,
    this.groupCode,
    this.clientId,
    this.visitCancelledIndicator,
    this.payerId,
    this.payerProgram,
    this.procedureCode,
    this.modifier1,
    this.modifier2,
    this.modifier3,
    this.modifier4,
    this.visitTimeZone,
    this.scheduleStartTime,
    this.scheduleEndTime,
    this.contingencyPlan,
    this.reschedule,
    this.adjInDateTime,
    this.adjOutDateTime,
    this.billVisit,
    this.hoursToBill,
    this.hoursToPay,
    this.memo,
    this.clientVerifiedTimes,
    this.clientVerifiedService,
    this.clientSignatureAvailable,
    this.clientVoiceRecording,
    this.createdAt,
    this.updatedAt,
  });

  factory VisitDataResponse.fromJson(Map<String, dynamic> json) {
    return VisitDataResponse(
      id: json['id'],
      companyId: json['companyId'] ,
      visitDataResponseClientId: json['visitDataResponseClientId'] ,
      userId: json['userId'] ,
      status: json['status'] ,
      clientPayerId: json['clientPayerId'] ,
      visitOtherId: json['visitOtherId'] as String?,
      sequenceId: json['sequenceId'] as String?,
      employeeQualifier: json['employeeQualifier'] ,
      employeeOtherId: json['employeeOtherId'] as String?,
      employeeIdentifier: json['employeeIdentifier'] as String?,
      groupCode: json['groupCode'] ,
      clientId: json['clientId'] as String?,
      visitCancelledIndicator: json['visitCancelledIndicator'] ,
      payerId: json['payerId'] as String?,
      payerProgram: json['payerProgram'] as String?,
      procedureCode: json['procedureCode'] as String?,
      modifier1: json['modifier1'] as String?,
      modifier2: json['modifier2'] as String?,
      modifier3: json['modifier3'] as String?,
      modifier4: json['modifier4'] as String?,
      visitTimeZone: json['visitTimeZone'] ,
      scheduleStartTime: json['scheduleStartTime'] ,
      scheduleEndTime: json['scheduleEndTime'] ,
      contingencyPlan: json['contingencyPlan'] ,
      reschedule: json['reschedule'] ,
      adjInDateTime: json['adjInDateTime'] ,
      adjOutDateTime: json['adjOutDateTime'],
      billVisit: json['billVisit'] ,
      hoursToBill: json['hoursToBill'] ,
      hoursToPay: json['hoursToPay'],
      memo: json['memo'] ,
      clientVerifiedTimes: json['clientVerifiedTimes'] ,
      clientVerifiedService: json['clientVerifiedService'] ,
      clientSignatureAvailable: json['clientSignatureAvailable'] ,
      clientVoiceRecording: json['clientVoiceRecording'] ,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
    );
  }

}

enum ContingencyPlan {
  NONE
}

enum EmployeeQualifier {
  EMPLOYEE_CUSTOM_ID
}

enum GroupCode {
  CLIENT_MEDICAID_ID
}

enum Status {
  PENDING
}

enum VisitTimeZone {
  US_EASTERN
}
