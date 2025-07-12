part of 'blog_bloc.dart';

@immutable
sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogFailiure extends BlogState {
  final String error;
  BlogFailiure(this.error);
}

final class BlogSuccess extends BlogState {}

final class BlogDisplaySuccess extends BlogState {
  final List<Blog> blogs;
  BlogDisplaySuccess(this.blogs);
}

final class BlogLoading extends BlogState {}
