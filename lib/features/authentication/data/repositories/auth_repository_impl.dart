import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/exception/exceptions.dart';
import 'package:blog_app/core/utils/internet_connection_checker.dart';
import 'package:blog_app/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:blog_app/features/authentication/data/models/user_model.dart';

import 'package:blog_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as SupabaseException;

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource dataSource;

  AuthRepositoryImpl({
    required this.dataSource,
    required this.internetCheck,
  });

  InternetConnectionChecker internetCheck;

  @override
  Future<Either<Failures, User>> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUserDetails(
      () async => await dataSource.login(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    if (await internetCheck.isConnected) {
      return _getUserDetails(
          () async => await dataSource.signUpWithEmailPassword(
                email: email,
                password: password,
                name: name,
              ));
    }
    return left(Failures('No internet connection'));
  }

  Future<Either<Failures, User>> _getUserDetails(
      Future<User> Function() fn) async {
    try {
      if (await internetCheck.isConnected) {
        final user = await fn();
        return right(user);
      }
      return left(Failures('No internet connection'));
    } on ServerException catch (e) {
      return left(
        Failures(e.message),
      );
    } on SupabaseException.AuthException catch (e) {
      return left(
        Failures(e.message),
      );
    }
  }

  @override
  Future<Either<Failures, User>> currentUser() async {
    try {
      if (await internetCheck.isConnected) {
        final user = await dataSource.getCurrentUserData();
        if (user == null) {
          return left(Failures('User not logged in'));
        }
        return right(user);
      }
      if (dataSource.session == null) {
        return left(Failures('User not logged in'));
      }
      return right(UserModel(
        id: dataSource.session!.user.id,
        email: dataSource.session!.user.email ?? '',
        name: '',
      ));
    } on ServerException catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
