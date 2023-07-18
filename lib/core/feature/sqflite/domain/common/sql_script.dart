import 'package:starter_app_flutter/core/domain/common/description.dart';

class SQLScript extends Description {
  final String script;

  SQLScript({
    required this.script,
    String? linkFigma,
    String? description,
  }) : super(linkFigma: linkFigma, description: description);
}