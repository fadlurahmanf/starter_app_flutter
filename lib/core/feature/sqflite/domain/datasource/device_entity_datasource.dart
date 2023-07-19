import 'package:sqflite/sqflite.dart';
import 'package:starter_app_flutter/core/feature/sqflite/data/dto/entity/device_entity.dart';

class DeviceEntityDatasource {
  Database db;

  DeviceEntityDatasource({required this.db});

  static const table = DeviceEntity.table;
  static const cDeviceId = DeviceEntity.cDeviceId;

  Future<void> insert(DeviceEntity entity) async {
    await db.insert(table, entity.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> update(DeviceEntity entity) async {
    await db.update(table, entity.toJson(),
        where: '$cDeviceId = ?', whereArgs: [entity.deviceId], conflictAlgorithm: ConflictAlgorithm.ignore);
  }

  Future<DeviceEntity?> findById({required String deviceId}) async {
    List<Map> maps = await db.query(table, where: '$cDeviceId = ?', whereArgs: [deviceId]);
    if (maps.isNotEmpty) {
      return DeviceEntity.fromJson(maps.first as Map<String, dynamic>? ?? {});
    } else {
      return null;
    }
  }

  Future<List<DeviceEntity>> findAll() async {
    List<Map> maps = await db.query(table);
    return maps.map((e) => DeviceEntity.fromJson(e as Map<String, dynamic>? ?? {})).toList();
  }
}
