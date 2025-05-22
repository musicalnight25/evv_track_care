class ClientVisitsTaskAddRequest {
  final String visitId;
  final String companyId;
  final String clientId;
  final String employeeId;
  final String taskId;
  final String taskReading;
  final String taskRefused;
  final String taskCode;
  final String payerID;
  final String serviceId;

  ClientVisitsTaskAddRequest({
    required this.visitId,
    required this.companyId,
    required this.clientId,
    required this.employeeId,
    required this.taskId,
    required this.taskReading,
    required this.taskRefused,
    required this.taskCode,
    required this.payerID,
    required this.serviceId,
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
      "task_code": taskCode,
      "PayerID": payerID,
      "service_id": serviceId,
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
      taskCode: json['task_code'],
      payerID: json['PayerID'],
      serviceId: json['service_id'],
    );
  }
}
