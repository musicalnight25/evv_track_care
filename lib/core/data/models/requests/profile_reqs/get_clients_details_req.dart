class GetClientsDetailsReq {
  final String companyId;
  final String clientId;


  GetClientsDetailsReq({required this.companyId,required this.clientId});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'company': companyId,
    'client_id': clientId,
  };

}