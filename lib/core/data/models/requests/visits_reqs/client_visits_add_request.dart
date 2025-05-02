import 'package:healthcare/core/data/models/response/z_response/z_visit_model.dart';

class ClientVisitsAddRequest {
  final num clientId;
  final num employeeId;
  final num payerId;
  final num companyId;
  final String visitOtherID;
  final String sequenceID;
  final String visitTimeZone;

  //final String scheduleStartTime;
//  final String scheduleEndTime;
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
  final num? service_id;
  final num? program_id;

  // final String billVisit;

  ClientVisitsAddRequest({
    required this.clientId,
    required this.employeeId,
    required this.payerId,
    required this.companyId,
    required this.visitOtherID,
    required this.sequenceID,
    required this.visitTimeZone,
    //required this.scheduleStartTime,
    //required this.scheduleEndTime,
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
    required this.service_id,
    required this.program_id,
    // required this.billVisit,
  });

  ZVisitModel toVisitModel() => ZVisitModel(
        clientId: this.clientId,
        employeeIdentifier: this.employeeId.toString(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        scheduleStartTime: DateTime.now(),
        payerID: this.payerId.toString(),
        companyId: this.companyId,
        visitOtherID: this.visitOtherID,
        sequenceID: this.sequenceID,
        visitTimeZone: this.visitTimeZone,
        contingencyPlan: this.contingencyPlan,
        reschedule: this.reschedule,
        adjInDateTime: DateTime.tryParse(this.adjInDateTime),
        adjOutDateTime: DateTime.tryParse(this.adjOutDateTime),
        hoursToBill: num.tryParse(this.hoursToBill),
        hoursToPay: num.tryParse(this.hoursToPay),
        visitCancelledIndicator: this.visitCancelledIndicator,
        clientVerifiedTimes: this.clientVerifiedTimes,
        clientVerifiedService: this.clientVerifiedService,
        clientSignatureAvailable: this.clientSignatureAvailable,
        clientVoiceRecording: this.clientVoiceRecording,
        serviceId: this.service_id,
        payerProgram: this.program_id.toString(),
        synced: 0,
      );

  Map<String, dynamic> toJson() {
    return {
      "client_id": clientId,
      "employee_id": employeeId,
      "payer_id": payerId, //
      "company_id": companyId,
      "VisitOtherID": visitOtherID, //
      "SequenceID": sequenceID,
      "VisitTimeZone": visitTimeZone, //
      //"ScheduleStartTime": scheduleStartTime,
      //"ScheduleEndTime": scheduleEndTime,
      "ContingencyPlan": contingencyPlan, //
      "Reschedule": reschedule, //
      "AdjInDateTime": adjInDateTime, //
      "AdjOutDateTime": adjOutDateTime, //
      "HoursToBill": hoursToBill, //
      "HoursToPay": hoursToPay, //
      "VisitCancelledIndicator": visitCancelledIndicator, //
      "ClientVerifiedTimes": clientVerifiedTimes, //
      "ClientVerifiedService": clientVerifiedService, //
      "ClientSignatureAvailable": clientSignatureAvailable, //
      "ClientVoiceRecording": clientVoiceRecording, //
      "service_id": service_id, //
      "program_id": program_id, //
      // "BillVisit": billVisit,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "client_id": clientId,
      "employee_id": employeeId,
      "payer_id": payerId,
      "company_id": companyId,
      "visit_other_id": visitOtherID,
      "sequence_id": sequenceID,
      "visit_time_zone": visitTimeZone,
      //"schedule_start_time": scheduleStartTime,
      //     "schedule_end_time": scheduleEndTime,
      "contingency_plan": contingencyPlan,
      "reschedule": reschedule,
      "adj_in_date_time": adjInDateTime,
      "adj_out_date_time": adjOutDateTime,
      "hours_to_bill": hoursToBill,
      "hours_to_pay": hoursToPay,
      "visit_cancelled_indicator": visitCancelledIndicator,
      "client_verified_times": clientVerifiedTimes,
      "client_verified_service": clientVerifiedService,
      "client_signature_available": clientSignatureAvailable,
      "client_voice_recording": clientVoiceRecording,
      "service_id": service_id,
      "program_id": program_id,
    };
  }

  factory ClientVisitsAddRequest.fromJson(Map<String, dynamic> json) {
    return ClientVisitsAddRequest(
      clientId: json["client_id"] as num,
      employeeId: json["employee_id"] as num,
      payerId: json["payer_id"] as num,
      companyId: json["company_id"] as num,
      visitOtherID: json["visit_other_id"] as String,
      sequenceID: json["sequence_id"] as String,
      visitTimeZone: json["visit_time_zone"] as String,
      //scheduleStartTime: json["schedule_start_time"] as String,
      //  scheduleEndTime: json["schedule_end_time"] as String,
      contingencyPlan: json["contingency_plan"] as String,
      reschedule: json["reschedule"] as num,
      adjInDateTime: json["adj_in_date_time"] as String,
      adjOutDateTime: json["adj_out_date_time"] as String,
      hoursToBill: json["hours_to_bill"] as String,
      hoursToPay: json["hours_to_pay"] as String,
      visitCancelledIndicator: json["visit_cancelled_indicator"] as num,
      clientVerifiedTimes: json["client_verified_times"] as num,
      clientVerifiedService: json["client_verified_service"] as num,
      clientSignatureAvailable: json["client_signature_available"] as num,
      clientVoiceRecording: json["client_voice_recording"] as num,
      service_id: json["service_id"],
      program_id: json["program_id"],
    );
  }

}
