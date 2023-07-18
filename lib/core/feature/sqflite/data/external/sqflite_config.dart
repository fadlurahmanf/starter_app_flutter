import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:starter_app_flutter/core/feature/sqflite/domain/common/base_db_setting.dart';

class DeviceDB extends BaseDBSetting {
  const DeviceDB() : super(dbName: 'device.db', version: 1, linkFigma: null, description: 'Database umum');
}

abstract class BaseDBHelper {
  String? dbPath;

  Future<String> getDBPath();

  Database? db;

  Future<Database> getDB();

  Future<void> init();

  Future<void> close();
}

class DeviceDBHelper implements BaseDBHelper {
  BaseDBSetting dbModel;

  DeviceDBHelper({required this.dbModel});

  @override
  String? dbPath;

  @override
  Future<String> getDBPath() async {
    if (dbPath == null) {
      dbPath = '${await getDatabasesPath()}/${dbModel.dbName}';
      return dbPath!;
    } else {
      return dbPath!;
    }
  }

  @override
  Future<void> init() async {
    await getDBPath();
  }

  @override
  Database? db;

  @override
  Future<Database> getDB() async {
    if (db == null) {
      db = await openDatabase(await getDBPath(),
          version: dbModel.version, onCreate: (db, version) => onCreate(db.batch()));
      return db!;
    } else {
      return db!;
    }
  }

  FutureOr<void> onCreate(Batch batch) async {
    print("MASUK ON CREATE DB");
    batch.execute('''CREATE TABLE Device ( deviceId TEXT PRIMARY KEY, createdAt TEXT)''');
    await batch.commit();
  }

  @override
  Future<void> close() async {
    final db = await getDB();
    await db.close();
  }
}
