part of 'auth_bloc.dart';

@immutable
sealed class AuthState {
  const AuthState();
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthFailiure extends AuthState {
  final String message;
  const AuthFailiure(this.message);
}

final class AuthSuccess extends AuthState {
  final User user;
  const AuthSuccess(this.user);
}
