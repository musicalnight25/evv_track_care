class ClientVisitAddResponse {
  final int? id;
  final int? companyId;
  final int? clientId;
  final int? userId;
  final String? status;
  final int clientPayerId;
  final String visitOtherID;
  final String sequenceID;
  final String employeeQualifier;
  final String? employeeOtherID;
  final String? employeeIdentifier;
  final String groupCode;
  final String? clientID;
  final int visitCancelledIndicator;
  final String payerID;
  final String payerProgram;
  final String procedureCode;
  final String? modifier1;
  final String? modifier2;
  final String? modifier3;
  final String? modifier4;
  final String visitTimeZone;
  final String? scheduleStartTime;
  final String? scheduleEndTime;
  final String contingencyPlan;
  final int reschedule;
  final String? adjInDateTime;
  final String? adjOutDateTime;
  final String? billVisit;
  final int hoursToBill;
  final int hoursToPay;
  final String? memo;
  final int clientVerifiedTimes;
  final int clientVerifiedService;
  final int clientSignatureAvailable;
  final int clientVoiceRecording;
  final String createdAt;
  final String updatedAt;

  ClientVisitAddResponse({
    required this.id,
    required this.companyId,
    required this.clientId,
    required this.userId,
    required this.status,
    required this.clientPayerId,
    required this.visitOtherID,
    required this.sequenceID,
    required this.employeeQualifier,
    this.employeeOtherID,
    this.employeeIdentifier,
    required this.groupCode,
    this.clientID,
    required this.visitCancelledIndicator,
    required this.payerID,
    required this.payerProgram,
    required this.procedureCode,
    this.modifier1,
    this.modifier2,
    this.modifier3,
    this.modifier4,
    required this.visitTimeZone,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
    required this.contingencyPlan,
    required this.reschedule,
    required this.adjInDateTime,
    required this.adjOutDateTime,
    this.billVisit,
    required this.hoursToBill,
    required this.hoursToPay,
    this.memo,
    required this.clientVerifiedTimes,
    required this.clientVerifiedService,
    required this.clientSignatureAvailable,
    required this.clientVoiceRecording,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert JSON to VisitRequest
  factory ClientVisitAddResponse.fromJson(Map<String, dynamic> json) {
    return ClientVisitAddResponse(
      id: json['id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      userId: json['user_id'],
      status: json['status'],
      clientPayerId: json['client_payer_id'],
      visitOtherID: json['VisitOtherID'],
      sequenceID: json['SequenceID'],
      employeeQualifier: json['EmployeeQualifier'],
      employeeOtherID: json['EmployeeOtherID'],
      employeeIdentifier: json['EmployeeIdentifier'],
      groupCode: json['GroupCode'],
      clientID: json['ClientID'],
      visitCancelledIndicator: json['VisitCancelledIndicator'],
      payerID: json['PayerID'],
      payerProgram: json['PayerProgram'],
      procedureCode: json['ProcedureCode'],
      modifier1: json['Modifier1'],
      modifier2: json['Modifier2'],
      modifier3: json['Modifier3'],
      modifier4: json['Modifier4'],
      visitTimeZone: json['VisitTimeZone'],
      scheduleStartTime: json['ScheduleStartTime'],
      scheduleEndTime: json['ScheduleEndTime'],
      contingencyPlan: json['ContingencyPlan'],
      reschedule: json['Reschedule'],
      adjInDateTime: json['AdjInDateTime'],
      adjOutDateTime: json['AdjOutDateTime'],
      billVisit: json['BillVisit'],
      hoursToBill: json['HoursToBill'],
      hoursToPay: json['HoursToPay'],
      memo: json['Memo'],
      clientVerifiedTimes: json['ClientVerifiedTimes'],
      clientVerifiedService: json['ClientVerifiedService'],
      clientSignatureAvailable: json['ClientSignatureAvailable'],
      clientVoiceRecording: json['ClientVoiceRecording'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "company_id": companyId,
      "client_id": clientId,
      "user_id": userId,
      "status": status,
      "client_payer_id": clientPayerId,
      "VisitOtherID": visitOtherID,
      "SequenceID": sequenceID,
      "EmployeeQualifier": employeeQualifier,
      "EmployeeOtherID": employeeOtherID,
      "EmployeeIdentifier": employeeIdentifier,
      "GroupCode": groupCode,
      "ClientID": clientID,
      "VisitCancelledIndicator": visitCancelledIndicator,
      "PayerID": payerID,
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
    };
  }
}
