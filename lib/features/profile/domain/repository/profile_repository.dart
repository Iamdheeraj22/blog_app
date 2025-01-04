import 'package:blog_app/core/error/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class ProfileRepository {
  Future<Either<Failures, bool>> userLogout();
}
