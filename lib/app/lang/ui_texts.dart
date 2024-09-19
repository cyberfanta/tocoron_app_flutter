import 'package:flutter/material.dart';
import 'package:tocoron_app_flutter/app/lang/ui_text_en.dart';
import 'package:tocoron_app_flutter/app/lang/ui_text_es.dart';

class UiTexts extends ChangeNotifier {
  UiTexts(this._locale);

  Locale _locale;

  set locale(Locale locale) {
    _locale = locale;
    notifyListeners();
  }

  String get title {
    if (_locale.languageCode == 'es') {
      return UiTextEs().title;
    }

    return UiTextEn().title;
  }

  String get warning {
    if (_locale.languageCode == 'es') {
      return UiTextEs().warning;
    }

    return UiTextEn().warning;
  }

  String get closeAppContext {
    if (_locale.languageCode == 'es') {
      return UiTextEs().closeAppContext;
    }

    return UiTextEn().closeAppContext;
  }

  String get yes {
    if (_locale.languageCode == 'es') {
      return UiTextEs().yes;
    }

    return UiTextEn().yes;
  }

  String get no {
    if (_locale.languageCode == 'es') {
      return UiTextEs().no;
    }

    return UiTextEn().no;
  }
}
