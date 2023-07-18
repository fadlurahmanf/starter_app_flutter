import 'package:get/get.dart';
import 'package:starter_app_flutter/core/feature/translation/translation_constant.dart';

class TranslationMessage extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en': {
      TranslationConstant.OOPS: 'Oops...'
    },
    'id': {
      TranslationConstant.OOPS: 'Ups...'
    }
  };

}