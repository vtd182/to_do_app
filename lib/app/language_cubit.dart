import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(const LanguageState(Locale('en')));

  void changeLanguage(Locale locale) {
    emit(LanguageState(locale));
  }
}
