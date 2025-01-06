import 'package:blog_app/core/theme/app_pallete.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/material.dart';

class BlogDetailsPage extends StatelessWidget {
  const BlogDetailsPage({super.key, required this.blog});

  static route(Blog blog) => MaterialPageRoute(
        builder: (_) => BlogDetailsPage(
          blog: blog,
        ),
      );
  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blog.title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Scrollbar(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "By ${blog.posterName}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "${FormatDate(date: blog.updatedAt).dateBydMMMYYYY()} . ${CalculateReadingTime(text: blog.content).calculate()} min read",
                  style: TextStyle(
                    fontSize: 14,
                    color: AppPallete.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imageUrl,
                    fit: BoxFit.cover,
                    height: 300,
                    width: double.infinity,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  blog.content,
                  style: TextStyle(
                    height: 2,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
