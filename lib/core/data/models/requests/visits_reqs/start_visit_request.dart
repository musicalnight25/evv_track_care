class StartVisitRequest {
  final String visitId;
  // final String ScheduleStartTime;
  final String AdjInDateTime;
  final String? longitude;
  final String? latitude;
  final String? address;
   String? reason;

  StartVisitRequest(
      {required this.visitId,
      required this.AdjInDateTime,
        required this.longitude,
        required  this.latitude,required this.address,this.reason});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'visit_id': visitId,
    // 'ScheduleStartTime': ScheduleStartTime,
    'AdjInDateTime': AdjInDateTime,
    'longitude': longitude,
    'latitude': latitude,
    'address': address,
    'reason': reason,
  };

}