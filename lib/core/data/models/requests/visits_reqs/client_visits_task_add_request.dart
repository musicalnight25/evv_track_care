class ClientVisitsTaskAddRequest {
  final String visitId;
  final String companyId;
  final String clientId;
  final String employeeId;
  final String taskId;
  final String taskReading;
  final String taskRefused;

  ClientVisitsTaskAddRequest({
    required this.visitId,
    required this.companyId,
    required this.clientId,
    required this.employeeId,
    required this.taskId,
    required this.taskReading,
    required this.taskRefused,
  });

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      "visit_id": visitId,
      "company_id": companyId,
      "client_id": clientId,
      "employee_id": employeeId,
      "TaskID": taskId,
      "TaskReading": taskReading,
      "TaskRefused": taskRefused,
    };
  }

  // Create from JSON
  factory ClientVisitsTaskAddRequest.fromJson(Map<String, dynamic> json) {
    return ClientVisitsTaskAddRequest(
      visitId: json['visit_id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      employeeId: json['employee_id'],
      taskId: json['TaskID'],
      taskReading: json['TaskReading'],
      taskRefused: json['TaskRefused'],
    );
  }
}
