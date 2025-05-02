class VisitRequest {
  final String visitId;


  VisitRequest({required this.visitId});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'visit_id': visitId,
  };

}