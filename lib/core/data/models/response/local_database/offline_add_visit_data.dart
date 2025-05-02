class OfflineVisitData {
  final num clientId;
  final num employeeId;
  final num payerId;
  final num companyId;
  final String visitOtherID;
  final String sequenceID;
  final String visitTimeZone;
  final String scheduleStartTime;
  final String scheduleEndTime;
  final String contingencyPlan;
  final num reschedule;
  final String adjInDateTime;
  final String adjOutDateTime;
  final String hoursToBill;
  final String hoursToPay;
  final num visitCancelledIndicator;
  final num clientVerifiedTimes;
  final num clientVerifiedService;
  final num clientSignatureAvailable;
  final num clientVoiceRecording;
  final num? serviceId;

  OfflineVisitData({
    required this.clientId,
    required this.employeeId,
    required this.payerId,
    required this.companyId,
    required this.visitOtherID,
    required this.sequenceID,
    required this.visitTimeZone,
    required this.scheduleStartTime,
    required this.scheduleEndTime,
    required this.contingencyPlan,
    required this.reschedule,
    required this.adjInDateTime,
    required this.adjOutDateTime,
    required this.hoursToBill,
    required this.hoursToPay,
    required this.visitCancelledIndicator,
    required this.clientVerifiedTimes,
    required this.clientVerifiedService,
    required this.clientSignatureAvailable,
    required this.clientVoiceRecording,
    required this.serviceId,
  });

  // Convert JSON to VisitData
  factory OfflineVisitData.fromJson(Map<String, dynamic> json) => OfflineVisitData(
    clientId: json['clientId'],
    employeeId: json['employeeId'],
    payerId: json['payerId'],
    companyId: json['companyId'],
    visitOtherID: json['visitOtherID'],
    sequenceID: json['sequenceID'],
    visitTimeZone: json['visitTimeZone'],
    scheduleStartTime: json['scheduleStartTime'],
    scheduleEndTime: json['scheduleEndTime'],
    contingencyPlan: json['contingencyPlan'],
    reschedule: json['reschedule'],
    adjInDateTime: json['adjInDateTime'],
    adjOutDateTime: json['adjOutDateTime'],
    hoursToBill: json['hoursToBill'],
    hoursToPay: json['hoursToPay'],
    visitCancelledIndicator: json['visitCancelledIndicator'],
    clientVerifiedTimes: json['clientVerifiedTimes'],
    clientVerifiedService: json['clientVerifiedService'],
    clientSignatureAvailable: json['clientSignatureAvailable'],
    clientVoiceRecording: json['clientVoiceRecording'],
    serviceId: json['service_id'],
  );

  // Convert VisitData to Map for SQLite
  Map<String, dynamic> toMap() => {
    'clientId': clientId,
    'employeeId': employeeId,
    'payerId': payerId,
    'companyId': companyId,
    'visitOtherID': visitOtherID,
    'sequenceID': sequenceID,
    'visitTimeZone': visitTimeZone,
    'scheduleStartTime': scheduleStartTime,
    'scheduleEndTime': scheduleEndTime,
    'contingencyPlan': contingencyPlan,
    'reschedule': reschedule,
    'adjInDateTime': adjInDateTime,
    'adjOutDateTime': adjOutDateTime,
    'hoursToBill': hoursToBill,
    'hoursToPay': hoursToPay,
    'visitCancelledIndicator': visitCancelledIndicator,
    'clientVerifiedTimes': clientVerifiedTimes,
    'clientVerifiedService': clientVerifiedService,
    'clientSignatureAvailable': clientSignatureAvailable,
    'clientVoiceRecording': clientVoiceRecording,
    'service_id': serviceId,
  };
}
