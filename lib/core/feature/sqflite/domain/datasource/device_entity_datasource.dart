import 'package:sqflite/sqflite.dart';
import 'package:starter_app_flutter/core/feature/sqflite/data/dto/entity/device_entity.dart';
import 'package:starter_app_flutter/core/feature/sqflite/domain/common/base_db_setting.dart';

class DeviceEntityDatasource {
  Database db;
  BaseDBSetting dbSetting;

  DeviceEntityDatasource({required this.db, required this.dbSetting});

  Future<void> insert(DeviceEntity entity) async {
    await db.insert(dbSetting.dbName, entity.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}