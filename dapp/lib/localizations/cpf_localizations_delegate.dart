import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'cpf_localizations.dart';

class CpfLocalizationsDelegate extends LocalizationsDelegate<CpfLocalizations> {
  const CpfLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      CpfLocalizations.languages().contains(locale.languageCode);

  @override
  Future<CpfLocalizations> load(Locale locale) {
    return SynchronousFuture<CpfLocalizations>(CpfLocalizations(locale));
  }

  @override
  bool shouldReload(CpfLocalizationsDelegate old) => false;
}
