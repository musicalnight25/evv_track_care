import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBConsts {
  DBConsts._();

  static const dbName = "app_database.db";
}

enum SqlTable {
  visit_data,
  task_list_data,
  service_list_data,
  agency_list_data,
  company_data,
  client_data,
  visit_service_data,
  client_address,
  client_phone,
  ;
}

typedef OnCreateCallback = FutureOr<void> Function(Database, int)?;

class SqfliteClient {
  Database? _appDb;

  Future<Database?> initialize({OnCreateCallback onCreate}) async {
    _appDb = await _openDatabase(DBConsts.dbName, onCreate: onCreate);
    return _appDb;
  }

  Future<Database> _openDatabase(String dbName, {OnCreateCallback onCreate}) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    return await openDatabase(path, onCreate: onCreate, version: 1);
  }

  /// Method to read data using the query method
  ///
  Future<List<Map<String, dynamic>>> readData(SqlTable table) async {
    return await _appDb!.query(table.name);
  }

  /// Method to read data using a raw SQL query
  ///
  Future<List<Map<String, dynamic>>> rawQuery(String sql) async {
    return await _appDb!.rawQuery(sql);
  }

  /// Method to read data with where clause, order by, and limit
  ///
  Future<List<Map<String, dynamic>>> readDataWithFilters({
    required SqlTable table,
    String? whereClause,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    return await _appDb!.query(
      table.name,
      where: whereClause,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
  }

  /// Method to read data with where clause, order by, and limit using raw SQL
  ///
  Future<List<Map<String, dynamic>>> rawReadDataWithFilters({
    required SqlTable table,
    String? whereClause,
    String? orderBy,
    int? limit,
  }) async {
    String sql = 'SELECT * FROM ${table.name}';
    if (whereClause != null) {
      sql += ' WHERE $whereClause';
    }
    if (orderBy != null) {
      sql += ' ORDER BY $orderBy';
    }
    if (limit != null) {
      sql += ' LIMIT $limit';
    }
    return await _appDb!.rawQuery(sql) ?? [];
  }

  /// Method to insert data into a table
  ///
  Future<int> insertData(SqlTable table, Map<String, dynamic> values) async {
    return await _appDb!.insert(table.name, values);
  }

  /// Method to update data in a table
  ///
  Future<int> updateData(
    SqlTable table,
    Map<String, dynamic> values,
    List<dynamic>? whereArgs, {
    String? whereClause,
  }) async {
    return await _appDb!.update(
      table.name,
      values,
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  /// Method to delete data from a table
  ///
  Future<int> deleteData(SqlTable table, String whereClause, List<dynamic> whereArgs) async {
    return await _appDb!.delete(
      table.name,
      where: whereClause,
      whereArgs: whereArgs,
    );
  }

  Future<void> close() async {
    await _appDb?.close();
  }

//
// Future<List<Map<String, dynamic>>> readData(SqlTable table) async {
//   return await _appDb!.query(table.name);
// }
//
// Future<int> insertData(SqlTable table, Map<String, dynamic> values) async {
//   return await _appDb!.insert(table.name, values);
// }
//
// Future<int> updateData(SqlTable table, Map<String, dynamic> values, String whereClause, List<dynamic> whereArgs) async {
//   return await _appDb!.update(table.name, values, where: whereClause, whereArgs: whereArgs);
// }
//
// Future<int> deleteData(SqlTable table, String whereClause, List<dynamic> whereArgs) async {
//   return await _appDb!.delete(table.name, where: whereClause, whereArgs: whereArgs);
// }
//
// Future<void> close() async {
//   await _appDb?.close();
// }
}
