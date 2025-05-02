class OfflineDataFatchReq {
  final String companyId;
  final String date;


  OfflineDataFatchReq({required this.companyId,required this.date});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'company_id': companyId,
    'date': date,
  };

}