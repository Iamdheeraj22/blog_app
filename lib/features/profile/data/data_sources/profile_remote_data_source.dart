import 'package:blog_app/core/exception/exceptions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class ProfileRemoteDataSource {
  Future<bool> userLogout();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final SupabaseClient client;

  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future<bool> userLogout() async {
    try {
      await client.auth.signOut().onError((error, stackTrace) {
        throw ServerException(error.toString());
      }).catchError((error) {
        throw ServerException(error.toString());
      });
      return true;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
