import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/exception/exceptions.dart';
import 'package:blog_app/core/utils/internet_connection_checker.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_local_data_source.dart';
import 'package:blog_app/features/blog/data/data_sources/blog_remote_data_source.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource remoteDataSource;
  final BlogLocalDataSource localDataSource;
  final InternetConnectionChecker internetConnectionChecker;

  BlogRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.internetConnectionChecker,
  });

  @override
  Future<Either<Failures, Blog>> uploadBlog({
    required File image,
    required String title,
    required String description,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      if (!await internetConnectionChecker.isConnected) {
        return left(Failures('No internet connection'));
      }
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: description,
        imageUrl: '',
        updatedAt: DateTime.now(),
        topics: topics,
      );
      final imageUrl = await remoteDataSource.uploadImage(
        path: image,
        model: blogModel,
      );

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await remoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }

  @override
  Future<Either<Failures, List<Blog>>> getBlogs() async {
    try {
      if (!await internetConnectionChecker.isConnected) {
        final blogs = localDataSource.getLocalBlogs();
        return right(blogs);
      }
      final blogs = await remoteDataSource.getBlogs();
      localDataSource.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failures(e.toString()));
    }
  }
}
