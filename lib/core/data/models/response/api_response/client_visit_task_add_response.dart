class ClientVisitTaskAddResponse {
  final int id;
  final int companyId;
  final int clientId;
  final int userId;
  final int visitId;
  final String taskId;
  final String taskReading;
  final int taskRefused;
  final String createdAt;
  final String updatedAt;

  ClientVisitTaskAddResponse({
    required this.id,
    required this.companyId,
    required this.clientId,
    required this.userId,
    required this.visitId,
    required this.taskId,
    required this.taskReading,
    required this.taskRefused,
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert JSON to Dart object
  factory ClientVisitTaskAddResponse.fromJson(Map<String, dynamic> json) {
    return ClientVisitTaskAddResponse(
      id: json['id'],
      companyId: json['company_id'],
      clientId: json['client_id'],
      userId: json['user_id'],
      visitId: json['visit_id'],
      taskId: json['TaskID'],
      taskReading: json['TaskReading'],
      taskRefused: json['TaskRefused'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  // Convert Dart object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'company_id': companyId,
      'client_id': clientId,
      'user_id': userId,
      'visit_id': visitId,
      'TaskID': taskId,
      'TaskReading': taskReading,
      'TaskRefused': taskRefused,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
