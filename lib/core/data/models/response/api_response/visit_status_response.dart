class VisitStatusResponse {
  final int? id;
  final int? companyId;
  final int? clientId;
  final int? userId;
  final String? status;
  final int? clientPayerId;
  final String? visitOtherId;
  final String? sequenceId;
  final String? employeeQualifier;
  final String? employeeOtherId;
  final String? employeeIdentifier;
  final String? groupCode;
  final String? clientIdCode;
  final int? visitCancelledIndicator;
  final String? payerId;
  final String? payerProgram;
  final String? procedureCode;
  final String? modifier1;
  final String? modifier2;
  final String? modifier3;
  final String? modifier4;
  final String? visitTimeZone;
  final String? scheduleStartTime;
  final String? scheduleEndTime;
  final String? contingencyPlan;
  final int? reschedule;
  final String? adjInDateTime;
  final String? adjOutDateTime;
  final int? billVisit;
  final int? hoursToBill;
  final int? hoursToPay;
  final String? memo;
  final int? clientVerifiedTimes;
  final int? clientVerifiedService;
  final int? clientSignatureAvailable;
  final int? clientVoiceRecording;
  final String? createdAt;
  final String? updatedAt;
  final String? signatureFile;
  final String? audioFile;

  VisitStatusResponse({
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
    this.clientIdCode,
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
    required this.signatureFile,
    required this.audioFile,
  });

  // Factory constructor to create a Visit instance from JSON
  factory VisitStatusResponse.fromJson(Map<String, dynamic> json) {
    return VisitStatusResponse(
      id: json['id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      userId: json['user_id'],
      status: json['status'],
      clientPayerId: json['client_payer_id'],
      visitOtherId: json['VisitOtherID'],
      sequenceId: json['SequenceID'],
      employeeQualifier: json['EmployeeQualifier'],
      employeeOtherId: json['EmployeeOtherID'],
      employeeIdentifier: json['EmployeeIdentifier'],
      groupCode: json['GroupCode'],
      clientIdCode: json['ClientID'],
      visitCancelledIndicator: json['VisitCancelledIndicator'],
      payerId: json['PayerID'],
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
      signatureFile: json['signature_file'],
      audioFile: json['audio_file'],
    );
  }

  // Method to convert Visit instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'client_id': clientId,
      'user_id': userId,
      'status': status,
      'client_payer_id': clientPayerId,
      'VisitOtherID': visitOtherId,
      'SequenceID': sequenceId,
      'EmployeeQualifier': employeeQualifier,
      'EmployeeOtherID': employeeOtherId,
      'EmployeeIdentifier': employeeIdentifier,
      'GroupCode': groupCode,
      'ClientID': clientIdCode,
      'VisitCancelledIndicator': visitCancelledIndicator,
      'PayerID': payerId,
      'PayerProgram': payerProgram,
      'ProcedureCode': procedureCode,
      'Modifier1': modifier1,
      'Modifier2': modifier2,
      'Modifier3': modifier3,
      'Modifier4': modifier4,
      'VisitTimeZone': visitTimeZone,
      'ScheduleStartTime': scheduleStartTime,
      'ScheduleEndTime': scheduleEndTime,
      'ContingencyPlan': contingencyPlan,
      'Reschedule': reschedule,
      'AdjInDateTime': adjInDateTime,
      'AdjOutDateTime': adjOutDateTime,
      'BillVisit': billVisit,
      'HoursToBill': hoursToBill,
      'HoursToPay': hoursToPay,
      'Memo': memo,
      'ClientVerifiedTimes': clientVerifiedTimes,
      'ClientVerifiedService': clientVerifiedService,
      'ClientSignatureAvailable': clientSignatureAvailable,
      'ClientVoiceRecording': clientVoiceRecording,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'signature_file': signatureFile,
      'audio_file': audioFile,
    };
  }
}
