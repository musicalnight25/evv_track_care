import '../client_visits_response.dart';

class ZVisitModel extends Visit {
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
  final String? deletedAt;
  final String? signatureFile;
  final String? audioFile;
  final num? serviceId;
  final String? clientIDQualifier;
  final String? sandata;
  final String? bypassReason;
  final int synced;

  ZVisitModel({
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
    this.deletedAt,
    this.signatureFile,
    this.audioFile,
    this.serviceId,
    this.clientIDQualifier,
    this.sandata,
    this.bypassReason,
    this.synced = 1,
  }) : super(
          companyId: companyId,
          id: id,
          clientId: clientId,
          userId: userId,
          status: status,
          scheduleStartTime: scheduleStartTime,
          scheduleEndTime: scheduleEndTime,
        );

  factory ZVisitModel.fromJson(Map<String, dynamic> json) {
    return ZVisitModel(
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
      scheduleStartTime: json["ScheduleStartTime"] == null ? null : DateTime.tryParse(json["ScheduleStartTime"]),
      scheduleEndTime: json["ScheduleEndTime"] == null ? null : DateTime.tryParse(json["ScheduleEndTime"]),
      contingencyPlan: json['ContingencyPlan'],
      reschedule: json['Reschedule'],
      adjInDateTime: json["AdjInDateTime"] == null ? null : DateTime.tryParse(json["AdjInDateTime"]),
      adjOutDateTime: json["AdjOutDateTime"] == null ? null : DateTime.tryParse(json["AdjOutDateTime"]),
      billVisit: num.tryParse(json['BillVisit']?.toString() ?? "0"),
      hoursToBill: json['HoursToBill'],
      hoursToPay: json['HoursToPay'],
      memo: json['Memo'],
      clientVerifiedTimes: json['ClientVerifiedTimes'],
      clientVerifiedService: json['ClientVerifiedService'],
      clientSignatureAvailable: json['ClientSignatureAvailable'],
      clientVoiceRecording: json['ClientVoiceRecording'],
      createdAt: json["created_at"] == null ? null : DateTime.tryParse(json["created_at"]),
      updatedAt: json["updated_at"] == null ? null : DateTime.tryParse(json["updated_at"]),
      deletedAt: json['deleted_at'],
      signatureFile: json['signature_file'],
      audioFile: json['audio_file'],
      serviceId: json['service_id'],
      clientIDQualifier: json['ClientIDQualifier'],
      sandata: json['sandata'],
      bypassReason: json['BypassReason'],
      synced: json['synced'] ?? 1,
    );
  }

  Map<String, dynamic> toJson([bool sendToSyncApi = false]) {
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
      'ScheduleStartTime': scheduleStartTime.toString(),
      'ScheduleEndTime': scheduleEndTime.toString(),
      'ContingencyPlan': contingencyPlan,
      'Reschedule': reschedule,
      'AdjInDateTime': adjInDateTime.toString(),
      'AdjOutDateTime': adjOutDateTime.toString(),
      'BillVisit': billVisit,
      'HoursToBill': hoursToBill,
      'HoursToPay': hoursToPay,
      'Memo': memo,
      'ClientVerifiedTimes': clientVerifiedTimes,
      'ClientVerifiedService': clientVerifiedService,
      'ClientSignatureAvailable': clientSignatureAvailable,
      'ClientVoiceRecording': clientVoiceRecording,
      'created_at': createdAt?.toString(),
      'updated_at': updatedAt?.toString(),
      'deleted_at': deletedAt,
      'signature_file': signatureFile,
      'audio_file': audioFile,
      'service_id': serviceId,
      'ClientIDQualifier': clientIDQualifier,
      'sandata': sandata,
      'BypassReason': bypassReason,
      if (!sendToSyncApi) "synced": synced,
    };
  }
}
