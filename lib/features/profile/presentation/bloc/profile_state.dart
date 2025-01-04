part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLogout extends ProfileState {}

final class ProfileLogoutFailure extends ProfileState {
  final String message;

  ProfileLogoutFailure({
    required this.message,
  });
}

final class ProfileLogoutSuccess extends ProfileState {}
