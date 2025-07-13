import 'package:blog_app/core/common/widgets/loader.dart';
import 'package:blog_app/core/constants/constants.dart';
import 'package:blog_app/core/theme/app_pallette.dart';
import 'package:blog_app/core/utils/show_snackbar.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blog_app/features/auth/presentation/screens/login_page.dart';
import 'package:blog_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:blog_app/features/blog/presentation/pages/add_new_blog_page.dart';
import 'package:blog_app/features/blog/presentation/widgets/blog_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => BlogPage());
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  @override
  void initState() {
    super.initState();
    context.read<BlogBloc>().add(GetAllBlogsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Blogger',
          style: GoogleFonts.aladin().copyWith(fontSize: 40),
        ),
        centerTitle: false,
        actionsPadding: EdgeInsets.all(8),
        actions: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccessSignOut) {
                Navigator.pushAndRemoveUntil(
                  context,
                  LogInPage.route(),
                  (route) => false,
                );
                showSnackBar(context, Constants.userLoggedOutMessage);
              } else if (state is AuthFailiure) {
                showSnackBar(context, Constants.userLoggedOutFailiureMessage);
              }
            },
            child: TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthSignOutEvent());
              },
              child: Text('Sign Out', style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailiure) {
            showSnackBar(context, state.error);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          if (state is BlogDisplaySuccess) {
            // print(state.blogs.first.posterName);
            return ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return BlogCard(
                  blog: blog,
                  color: index % 3 == 0
                      ? AppPallete.gradient1
                      : index % 3 == 1
                      ? AppPallete.gradient2
                      : AppPallete.gradient3,
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        onPressed: () {
          Navigator.push(context, AddNewBlogPage.route());
        },
        child: Icon(CupertinoIcons.add),
      ),
    );
  }
}
// IconButton(

//         icon: Icon(CupertinoIcons.add_circled),
//       ),
