import 'package:flutter_bloc/flutter_bloc.dart';
import 'blog_event.dart';
import 'blog_state.dart';
import '../repository/blog_repository.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository repository;

  BlogBloc(this.repository) : super(BlogLoading()) {
    on<LoadBlog>((event, emit) async {
      try {
        final blog = await repository.loadBlogs();
        emit(BlogLoaded(blog));
      } catch (e) {
        emit(BlogError(e.toString()));
      }
    });
  }
}
