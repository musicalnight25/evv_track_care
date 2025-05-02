class TaskListRequest {
  final int? companyid;
  final int? clientId;


  TaskListRequest({required this.companyid,required this.clientId});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'company': companyid,
    'client': clientId,
  };

}