class AgencyReq {
  final int employeeId;


  AgencyReq({required this.employeeId});

  /// toJson METHOD USE TO PASS DATA IN API CALL AS JSON FORMAT
  Map<String, dynamic> toJson() => {
    'employee_id': employeeId,

  };


}
