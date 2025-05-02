class CompleteVisitReq {
  final String visitId;
  final String ScheduleEndTime;


  CompleteVisitReq({required this.visitId,required this.ScheduleEndTime});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'visit_id': visitId,
    'ScheduleEndTime': ScheduleEndTime,
  };

}