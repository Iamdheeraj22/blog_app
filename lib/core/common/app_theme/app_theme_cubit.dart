import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(AppThemeState());
  final box = Hive.box(name: 'user');

  void updateTheme(int themeIndex) {
    box.put('themeIndex', themeIndex);
    emit(AppThemeState(themeIndex: themeIndex));
  }

  Future<void> fetchTheme() async {
    final themeIndex = await box.get('themeIndex', defaultValue: 0);
    emit(AppThemeState(themeIndex: themeIndex));
  }
}
