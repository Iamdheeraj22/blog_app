import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/features/blog/domain/usercases/get_blogs.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/pages/blog_details_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  static route() => MaterialPageRoute(
        builder: (_) => BlogPage(),
      );

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<BlogBloc>().add(BlogGet());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blog App',
          style: TextStyle(
              color: AppPallete.whiteColor,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.add_circled,
            ),
            onPressed: () {
              Navigator.of(context).push(
                AddNewBlogPage.route(),
              );
            },
          )
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              if (state is BlogLoading)
                Container(
                  margin: EdgeInsets.only(top: 20),
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                ),
              if (state is BlogFetchingSuccess)
                ListView.builder(
                  itemCount: state.blogs.length,
                  itemBuilder: (context, idx) {
                    final blog = state.blogs[idx];
                    return BlogCard(
                      blog: blog,
                      color: idx % 2 == 0
                          ? AppPallete.gradient1
                          : AppPallete.gradient2,
                      onTap: () {
                        Navigator.of(context).push(
                          BlogDetailsPage.route(blog),
                        );
                      },
                    );
                  },
                )
            ],
          );
        },
      ),
    );
  }
}
