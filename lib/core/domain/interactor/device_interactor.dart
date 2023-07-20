import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:starter_app_flutter/core/feature/exception/app_exception.dart';
import 'package:starter_app_flutter/core/feature/sqflite/device/data/dto/entity/device_entity.dart';
import 'package:starter_app_flutter/core/feature/sqflite/device/domain/datasource/device_entity_datasource.dart';

class DeviceInteractor {
  DeviceEntityDatasource deviceEntityDatasource;
  DeviceInfoPlugin deviceInfo;

  DeviceInteractor({
    required this.deviceEntityDatasource,
    required this.deviceInfo,
  });

  Future<String> getDeviceId() async {
    String? id;
    if (Platform.isAndroid) {
      id = (await deviceInfo.androidInfo).id;
    } else if (Platform.isIOS) {
      id = (await deviceInfo.iosInfo).identifierForVendor;
    }
    if (id == null) {
      throw AppException(message: 'REQUIRED DEVICE ID');
    }
    return id;
  }

  Future<void> insertOrUpdateDeviceIdIfExist() async {
    String id = await getDeviceId();
    final entity = await deviceEntityDatasource.findById(deviceId: id);
    if (entity == null) {
      await deviceEntityDatasource.insert(DeviceEntity(deviceId: id));
    } else {
      await deviceEntityDatasource.update(DeviceEntity(deviceId: id, createdAt: DateTime.now().toString()));
    }
  }

  Future<void> updateLanguageCode(String languageCode) async {
    String id = await getDeviceId();
    final entity = await deviceEntityDatasource.findById(deviceId: id);
    if (entity != null) {
      await deviceEntityDatasource.update(DeviceEntity(deviceId: id, languageCode: languageCode));
      return;
    } else {
      throw AppException(message: 'DEVICE ENTITY NOT FOUND');
    }
  }

  Future<List<DeviceEntity>> getAll() {
    return deviceEntityDatasource.findAll();
  }

  Future<DeviceEntity> getDeviceEntity() async {
    final list = await getAll();
    if (list.isNotEmpty) {
      return list.first;
    } else {
      throw AppException(message: 'DEVICE ENTITY NOT FOUND');
    }
  }
}
