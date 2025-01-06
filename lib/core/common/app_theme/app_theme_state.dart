part of 'app_theme_cubit.dart';

@immutable
sealed class AppThemeState {}

final class AppThemeInitial extends AppThemeState {}

final class AppThemeChange extends AppThemeState {
  final int themeIndex;

  AppThemeChange({
    required this.themeIndex,
  });
}
