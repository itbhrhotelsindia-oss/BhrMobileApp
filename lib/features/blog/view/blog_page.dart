import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bhrhotel/core/api_client.dart';
import '../bloc/blog_bloc.dart';
import '../bloc/blog_event.dart';
import '../bloc/blog_state.dart';
import '../repository/blog_repository.dart';
import '../widgets/blog_hero_section.dart';
import '../widgets/blog_sidebar_section.dart';
import '../widgets/blog_grid_section.dart';
import 'package:bhrhotel/core/theme/app_colors.dart';
import 'package:bhrhotel/app/app_shell.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlogBloc(
        BlogRepository(ApiClient("https://hotel-backend-nq72.onrender.com")),
      )..add(LoadBlog()),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: AppColors.darkGold1,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Blogs",
            style: TextStyle(
              fontSize: 22,
              color: AppColors.darkGold1,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: BlocBuilder<BlogBloc, BlogState>(
          builder: (context, state) {
            if (state is BlogLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BlogError) {
              return Center(child: Text(state.message));
            }

            final blog = (state as BlogLoaded).blog;

            return SingleChildScrollView(
              child: Column(
                children: [
                  BlogHeroSection(blog: blog),
                  BlogGridSection(section: blog.blogListSection),
                  BlogSidebarSection(section: blog.popularPostListSection),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
