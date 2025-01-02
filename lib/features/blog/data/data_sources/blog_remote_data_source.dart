import 'dart:io';

import 'package:blog_app/core/exception/exceptions.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uploadBlog(BlogModel model);

  Future<String> uploadImage({required File path, required BlogModel model});

  Future<List<BlogModel>> getBlogs();
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient client;

  BlogRemoteDataSourceImpl(this.client);

  @override
  Future<BlogModel> uploadBlog(BlogModel model) async {
    try {
      final response = await client
          .from('blogs')
          .insert(
            model.toJson(),
          )
          .select();

      return BlogModel.fromJson(response.first);
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadImage({
    required File path,
    required BlogModel model,
  }) async {
    try {
      // Step 1: Upload the file
      await client.storage.from('blog_images').upload(
            model.id,
            File(path.path),
          );

      // Step 2: Generate a signed URL with expiry
      final signedUrlResponse =
          await client.storage.from('blog_images').createSignedUrl(
                model.id,
                3000,
              );

      return signedUrlResponse;
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getBlogs() async {
    try {
      final response = await client.from('blogs').select('*, profiles (name)');
      return response
          .map(
            (e) => BlogModel.fromJson(e).copyWith(
              posterName: e['profiles']['name'],
            ),
          )
          .toList();
    } on PostgrestException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
