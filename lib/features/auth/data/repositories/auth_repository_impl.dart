import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failiures.dart';
import 'package:blog_app/core/network/internet_connection_checker.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_data_sources.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:fpdart/fpdart.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSources remoteDataSources;
  final InternetConnectionChecker internetConnectionChecker;
  const AuthRepositoryImpl(
    this.remoteDataSources,
    this.internetConnectionChecker,
  );

  @override
  Future<Either<Failiure, User>> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    return _getUser(() async {
      return await remoteDataSources.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    });
  }

  @override
  Future<Either<Failiure, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    return _getUser(() async {
      return await remoteDataSources.signUpWithEmailAndPassword(
        name: name,
        email: email,
        password: password,
      );
    });
  }

  Future<Either<Failiure, User>> _getUser(Future<User> Function() fn) async {
    try {
      if (!await internetConnectionChecker.isConnected) {
        return left(Failiure('No Internet Connection'));
      }
      final user = await fn();
      return right(user);
    } on ServerException catch (e) {
      return left(Failiure(e.message));
    }
  }

  @override
  Future<Either<Failiure, User>> currentUser() async {
    try {
      if (!await internetConnectionChecker.isConnected) {
        final session = remoteDataSources.currentUserSession;
        if (session == null) {
          return left(Failiure('No user found'));
        }
        return right(
          UserModel(
            id: session.user.id,
            email: session.user.email ?? '',
            name: '',
          ),
        );
      }
      final user = await remoteDataSources.getUserDetails();
      if (user == null) {
        return left(Failiure('user not logged in'));
      }
      return right(user);
    } on ServerException catch (e) {
      return left(Failiure(e.toString()));
    }
  }
}
