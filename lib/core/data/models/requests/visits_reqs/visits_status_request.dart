class VisitsStatusRequest {
  final String visitId;
  final String status;


  VisitsStatusRequest({required this.visitId,required this.status});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'visit_id': visitId,
    'status': status,
  };

}