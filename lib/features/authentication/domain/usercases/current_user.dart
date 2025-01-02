import 'package:blog_app/core/common/entity/user.dart';
import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';

import 'package:blog_app/features/authentication/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class CurrentUser implements UseCase<User, NoParams> {
  final AuthRepository repository;

  CurrentUser({required this.repository});

  @override
  Future<Either<Failures, User>> call(NoParams params) async {
    return await repository.currentUser();
  }
}
