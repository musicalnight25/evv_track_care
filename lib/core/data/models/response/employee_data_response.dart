class EmployeeData {
  ProviderIdentification? providerIdentification;
  String? employeeQualifier;
  String? employeeIdentifier;
  String? employeeOtherID;
  int? sequenceID;
  String? employeeLastName;
  String? employeeFirstName;
  String? employeeEmail;

  EmployeeData({
   this.providerIdentification,
   this.employeeQualifier,
   this.employeeIdentifier,
   this.employeeOtherID,
   this.sequenceID,
   this.employeeLastName,
   this.employeeFirstName,
   this.employeeEmail,
  });

  factory EmployeeData.fromJson(Map<String, dynamic> json) {
    return EmployeeData(
      providerIdentification: ProviderIdentification.fromJson(json['ProviderIdentification']),
      employeeQualifier: json['EmployeeQualifier'],
      employeeIdentifier: json['EmployeeIdentifier'],
      employeeOtherID: json['EmployeeOtherID'],
      sequenceID: json['SequenceID'],
      employeeLastName: json['EmployeeLastName'],
      employeeFirstName: json['EmployeeFirstName'],
      employeeEmail: json['EmployeeEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProviderIdentification': providerIdentification?.toJson(),
      'EmployeeQualifier': employeeQualifier,
      'EmployeeIdentifier': employeeIdentifier,
      'EmployeeOtherID': employeeOtherID,
      'SequenceID': sequenceID,
      'EmployeeLastName': employeeLastName,
      'EmployeeFirstName': employeeFirstName,
      'EmployeeEmail': employeeEmail,
    };
  }
}

class ProviderIdentification {
  String providerQualifier;
  String providerID;

  ProviderIdentification({
    required this.providerQualifier,
    required this.providerID,
  });

  factory ProviderIdentification.fromJson(Map<String, dynamic> json) {
    return ProviderIdentification(
      providerQualifier: json['ProviderQualifier'],
      providerID: json['ProviderID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ProviderQualifier': providerQualifier,
      'ProviderID': providerID,
    };
  }
}
