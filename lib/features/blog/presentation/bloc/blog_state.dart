part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String message;

  BlogFailure(this.message);
}

final class BlogSuccess extends BlogState {}

final class BlogFetchingSuccess extends BlogState {
  final List<Blog> blogs;

  BlogFetchingSuccess({required this.blogs});
}
