import 'dart:async';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:either_dart/either.dart';
import 'package:starter_app_flutter/core/external/extension/object.dart';
import 'package:starter_app_flutter/core/feature/exception/custom_exception.dart';
import 'package:starter_app_flutter/core/feature/sqflite/data/dto/entity/device_entity.dart';
import 'package:starter_app_flutter/core/feature/sqflite/domain/datasource/device_entity_datasource.dart';
import 'package:starter_app_flutter/feature/sqflite/presentation/bloc/sqflite_bloc.dart';

class DeviceInteractor {
  DeviceEntityDatasource deviceEntityDatasource;
  DeviceInfoPlugin deviceInfo;

  DeviceInteractor({
    required this.deviceEntityDatasource,
    required this.deviceInfo,
  });

  Future<Either<CustomException, SqfliteState>> insertOrUpdateDeviceIdIfExist() async {
    try {
      String? id;
      if (Platform.isAndroid) {
        id = (await deviceInfo.androidInfo).id;
      } else if (Platform.isIOS) {
        id = (await deviceInfo.iosInfo).identifierForVendor;
      }
      if (id == null) {
        throw CustomException(message: 'REQUIRED DEVICE ID');
      }
      final entity = await deviceEntityDatasource.findById(deviceId: id);
      if (entity == null) {
        await deviceEntityDatasource.insert(DeviceEntity(deviceId: id));
      } else {
        await deviceEntityDatasource.update(DeviceEntity(deviceId: id));
      }
      return const Right(SqfliteState.iSuccess());
    } catch (e) {
      return Left(e.toCustomException());
    }
  }

  Future<Either<CustomException, SqfliteState>> getAll() async {
    try {
      return Right(SqfliteState.gSuccess(devices: await deviceEntityDatasource.findAll()));
    } catch (e) {
      return Left(e.toCustomException());
    }
  }
}
