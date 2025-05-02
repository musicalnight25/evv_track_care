class OfflineTaskAddData {
  int visitId;
  int companyId;
  int clientId;
  int employeeId;
  String taskId;
  String taskReading;
  int taskRefused;

  OfflineTaskAddData({
    required this.visitId,
    required this.companyId,
    required this.clientId,
    required this.employeeId,
    required this.taskId,
    required this.taskReading,
    required this.taskRefused,
  });

  // Convert from JSON to Dart object
  factory OfflineTaskAddData.fromJson(Map<String, dynamic> json) {
    return OfflineTaskAddData(
      visitId: json['visit_id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      employeeId: json['employee_id'],
      taskId: json['TaskID'],
      taskReading: json['TaskReading'],
      taskRefused: json['TaskRefused'],
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'visit_id': visitId,
      'company_id': companyId,
      'client_id': clientId,
      'employee_id': employeeId,
      'TaskID': taskId,
      'TaskReading': taskReading,
      'TaskRefused': taskRefused,
    };
  }
}
