class ClientVisitsResponse {
  final List<Visit> visits;

  ClientVisitsResponse({required this.visits});

  factory ClientVisitsResponse.fromJson(Map<String, dynamic> json) {
    return ClientVisitsResponse(
      visits: List<Visit>.from(json['visits'].map((x) => Visit.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visits': List<dynamic>.from(visits.map((x) => x.toJson())),
    };
  }
}

class Visit {
  final num? id;
  final num? companyId;
  final num? clientId;
  final num? userId;
  final String? status;
  final num? clientPayerId;
  final String? visitOtherID;
  final String? sequenceID;
  final String? employeeQualifier;
  final String? employeeOtherID;
  final String? employeeIdentifier;
  final String? groupCode;
  final String? clientID;
  final num? visitCancelledIndicator;
  final String? payerID;
  final String? payerProgram;
  final String? procedureCode;
  final String? modifier1;
  final String? modifier2;
  final String? modifier3;
  final String? modifier4;
  final String? visitTimeZone;
  final DateTime? scheduleStartTime;
  final DateTime? scheduleEndTime;
  final String? contingencyPlan;
  final num? reschedule;
  final DateTime? adjInDateTime;
  final DateTime? adjOutDateTime;
  final num? billVisit;
  final num? hoursToBill;
  final num? hoursToPay;
  final String? memo;
  final num? clientVerifiedTimes;
  final num? clientVerifiedService;
  final num? clientSignatureAvailable;
  final num? clientVoiceRecording;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? signatureFile;
  final String? audioFile;

  Visit({
    this.id,
    this.companyId,
    this.clientId,
    this.userId,
    this.status,
    this.clientPayerId,
    this.visitOtherID,
    this.sequenceID,
    this.employeeQualifier,
    this.employeeOtherID,
    this.employeeIdentifier,
    this.groupCode,
    this.clientID,
    this.visitCancelledIndicator,
    this.payerID,
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
    this.signatureFile,
    this.audioFile,
  });

  factory Visit.fromJson(Map<String, dynamic> json) {
    return Visit(
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
      scheduleStartTime:json['ScheduleStartTime'] != null ? DateTime.parse(json['ScheduleStartTime']) : DateTime.now(),
      scheduleEndTime: json['ScheduleEndTime'] != null ?DateTime.parse(json['ScheduleEndTime']):DateTime.now(),
      contingencyPlan: json['ContingencyPlan'],
      reschedule: json['Reschedule'],
      adjInDateTime: json['AdjInDateTime'] != null ? DateTime.parse(json['AdjInDateTime']) : null,
      adjOutDateTime: json['AdjOutDateTime'] != null ? DateTime.parse(json['AdjOutDateTime']) : null,
      billVisit: json['BillVisit'],
      hoursToBill: json['HoursToBill'] != null ? json['HoursToBill'] : 0,
      hoursToPay: json['HoursToPay'] != null ? json['HoursToPay'] : 0,
      memo: json['Memo'],
      clientVerifiedTimes: json['ClientVerifiedTimes'],
      clientVerifiedService: json['ClientVerifiedService'],
      clientSignatureAvailable: json['ClientSignatureAvailable'],
      clientVoiceRecording: json['ClientVoiceRecording'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      signatureFile: json['signature_file'] ?? "",
      audioFile: json['audio_file'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'client_id': clientId,
      'user_id': userId,
      'status': status,
      'client_payer_id': clientPayerId,
      'VisitOtherID': visitOtherID,
      'SequenceID': sequenceID,
      'EmployeeQualifier': employeeQualifier,
      'EmployeeOtherID': employeeOtherID,
      'EmployeeIdentifier': employeeIdentifier,
      'GroupCode': groupCode,
      'ClientID': clientID,
      'VisitCancelledIndicator': visitCancelledIndicator,
      'PayerID': payerID,
      'PayerProgram': payerProgram,
      'ProcedureCode': procedureCode,
      'Modifier1': modifier1,
      'Modifier2': modifier2,
      'Modifier3': modifier3,
      'Modifier4': modifier4,
      'VisitTimeZone': visitTimeZone,
      'ScheduleStartTime': scheduleStartTime?.toIso8601String(),
      'ScheduleEndTime': scheduleEndTime?.toIso8601String(),
      'ContingencyPlan': contingencyPlan,
      'Reschedule': reschedule,
      'AdjInDateTime': adjInDateTime?.toIso8601String(),
      'AdjOutDateTime': adjOutDateTime?.toIso8601String(),
      'BillVisit': billVisit,
      'HoursToBill': hoursToBill,
      'HoursToPay': hoursToPay,
      'Memo': memo,
      'ClientVerifiedTimes': clientVerifiedTimes,
      'ClientVerifiedService': clientVerifiedService,
      'ClientSignatureAvailable': clientSignatureAvailable,
      'ClientVoiceRecording': clientVoiceRecording,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'signature_file': signatureFile,
      'audio_file': audioFile,
    };
  }
}
