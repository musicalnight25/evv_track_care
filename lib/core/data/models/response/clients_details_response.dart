
class ClientDetails {
  final String clientID;
  final String clientFirstName;
  final String clientMiddleInitial;
  final String clientLastName;
  final String clientQualifier;
  final String clientMedicaidID;
  final VisitTime visitTime;
  final List<ClientAddress> clientAddress;
  final List<ClientPhone> clientPhone;
  final List<Activity> activity;

  ClientDetails({
    required this.clientID,
    required this.clientFirstName,
    required this.clientMiddleInitial,
    required this.clientLastName,
    required this.clientQualifier,
    required this.clientMedicaidID,
    required this.visitTime,
    required this.clientAddress,
    required this.clientPhone,
    required this.activity,
  });

  factory ClientDetails.fromJson(Map<String, dynamic> json) => ClientDetails(
    clientID: json["ClientID"],
    clientFirstName: json["ClientFirstName"],
    clientMiddleInitial: json["ClientMiddleInitial"],
    clientLastName: json["ClientLastName"],
    clientQualifier: json["ClientQualifier"],
    clientMedicaidID: json["ClientMedicaidID"],
    visitTime: VisitTime.fromJson(json["VisitTime"]),
    clientAddress: List<ClientAddress>.from(
        json["ClientAddress"].map((x) => ClientAddress.fromJson(x))),
    clientPhone: List<ClientPhone>.from(
        json["ClientPhone"].map((x) => ClientPhone.fromJson(x))),
    activity:
    List<Activity>.from(json["Activity"].map((x) => Activity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "ClientID": clientID,
    "ClientFirstName": clientFirstName,
    "ClientMiddleInitial": clientMiddleInitial,
    "ClientLastName": clientLastName,
    "ClientQualifier": clientQualifier,
    "ClientMedicaidID": clientMedicaidID,
    "VisitTime": visitTime.toJson(),
    "ClientAddress": List<dynamic>.from(clientAddress.map((x) => x.toJson())),
    "ClientPhone": List<dynamic>.from(clientPhone.map((x) => x.toJson())),
    "Activity": List<dynamic>.from(activity.map((x) => x.toJson())),
  };
}

class VisitTime {
  final String startTime;
  final String endTime;

  VisitTime({
    required this.startTime,
    required this.endTime,
  });

  factory VisitTime.fromJson(Map<String, dynamic> json) => VisitTime(
    startTime: json["StartTime"],
    endTime: json["EndTime"],
  );

  Map<String, dynamic> toJson() => {
    "StartTime": startTime,
    "EndTime": endTime,
  };
}

class ClientAddress {
  final double clientAddressLongitude;
  final double clientAddressLatitude;

  ClientAddress({
    required this.clientAddressLongitude,
    required this.clientAddressLatitude,
  });

  factory ClientAddress.fromJson(Map<String, dynamic> json) => ClientAddress(
    clientAddressLongitude: json["ClientAddressLongitude"].toDouble(),
    clientAddressLatitude: json["ClientAddressLatitude"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "ClientAddressLongitude": clientAddressLongitude,
    "ClientAddressLatitude": clientAddressLatitude,
  };
}

class ClientPhone {
  final String clientPhoneType;
  final String clientPhone;

  ClientPhone({
    required this.clientPhoneType,
    required this.clientPhone,
  });

  factory ClientPhone.fromJson(Map<String, dynamic> json) => ClientPhone(
    clientPhoneType: json["ClientPhoneType"],
    clientPhone: json["ClientPhone"],
  );

  Map<String, dynamic> toJson() => {
    "ClientPhoneType": clientPhoneType,
    "ClientPhone": clientPhone,
  };
}

class Activity {
  final ActivityDetail toilet;
  final ActivityDetail showering;
  final ActivityDetail dressing;
  final ActivityDetail hydration;

  Activity({
    required this.toilet,
    required this.showering,
    required this.dressing,
    required this.hydration,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    toilet: ActivityDetail.fromJson(json["Toilet"]),
    showering: ActivityDetail.fromJson(json["Showering"]),
    dressing: ActivityDetail.fromJson(json["Dressing"]),
    hydration: ActivityDetail.fromJson(json["Hydration"]),
  );

  Map<String, dynamic> toJson() => {
    "Toilet": toilet.toJson(),
    "Showering": showering.toJson(),
    "Dressing": dressing.toJson(),
    "Hydration": hydration.toJson(),
  };
}

class ActivityDetail {
  final String title;
  final String time;
  final bool status;

  ActivityDetail({
    required this.title,
    required this.time,
    required this.status,
  });

  factory ActivityDetail.fromJson(Map<String, dynamic> json) => ActivityDetail(
    title: json["Title"],
    time: json["Time"],
    status: json["Status"],
  );

  Map<String, dynamic> toJson() => {
    "Title": title,
    "Time": time,
    "Status": status,
  };
}

// To parse this JSON data, you can use:
// final clientList = List<Client>.from(json.decode(jsonString).map((x) => Client.fromJson(x)));
