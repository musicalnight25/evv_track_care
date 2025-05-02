class VisitsRequest {
  final int clientId;


  VisitsRequest({required this.clientId});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'client_id': clientId,
  };

}