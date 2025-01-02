import 'dart:io';

import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/data/model/blog_model.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/usercases/get_blogs.dart';
import 'package:blog_app/features/blog/domain/usercases/upload_blog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'blog_event.dart';

part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog _uploadBlog;
  final GetBlogs _getBlogs;

  BlogBloc({
    required UploadBlog uploadBlog,
    required GetBlogs getBlogs,
  })  : _uploadBlog = uploadBlog,
        _getBlogs = getBlogs,
        super(BlogInitial()) {
    on<BlogEvent>(
      (event, emit) => emit(
        BlogLoading(),
      ),
    );
    on<BlogUpload>(_onBlogUpload);
    on<BlogGet>(_onBlogGet);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final result = await _uploadBlog(UploadParams(
      image: event.image,
      title: event.title,
      description: event.description,
      posterId: event.posterId,
      topics: event.topics,
    ));

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blog) => emit(BlogSuccess()),
    );
  }

  void _onBlogGet(BlogGet event, Emitter<BlogState> emit) async {
    final result = await _getBlogs(NoParams());

    result.fold(
      (failure) => emit(BlogFailure(failure.message)),
      (blogs) => emit(BlogFetchingSuccess(blogs: blogs)),
    );
  }
}
