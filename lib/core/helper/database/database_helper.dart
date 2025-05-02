import 'package:healthcare/core/data/models/response/z_response/z_client_address_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_client_phone_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_company_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_service_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_tasklists_model.dart';
import 'package:healthcare/core/data/models/response/z_response/z_visit_model.dart';
import 'package:healthcare/core/helper/database/sqflite_client.dart';
import 'package:healthcare/core/utils/devlog.dart';
import 'package:healthcare/di_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

import '../../data/models/response/z_response/z_client_model.dart';
import '../../data/models/response/z_response/z_visit_service_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();

  factory DatabaseHelper() => instance;

  DatabaseHelper._internal();

  Database? _database;
  SqfliteClient? _client;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database?> initDatabase() async {
    _client = Di.sl<SqfliteClient>();
    final db = await _client?.initialize(onCreate: onCreate);
    _database = db;
    return db;
  }

  Future<void> onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE IF NOT EXISTS company_data (
      id INTEGER PRIMARY KEY,
      name TEXT,
      slug TEXT,
      email TEXT,
      telephone TEXT,
      address_line_one TEXT,
      address_line_two TEXT,
      county TEXT,
      city TEXT,
      state TEXT,
      zip TEXT,
      website TEXT,
      logo TEXT,
      about TEXT,
      provider_qualifier TEXT,
      provider_id TEXT,
      created_at TEXT,
      updated_at TEXT,
      deleted_at TEXT
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS client_data (
      id INTEGER PRIMARY KEY,
      company_id INTEGER,
      user_id INTEGER,
      ClientID TEXT UNIQUE,
      ClientFirstName TEXT,
      ClientMiddleInitial TEXT,
      ClientLastName TEXT,
      ClientQualifier TEXT,
      ClientMedicaidID TEXT,
      ClientIdentifier TEXT,
      MissingMedicaidID INTEGER,
      SequenceID TEXT,
      ClientCustomID TEXT,
      ClientOtherID TEXT,
      ClientTimezone TEXT,
      Coordinator TEXT,
      ProviderAssentContPlan TEXT,
      avatar TEXT,
      sandata TEXT,
      created_at TEXT,
      updated_at TEXT,
      deleted_at TEXT,
      ClientBirthDate TEXT,
      FOREIGN KEY (company_id) REFERENCES company_data(id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
      CREATE TABLE client_address (
        id INTEGER PRIMARY KEY,
        company_id INTEGER,
        client_id INTEGER,
        ClientAddressType TEXT,
        ClientAddressIsPrimary INTEGER,
        ClientAddressLine1 TEXT,
        ClientAddressLine2 TEXT,
        ClientCounty TEXT,
        ClientCity TEXT,
        ClientState TEXT,
        ClientZip TEXT,
        ClientAddressLongitude REAL,
        ClientAddressLatitude REAL,
        created_at TEXT,
        updated_at TEXT,
        deleted_at TEXT,
        FOREIGN KEY (client_id) REFERENCES client_data(id) ON DELETE CASCADE,
        FOREIGN KEY (company_id) REFERENCES company_data(id) ON DELETE CASCADE
    );
    ''');

    await db.execute('''
      CREATE TABLE client_phone (
        id INTEGER PRIMARY KEY,
        company_id INTEGER,
        client_id INTEGER,
        ClientPhoneType TEXT,
        ClientPhone TEXT,
        created_at TEXT,
        updated_at TEXT,
        deleted_at TEXT,
        FOREIGN KEY (client_id) REFERENCES client_data(id) ON DELETE CASCADE,
        FOREIGN KEY (company_id) REFERENCES company_data(id) ON DELETE CASCADE
    );
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS visit_data (
        id INTEGER PRIMARY KEY,
        company_id INTEGER,
        client_id INTEGER,
        user_id INTEGER,
        status TEXT,
        client_payer_id INTEGER,
        VisitOtherID TEXT,
        SequenceID TEXT,
        EmployeeQualifier TEXT,
        EmployeeOtherID TEXT,
        EmployeeIdentifier TEXT,
        GroupCode TEXT,
        ClientID TEXT,
        VisitCancelledIndicator INTEGER,
        PayerID TEXT,
        PayerProgram TEXT,
        ProcedureCode TEXT,
        Modifier1 TEXT,
        Modifier2 TEXT,
        Modifier3 TEXT,
        Modifier4 TEXT,
        VisitTimeZone TEXT,
        ScheduleStartTime TEXT,
        ScheduleEndTime TEXT,
        ContingencyPlan TEXT,
        Reschedule INTEGER,
        AdjInDateTime TEXT,
        AdjOutDateTime TEXT,
        BillVisit TEXT,
        HoursToBill REAL,
        HoursToPay REAL,
        Memo TEXT,
        ClientVerifiedTimes INTEGER,
        ClientVerifiedService INTEGER,
        ClientSignatureAvailable INTEGER,
        ClientVoiceRecording INTEGER,
        created_at TEXT,
        updated_at TEXT,
        deleted_at TEXT,
        signature_file TEXT,
        audio_file TEXT,
        service_id INTEGER,
        ClientIDQualifier TEXT,
        sandata TEXT,
        BypassReason TEXT,
        synced INTEGER,
        FOREIGN KEY (client_id) REFERENCES client_data(id) ON DELETE CASCADE,
        FOREIGN KEY (company_id) REFERENCES company_data(id) ON DELETE CASCADE,
        FOREIGN KEY (service_id) REFERENCES service_list_data(id) ON DELETE CASCADE
      );
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS visit_service_data (
      id INTEGER PRIMARY KEY,
      company_id INTEGER,
      client_id INTEGER,
      PayerID TEXT,
      service_id INTEGER,
      task_name TEXT,
      task_code TEXT,
      FOREIGN KEY (company_id) REFERENCES company_data(id) ON DELETE CASCADE,
      FOREIGN KEY (client_id) REFERENCES client_data(id) ON DELETE CASCADE,
      FOREIGN KEY (service_id) REFERENCES service_list_data(id) ON DELETE CASCADE
    );
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS service_list_data (
      id INTEGER PRIMARY KEY,
      name TEXT,
      ProgramName TEXT,
      PayerProgram TEXT,
      deleted_at TEXT,
      created_at TEXT,
      updated_at TEXT,     
      company_id INTEGER,
      FOREIGN KEY (company_id) REFERENCES company_data(id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS task_list_data (
      id INTEGER PRIMARY KEY,
      name TEXT,
      code TEXT,
      about TEXT,
      service_id INTEGER,
      company_id INTEGER,
      program_id INTEGER,
      deleted_at TEXT,
      created_at TEXT,
      updated_at TEXT,        
      FOREIGN KEY (company_id) REFERENCES company_data(id) ON DELETE CASCADE
    )
  ''');

    await db.execute('''
    CREATE TABLE IF NOT EXISTS agency_list_data (
      id INTEGER PRIMARY KEY,
      agency_name TEXT,
      company_id INTEGER,
      FOREIGN KEY (company_id) REFERENCES company_data(id) ON DELETE CASCADE
    )
  ''');

    devlog("DATABASE CREATED SUCCESSFULLY");
  }

  /// **CRUD for Visits**
  Future<void> insertVisitData(ZVisitModel visitData) async {
    await _client?.insertData(SqlTable.visit_data, visitData.toJson());
    devlog("Inserted Visit Data: ${visitData.toJson()}");
  }

  Future<void> updateVisitData(ZVisitModel visitData) async {
    await _client?.updateData(SqlTable.visit_data, visitData.toJson(), [visitData.id], whereClause: 'id = ?');
    devlog("Updated Visit Data: \${visitData.toMap()}");
  }

  Future<void> deleteVisit(int id) async {
    await _client?.deleteData(SqlTable.visit_data, 'id = ?', [id]);
    devlog("Deleted Visit ID: \$id");
  }

  Future<void> deleteNotSyncedVisits() async {
    await _client?.deleteData(SqlTable.visit_data, 'synced = ?', [0]);
  }

  Future<List<ZVisitModel>> getVisitData() async {
    final maps = await _client?.readData(SqlTable.visit_data);
    return maps == null ? [] : maps.map((e) => ZVisitModel.fromJson(e)).toList();
  }

  Future<List<ZVisitModel>> getVisitDataNotSynced() async {
    final maps = await _client?.readDataWithFilters(table: SqlTable.visit_data, whereClause: "synced = ?", whereArgs: [0]);
    return maps == null ? [] : maps.map((e) => ZVisitModel.fromJson(e)).toList();
  }

  /// **Fetching Data Only (No Insert/Update/Delete)**
  Future<List<ZCompanyModel>> getCompanyData() async {
    final maps = await _client?.readData(SqlTable.company_data);
    return maps == null ? [] : maps.map((e) => ZCompanyModel.fromJson(e)).toList();
  }

  Future<ZCompanyModel?> getCompanyDataById(String companyId, {bool getServices = true, bool getTaskLists = true, bool getClients = true, bool getVisitsOnlyFromClient = false}) async {
    final maps = await _client?.readData(SqlTable.company_data);
    final List<ZCompanyModel> list = maps == null ? [] : maps.map((e) => ZCompanyModel.fromJson(e)).toList();
    ZCompanyModel? currentCompany = list.where((element) => element.id?.toString() == companyId).firstOrNull;
    if (currentCompany == null) {
      devlog("NO COMPANY FOUND WITH ID $companyId");
      return null;
    }

    if (getServices) {
    final  serviceMaps = await _client?.rawQuery("SELECT * FROM ${SqlTable.service_list_data.name}");
      final List<ZServiceModel> serviceList = serviceMaps == null ? [] : serviceMaps.map((e) => ZServiceModel.fromJson(e)).toList();
      currentCompany = currentCompany.copyWith(services: serviceList);
    }

    if (getTaskLists) {
      final taskListsMaps = await _client?.rawQuery("SELECT * FROM ${SqlTable.task_list_data.name}");
      final List<ZTaskListModel> taskListsList = taskListsMaps == null ? [] : taskListsMaps.map((e) => ZTaskListModel.fromJson(e)).toList();
      currentCompany = currentCompany.copyWith(taskLists: List.from(taskListsList));
    }

    if (getClients) {
      final clientsMaps = await _client?.rawQuery("SELECT * FROM ${SqlTable.client_data.name} WHERE company_id = ${num.tryParse(companyId)}");
      List<ZClientModel> clientsList = clientsMaps == null ? [] : clientsMaps.map((e) => ZClientModel.fromJson(e)).toList();
      for (ZClientModel c in clientsList) {
        final index = clientsList.indexWhere((element) => element.id == c.id);
        final visitMaps = await _client?.rawQuery("SELECT * FROM ${SqlTable.visit_data.name} WHERE client_id = ${c.id} and company_id = ${num.tryParse(companyId)}");
        List<ZVisitModel> visitsList = visitMaps == null ? [] : visitMaps.map((e) => ZVisitModel.fromJson(e)).toList();
        if (!getVisitsOnlyFromClient) {
          final visitServiceMaps = await _client?.rawQuery("SELECT * FROM ${SqlTable.visit_service_data.name} WHERE client_id = ${c.id} and company_id = ${num.tryParse(companyId)}");
          List<ZVisitServiceModel> visitsServicesList = visitServiceMaps == null ? [] : visitServiceMaps.map((e) => ZVisitServiceModel.fromJson(e)).toList();

          final clientAddressMaps = await _client?.rawQuery("SELECT * FROM ${SqlTable.client_address.name} WHERE client_id = ${c.id} and company_id = ${num.tryParse(companyId)}");
          List<ZClientAddressModel> clientAddressList = clientAddressMaps == null ? [] : clientAddressMaps.map((e) => ZClientAddressModel.fromJson(e)).toList();

          final clientPhoneMaps = await _client?.rawQuery("SELECT * FROM ${SqlTable.client_phone.name} WHERE client_id = ${c.id} and company_id = ${num.tryParse(companyId)}");
          List<ZClientPhoneModel> clientPhoneList = clientPhoneMaps == null ? [] : clientPhoneMaps.map((e) => ZClientPhoneModel.fromJson(e)).toList();
          clientsList[index] = c.copyWith(clientAddresses: clientAddressList, visits: visitsList, services: visitsServicesList, clientPhones: clientPhoneList);
        } else {
          clientsList[index] = c.copyWith(visits: visitsList);
        }
      }
      currentCompany = currentCompany.copyWith(clients: clientsList);
    }

    return currentCompany;
  }

  Future<List<ZServiceModel>> getServiceListData() async {
    final maps = await _client?.readData(SqlTable.service_list_data);
    return maps == null ? [] : maps.map((e) => ZServiceModel.fromJson(e)).toList();
  }

  Future<List<ZTaskListModel>> getTaskListData() async {
    final maps = await _client?.readData(SqlTable.task_list_data);
    return maps == null ? [] : maps.map((e) => ZTaskListModel.fromJson(e)).toList();
  }

  Future<List<ZTaskListModel>> getAgencyListData() async {
    final maps = await _client?.readData(SqlTable.agency_list_data);
    return maps == null ? [] : maps.map((e) => ZTaskListModel.fromJson(e)).toList();
  }

  Future<void> insertCompanyData(ZCompanyModel company) async {
    await _client?.insertData(SqlTable.company_data, company.toJson());
    devlog("Inserted Company Data: ${company.toJson()}");
  }

  Future<void> insertServiceList(List<ZServiceModel> services) async {
    for (var service in services) {
      await _client?.insertData(SqlTable.service_list_data, service.toJson());
    }
    devlog("Inserted ${services.length} Service Records");
  }

  Future<void> insertTaskList(List<ZTaskListModel> tasks) async {
    for (var task in tasks) {
      await _client?.insertData(SqlTable.task_list_data, task.toJson());
    }
    devlog("Inserted ${tasks.length} Task Records");
  }

  Future<void> insertVisitList(List<ZVisitModel> visits) async {
    for (var visit in visits) {
      await _client?.insertData(SqlTable.visit_data, visit.toJson());
    }
    devlog("Inserted ${visits.length} Task Records");
  }

  Future<void> insertVisitServiceList(List<ZVisitServiceModel> visitServices) async {
    for (var visitService in visitServices) {
      await _client?.insertData(SqlTable.visit_service_data, visitService.toJson());
    }
    devlog("Inserted ${visitServices.length} Task Records");
  }

  Future<void> insertClientAddressList(List<ZClientAddressModel> addressList) async {
    for (var address in addressList) {
      await _client?.insertData(SqlTable.client_address, address.toJson());
    }
    devlog("Inserted ${addressList.length} Task Records");
  }

  Future<void> insertClientPhoneList(List<ZClientPhoneModel> phoneList) async {
    for (var phone in phoneList) {
      await _client?.insertData(SqlTable.client_phone, phone.toJson());
    }
    devlog("Inserted ${phoneList.length} Task Records");
  }

  Future<void> insertClientList(List<ZClientModel> clients) async {
    for (var client in clients) {
      await insertClientData(client);
      if (client.visits != null) await insertVisitList(client.visits ?? []);
      if (client.services != null) await insertVisitServiceList(client.services ?? []);
      if (client.clientAddresses != null) await insertClientAddressList(client.clientAddresses ?? []);
      if (client.clientPhones != null) await insertClientPhoneList(client.clientPhones ?? []);
    }
    devlog("Inserted ${clients.length} clients successfully");
  }

  Future<void> insertClientData(ZClientModel clientData) async {
    await _client?.insertData(SqlTable.client_data, clientData.toJson());
    // devlog("Inserted Client Data: ${clientData.toJson()}");
  }

  Future<void> storeFetchResponse(ZCompanyModel response) async {
    try {
      await insertCompanyData(response);

      if (response.services != null && response.services!.isNotEmpty) {
        await insertServiceList(response.services!);
      }

      if (response.taskLists != null && response.taskLists!.isNotEmpty) {
        await insertTaskList(response.taskLists!);
      }

      if (response.clients != null && response.clients!.isNotEmpty) {
        await insertClientList(response.clients!);
      }

      devlog("✅ Successfully stored all FetchResponse data");
    } catch (e) {
      devlog("❌ Error storing FetchResponse data: $e");
      throw Exception("Database transaction failed: $e");
    }
  }

  Future<void> clearDatabase() async {
    final db = await database;

    for (var table in SqlTable.values) {
      await db.delete(table.name);
    }
    await Di.sl<SharedPreferences>().remove("isFetchedDataStored");
  }
}
