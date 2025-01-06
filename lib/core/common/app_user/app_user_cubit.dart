import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/core/storage/app_user_local_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_user_state.dart';

class AppUserCubit extends Cubit<AppUserState> {
  AppUserCubit() : super(AppUserInitial());

  void updateUser(User? user) {
    final AppUserLocalStorage appUserLocalStorage = AppUserLocalStorage();
    if (user != null) {
      appUserLocalStorage.saveUserDetails(user: user);
      appUserLocalStorage.saveUserLoggedIn(true);
      emit(AppUserLoggedIn(user: user));
    } else {
      appUserLocalStorage.saveUserLoggedIn(false);
      emit(AppUserInitial());
    }
  }
}
