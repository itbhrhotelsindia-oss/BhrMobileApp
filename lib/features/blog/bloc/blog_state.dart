import '../model/blog_model.dart';

abstract class BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final BlogModel blog;
  BlogLoaded(this.blog);
}

class BlogError extends BlogState {
  final String message;
  BlogError(this.message);
}
