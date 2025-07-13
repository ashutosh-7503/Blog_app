// import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:blog_app/core/utils/calculate_reading_time.dart';
import 'package:blog_app/core/utils/format_date.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogViewPage extends StatelessWidget {
  final Blog blog;

  static route(Blog blog) =>
      CupertinoPageRoute(builder: (context) => BlogViewPage(blog: blog));

  const BlogViewPage({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    // print(blog.posterName);
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: AppPallete.backgroundColor,
      ),
      body: Scrollbar(
        interactive: true,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Text(
                  'By ${blog.posterName}',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '${formatDatebyddMMYYYY(blog.updatedAt)}   ${calculateReadingTime(blog.content)} min',
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    blog.imageUrl,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return SizedBox(
                        height: 200,
                        width: double.infinity,
                        child: Center(child: const Loader()),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  blog.content,
                  style: const TextStyle(fontSize: 16, height: 1.8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
