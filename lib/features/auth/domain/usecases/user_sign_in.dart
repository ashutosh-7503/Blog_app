// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:blog_app/core/error/failiures.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class UserSignIn implements Usecase<User, UserSignInParams> {
  
  final AuthRepository authRepository;

  const UserSignIn(this.authRepository);

  @override
  Future<Either<Failiure, User>> call(UserSignInParams params) async {
    return await authRepository.signInWithEmailPassword(
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignInParams {
  String email;
  String password;
  UserSignInParams({required this.email, required this.password});
}
