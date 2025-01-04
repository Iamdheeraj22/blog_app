import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/exception/exceptions.dart';
import 'package:blog_app/core/utils/internet_connection_checker.dart';
import 'package:blog_app/features/profile/data/data_sources/profile_remote_data_source.dart';
import 'package:blog_app/features/profile/domain/repository/profile_repository.dart';
import 'package:fpdart/src/either.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  InternetConnectionChecker internetCheck;
  ProfileRemoteDataSource dataSource;

  ProfileRepositoryImpl({
    required this.dataSource,
    required this.internetCheck,
  });

  @override
  Future<Either<Failures, bool>> userLogout() async {
    try {
      if (await internetCheck.isConnected) {
        final response = await dataSource.userLogout();
        return right(response);
      }
      return left(Failures('No internet connection'));
    } on ServerException catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
