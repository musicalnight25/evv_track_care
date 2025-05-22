/*class LoginResponse {
  final bool status;
  final String message;
  final List<dynamic>? data;

  LoginResponse({required this.status, required this.message, required this.data});

  /// THIS IS fromJson METHOD THAT IS ONLY REQUIRED IN RESPONSE
  /// IF YOU WANT TO STORE DATA OFFLINE THAN YOU NEED TO toJson METHOD

  factory LoginResponse.fromJson(Map<String, dynamic>? json) => LoginResponse(
        status: json?['status'] ?? false,
        message: json?['message'] ?? "Something went wrong.!",
        data: json?['data'],
      );
}

 */


class UserResponse {
  String? status;
  String? message;
  Data? data;
  String? token;

  UserResponse({this.status, this.message, this.data, this.token});

  UserResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? avatar;
  int? companyId;
  String? type;
  String? employeeQualifier;
  String? employeeIdentifier;
  String? employeeOtherID;
  String? sequenceID;
  String? employeeLastName;
  String? employeeFirstName;
  String? employeeEmail;
  String? temp;
  int? currentCompanyId;
  String? deviceId;
  String? sandata;
  String? twoFactorCode;
  String? twoFactorExpiresAt;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;

  Data(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.avatar,
        this.companyId,
        this.type,
        this.employeeQualifier,
        this.employeeIdentifier,
        this.employeeOtherID,
        this.sequenceID,
        this.employeeLastName,
        this.employeeFirstName,
        this.employeeEmail,
        this.temp,
        this.currentCompanyId,
        this.deviceId,
        this.sandata,
        this.twoFactorCode,
        this.twoFactorExpiresAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    companyId = json['company_id'];
    type = json['type'];
    employeeQualifier = json['EmployeeQualifier'];
    employeeIdentifier = json['EmployeeIdentifier'];
    employeeOtherID = json['EmployeeOtherID'];
    sequenceID = json['SequenceID'];
    employeeLastName = json['EmployeeLastName'];
    employeeFirstName = json['EmployeeFirstName'];
    employeeEmail = json['EmployeeEmail'];
    temp = json['temp'];
    currentCompanyId = json['current_company_id'];
    deviceId = json['device_id'];
    sandata = json['sandata'];
    twoFactorCode = json['two_factor_code'];
    twoFactorExpiresAt = json['two_factor_expires_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['avatar'] = avatar;
    data['company_id'] = companyId;
    data['type'] = type;
    data['EmployeeQualifier'] = employeeQualifier;
    data['EmployeeIdentifier'] = employeeIdentifier;
    data['EmployeeOtherID'] = employeeOtherID;
    data['SequenceID'] = sequenceID;
    data['EmployeeLastName'] = employeeLastName;
    data['EmployeeFirstName'] = employeeFirstName;
    data['EmployeeEmail'] = employeeEmail;
    data['temp'] = temp;
    data['current_company_id'] = currentCompanyId;
    data['device_id'] = deviceId;
    data['sandata'] = sandata;
    data['two_factor_code'] = twoFactorCode;
    data['two_factor_expires_at'] = twoFactorExpiresAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}


/*class UserResponse {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? avatar;
  int? companyId;
  String? type;
  String? employeeQualifier;
  String? employeeIdentifier;
  String? employeeOtherID;
  String? sequenceID;
  String? employeeLastName;
  String? employeeFirstName;
  String? employeeEmail;
  String? createdAt;
  String? updatedAt;
  String? temp;
  String? baseUrl;

  UserResponse({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.avatar,
    this.companyId,
    this.type,
    this.employeeQualifier,
    this.employeeIdentifier,
    this.employeeOtherID,
    this.sequenceID,
    this.employeeLastName,
    this.employeeFirstName,
    this.employeeEmail,
    this.createdAt,
    this.updatedAt,
    this.temp,
    this.baseUrl
  });

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    avatar = json['avatar'];
    companyId = json['company_id'];
    type = json['type'];
    employeeQualifier = json['EmployeeQualifier'];
    employeeIdentifier = json['EmployeeIdentifier'];
    employeeOtherID = json['EmployeeOtherID'];
    sequenceID = json['SequenceID'];
    employeeLastName = json['EmployeeLastName'];
    employeeFirstName = json['EmployeeFirstName'];
    employeeEmail = json['EmployeeEmail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    baseUrl = json['base_url'];
    temp = json['temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['avatar'] = avatar;
    data['company_id'] = companyId;
    data['type'] = type;
    data['EmployeeQualifier'] = employeeQualifier;
    data['EmployeeIdentifier'] = employeeIdentifier;
    data['EmployeeOtherID'] = employeeOtherID;
    data['SequenceID'] = sequenceID;
    data['EmployeeLastName'] = employeeLastName;
    data['EmployeeFirstName'] = employeeFirstName;
    data['EmployeeEmail'] = employeeEmail;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['base_url'] = baseUrl;
    data['temp'] = temp;
    return data;
  }
}*/
