import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/profile/domain/usercase/user_logout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserLogout _userLogout;

  ProfileBloc({required UserLogout userLogout})
      : _userLogout = userLogout,
        super(ProfileInitial()) {
    on<UserProfileLogout>(_onUserLogout);
  }

  void _onUserLogout(
      UserProfileLogout event, Emitter<ProfileState> emit) async {
    emit(ProfileLogout());
    final result = await _userLogout(NoParams());
    result.fold(
      (failure) => emit(ProfileLogoutFailure(message: failure.message)),
      (result) {
        if (result) {
          Box box = Hive.box(name: 'blogs');
          box.clear();
          emit(ProfileLogoutSuccess());
        }
      },
    );
  }
}
