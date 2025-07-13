import 'package:blog_app/core/error/failiures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignOut implements Usecase<String, NoParams> {
  final AuthRepository authRepository;

  UserSignOut(this.authRepository);

  @override
  Future<Either<Failiure, String>> call(NoParams params)async {
    return await authRepository.signOutUser();
  }
}
