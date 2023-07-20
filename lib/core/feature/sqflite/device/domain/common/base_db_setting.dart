import 'package:starter_app_flutter/core/domain/common/base_description.dart';

abstract class BaseDBSetting extends Description {
  final String dbName;
  final int version;

  const BaseDBSetting({
    required this.dbName,
    required this.version,
    String? linkFigma,
    String? description,
  }) : super(linkFigma: linkFigma, description: description);
}