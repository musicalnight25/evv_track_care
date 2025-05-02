
class Clients {
  ProviderIdentification providerIdentification;
  String clientID;
  String clientFirstName;
  String clientMiddleInitial;
  String clientLastName;
  String clientQualifier;
  String clientMedicaidID;
  VisitTime visitTime;
  List<ClientAddress> clientAddress;
  List<ClientPhone> clientPhone;

  Clients({
    required this.providerIdentification,
    required this.clientID,
    required this.clientFirstName,
    required this.clientMiddleInitial,
    required this.clientLastName,
    required this.clientQualifier,
    required this.clientMedicaidID,
    required this.visitTime,
    required this.clientAddress,
    required this.clientPhone,
  });

  factory Clients.fromJson(Map<String, dynamic> json) {
    return Clients(
      providerIdentification: ProviderIdentification.fromJson(json['ProviderIdentification']),
      clientID: json['ClientID'],
      clientFirstName: json['ClientFirstName'],
      clientMiddleInitial: json['ClientMiddleInitial'],
      clientLastName: json['ClientLastName'],
      clientQualifier: json['ClientQualifier'],
      clientMedicaidID: json['ClientMedicaidID'],
      visitTime: VisitTime.fromJson(json['VisitTime']),
      clientAddress: (json['ClientAddress'] as List)
          .map((address) => ClientAddress.fromJson(address))
          .toList(),
      clientPhone: (json['ClientPhone'] as List)
          .map((phone) => ClientPhone.fromJson(phone))
          .toList(),
    );
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
}

class VisitTime {
  String startTime;
  String endTime;

  VisitTime({
    required this.startTime,
    required this.endTime,
  });

  factory VisitTime.fromJson(Map<String, dynamic> json) {
    return VisitTime(
      startTime: json['StartTime'],
      endTime: json['EndTime'],
    );
  }
}

class ClientAddress {
  String clientAddressType;
  bool clientAddressIsPrimary;
  String clientAddressLine1;
  String clientAddressLine2;
  String clientCounty;
  String clientCity;
  String clientState;
  String clientZip;
  double clientAddressLongitude;
  double clientAddressLatitude;

  ClientAddress({
    required this.clientAddressType,
    required this.clientAddressIsPrimary,
    required this.clientAddressLine1,
    required this.clientAddressLine2,
    required this.clientCounty,
    required this.clientCity,
    required this.clientState,
    required this.clientZip,
    required this.clientAddressLongitude,
    required this.clientAddressLatitude,
  });

  factory ClientAddress.fromJson(Map<String, dynamic> json) {
    return ClientAddress(
      clientAddressType: json['ClientAddressType'],
      clientAddressIsPrimary: json['ClientAddressIsPrimary'],
      clientAddressLine1: json['ClientAddressLine1'],
      clientAddressLine2: json['ClientAddressLine2'],
      clientCounty: json['ClientCounty'],
      clientCity: json['ClientCity'],
      clientState: json['ClientState'],
      clientZip: json['ClientZip'],
      clientAddressLongitude: json['ClientAddressLongitude'].toDouble(),
      clientAddressLatitude: json['ClientAddressLatitude'].toDouble(),
    );
  }
}

class ClientPhone {
  String clientPhoneType;
  String clientPhone;

  ClientPhone({
    required this.clientPhoneType,
    required this.clientPhone,
  });

  factory ClientPhone.fromJson(Map<String, dynamic> json) {
    return ClientPhone(
      clientPhoneType: json['ClientPhoneType'],
      clientPhone: json['ClientPhone'],
    );
  }
}
