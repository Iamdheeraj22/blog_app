import 'dart:io';

import 'package:blog_app/core/error/failures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class UploadBlog implements UseCase<Blog, UploadParams> {
  final BlogRepository repository;

  UploadBlog({required this.repository});

  @override
  Future<Either<Failures, Blog>> call(UploadParams params) async {
    return await repository.uploadBlog(
      image: params.image,
      title: params.title,
      description: params.description,
      posterId: params.posterId,
      topics: params.topics,
    );
  }
}

class UploadParams {
  final File image;
  final String title;
  final String description;
  final String posterId;
  final List<String> topics;

  UploadParams({
    required this.image,
    required this.title,
    required this.description,
    required this.posterId,
    required this.topics,
  });
}
