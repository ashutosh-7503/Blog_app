import 'dart:io';

import 'package:blog_app/core/error/failiures.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failiure, Blog>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics, 
  });
  Future<Either<Failiure,List<Blog>>> getAllBlogs();
}
