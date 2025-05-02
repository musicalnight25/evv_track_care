class StartVisitRequest {
  final String visitId;
  final String ScheduleStartTime;


  StartVisitRequest({required this.visitId,required this.ScheduleStartTime});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'visit_id': visitId,
    'ScheduleStartTime': ScheduleStartTime,
  };

}