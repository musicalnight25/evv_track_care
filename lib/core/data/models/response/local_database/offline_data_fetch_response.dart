class DataFetchResponse {
  final Company? company;
  final List<ProgramElement>? services;
  final List<TaskList>? taskLists;
  final List<DataFetchResponseClient>? clients;

  DataFetchResponse({
    this.company,
    this.services,
    this.taskLists,
    this.clients,
  });

}

class DataFetchResponseClient {
  final Company? providerIdentification;
  final CompanyClient? client;
  final List<ClientAddress>? clientAddress;
  final List<ClientPhone>? clientPhone;
 // final List<dynamic>? visitTime;
  final List<ClientServiceElement>? clientServices;

  DataFetchResponseClient({
    this.providerIdentification,
    this.client,
    this.clientAddress,
    this.clientPhone,
   // this.visitTime,
    this.clientServices,
  });

}

class Company {
  final int? id;
  final String? name;
  final String? slug;
  final String? email;
  final String? telephone;
  final String? addressLineOne;
  final String? addressLineTwo;
  final String? county;
  final String? city;
  final String? state;
  final String? zip;
  final String? website;
  final String? logo;
  final String? about;
  final String? providerQualifier;
  final String? providerId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final List<ProgramElement>? services;
  final List<TaskList>? taskLists;
  final List<CompanyClient>? clients;
  final List<ProgramElement>? programs;

  Company({
    this.id,
    this.name,
    this.slug,
    this.email,
    this.telephone,
    this.addressLineOne,
    this.addressLineTwo,
    this.county,
    this.city,
    this.state,
    this.zip,
    this.website,
    this.logo,
    this.about,
    this.providerQualifier,
    this.providerId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.services,
    this.taskLists,
    this.clients,
    this.programs,
  });

}

class CompanyClient {
  final int? id;
  final int? companyId;
  final int? userId;
  final String? clientId;
  final String? clientFirstName;
  final String? clientMiddleInitial;
  final String? clientLastName;
  final String? clientQualifier;
  final String? clientMedicaidId;
  final String? clientIdentifier;
  final int? missingMedicaidId;
  final String? sequenceId;
  final String? clientCustomId;
  final String? clientOtherId;
  final String? clientTimezone;
  final String? coordinator;
  final int? providerAssentContPlan;
  final String? avatar;
  final String? sandata;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;
  final DateTime? clientBirthDate;
  final List<String?>? visits;
  final List<ClientServiceElement>? services;
  final Company? company;
  final List<ClientAddress>? clientAddresses;
  final List<ClientPhone>? clientPhones;

  CompanyClient({
    this.id,
    this.companyId,
    this.userId,
    this.clientId,
    this.clientFirstName,
    this.clientMiddleInitial,
    this.clientLastName,
    this.clientQualifier,
    this.clientMedicaidId,
    this.clientIdentifier,
    this.missingMedicaidId,
    this.sequenceId,
    this.clientCustomId,
    this.clientOtherId,
    this.clientTimezone,
    this.coordinator,
    this.providerAssentContPlan,
    this.avatar,
    this.sandata,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.clientBirthDate,
    this.visits,
    this.services,
    this.company,
    this.clientAddresses,
    this.clientPhones,
  });

}

class ProgramElement {
  final int? id;
  final String? name;
  final String? programName;
  final String? payerProgram;
  final String? deletedAt;
  final String? createdAt;
  final String? updatedAt;
  final Pivot? pivot;

  ProgramElement({
    this.id,
    this.name,
    this.programName,
    this.payerProgram,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

}

class Pivot {
  final int? companyId;
  final int? programId;

  Pivot({
    this.companyId,
    this.programId,
  });

}

class TaskList {
  final int? id;
  final String? name;
  final String? code;
  final String? about;
  final int? serviceId;
  final int? companyId;
  final int? programId;
  final String? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  TaskList({
    this.id,
    this.name,
    this.code,
    this.about,
    this.serviceId,
    this.companyId,
    this.programId,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

}

class ClientAddress {
  final int? id;
  final int? companyId;
  final int? clientId;
  final String? clientAddressType;
  final int? clientAddressIsPrimary;
  final String? clientAddressLine1;
  final String? clientAddressLine2;
  final String? clientCounty;
  final String? clientCity;
  final String? clientState;
  final String? clientZip;
  final String? clientAddressLongitude;
  final String? clientAddressLatitude;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;

  ClientAddress({
    this.id,
    this.companyId,
    this.clientId,
    this.clientAddressType,
    this.clientAddressIsPrimary,
    this.clientAddressLine1,
    this.clientAddressLine2,
    this.clientCounty,
    this.clientCity,
    this.clientState,
    this.clientZip,
    this.clientAddressLongitude,
    this.clientAddressLatitude,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

}

class ClientPhone {
  final int? id;
  final int? companyId;
  final int? clientId;
  final String? clientPhoneType;
  final String? clientPhone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? deletedAt;

  ClientPhone({
    this.id,
    this.companyId,
    this.clientId,
    this.clientPhoneType,
    this.clientPhone,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

}

class ClientServiceElement {
  final int? companyId;
  final int? clientId;
  final String? payerId;
  final int? serviceId;
  final String? taskName;
  final String? taskCode;

  ClientServiceElement({
    this.companyId,
    this.clientId,
    this.payerId,
    this.serviceId,
    this.taskName,
    this.taskCode,
  });

}

