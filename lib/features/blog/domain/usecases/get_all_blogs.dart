import 'package:blog_app/core/error/failiures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/blog/domain/entities/blog.dart';
import 'package:blog_app/features/blog/domain/repository/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  const GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failiure, List<Blog>>> call(NoParams params) async {
    return await blogRepository.getAllBlogs();
  }
}
