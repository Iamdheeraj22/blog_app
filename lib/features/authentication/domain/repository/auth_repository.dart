import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/features/authentication/data/models/user_model.dart';

import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failures, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failures, User>> loginWithEmailPassword({
    required String email,
    required String password,
  });

  Future<Either<Failures, User>> currentUser();
}
