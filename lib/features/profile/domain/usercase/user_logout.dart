import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repository.dart';
import 'package:fpdart/src/either.dart';

class UserLogout implements UseCase<bool, NoParams> {
  final ProfileRepository profileRepository;

  UserLogout(this.profileRepository);

  @override
  Future<Either<Failures, bool>> call(NoParams params) async {
    return await profileRepository.userLogout();
  }
}
