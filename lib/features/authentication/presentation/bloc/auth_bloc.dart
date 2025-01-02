import 'package:blog_app/core/common/app_user/app_user_cubit.dart';
import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/authentication/domain/usercases/current_user.dart';
import 'package:blog_app/features/authentication/domain/usercases/user_sign_in.dart';
import 'package:blog_app/features/authentication/domain/usercases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;

  final AppUserCubit _appUserCubit;

  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  })  : _userSignUp = userSignUp,
        _userSignIn = userSignIn,
        _currentUser = currentUser,
        _appUserCubit = appUserCubit,
        super(AuthInitial()) {
    //Note: This is a way to handle the AuthLoading event using the on method

    // on<AuthEvent>(
    //   (event, emitter) => AuthLoading(),
    // );
    on<AuthSignup>(
      (event, emitter) async {
        emit(AuthLoading());
        final response = await _userSignUp(
          UserSignUpParams(
              email: event.email, password: event.password, name: event.name),
        );

        response.fold(
          (l) => emit(AuthFailure(message: l.message)),
          (user) => _emitAuthSuccess(user, emitter),
        );
      },
    );
    on<AuthSignIn>(
      (event, emitter) async {
        emit(AuthLoading());
        final response = await _userSignIn(
          UserSignInParams(
            email: event.email,
            password: event.password,
          ),
        );

        response.fold(
          (l) => emit(AuthFailure(message: l.message)),
          (user) => _emitAuthSuccess(user, emitter),
        );
      },
    );
    on<AuthIsUserLoggedIn>(
      (event, emitter) async {
        final response = await _currentUser(NoParams());

        response.fold(
          (l) => emit(AuthFailure(message: l.message)),
          (user) => _emitAuthSuccess(user, emitter),
        );
      },
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> _emit) {
    _appUserCubit.updateUser(user);
    _emit(AuthSuccess(user: user));
  }
}
