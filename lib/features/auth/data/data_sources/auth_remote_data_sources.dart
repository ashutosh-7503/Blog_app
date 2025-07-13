import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//interface class
abstract interface class AuthRemoteDataSources {
  Session? get currentUserSession;

  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });

  Future<UserModel?> getUserDetails();

  Future<void> signOut();
}

//supabase authentication implementation
class AuthRemoteDataSourcesImpl implements AuthRemoteDataSources {
  final SupabaseClient supabaseClient;
  AuthRemoteDataSourcesImpl(this.supabaseClient);

  @override
  Session? get currentUserSession => supabaseClient.auth.currentSession;

  @override
  Future<UserModel> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // print('authorizing');
      final res = await supabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );
      // print('authorized');
      if (res.user == null) {
        throw const ServerException('User is null.');
      }
      // print(res.user!.id);
      return UserModel.fromJson(
        res.user!.toJson(),
      ).copyWith(email: currentUserSession!.user.email);
    } on AuthApiException catch (e) {
      throw ServerException(e.message);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // print('prepare user sign  up');
      final res = await supabaseClient.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );
      // print('user signed up');
      if (res.user == null) {
        throw const ServerException('User is null!');
      }
      // print(res.user!.id);
      return UserModel.fromJson(
        res.user!.toJson(),
      ).copyWith(email: currentUserSession!.user.email);
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } on Exception catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<UserModel?> getUserDetails() async {
    try {
      if (currentUserSession != null) {
        final userData = await supabaseClient
            .from('profiles')
            .select()
            .eq('id', currentUserSession!.user.id);
        return UserModel.fromJson(
          userData.first,
        ).copyWith(email: currentUserSession!.user.email);
      }
      return null;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await supabaseClient.auth.signOut();
    } on AuthException catch (e) {
      throw ServerException(e.message);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
