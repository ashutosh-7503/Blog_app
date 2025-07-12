import 'package:blog_app/core/error/failiures.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class AuthRepository {
  Future<Either<Failiure, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });
  Future<Either<Failiure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  });
  Future<Either<Failiure, User>> currentUser();
}
