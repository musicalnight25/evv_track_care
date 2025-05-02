class ServiceListRequest {
  final int companyId;

  ServiceListRequest({required this.companyId});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'company': companyId,
  };

}