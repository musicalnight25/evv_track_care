class CompleteVisitReq {
  final String visitId;

  // final String ScheduleEndTime;
  final String AdjOutDateTime;
  final String? longitude;
  final String? latitude;
  final String? address;

  CompleteVisitReq(
      {required this.visitId,
      required this.AdjOutDateTime,
      required this.longitude,
      required this.latitude,
      required this.address});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
        'visit_id': visitId,
        // 'ScheduleEndTime': ScheduleEndTime,
        'AdjOutDateTime': AdjOutDateTime,
        'longitude': longitude,
        'latitude': latitude,
        'address': address,
      };
}
