
class ZEmployeeModel {
  final num? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? department;
  final String? designation;

  ZEmployeeModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.department,
    this.designation,
  });

  // Convert JSON to ZEmployeeModel object
  factory ZEmployeeModel.fromJson(Map<String, dynamic> json) {
    return ZEmployeeModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      department: json['department'],
      designation: json['designation'],
    );
  }

  // Convert ZEmployeeModel object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'department': department,
      'designation': designation,
    };
  }
}
