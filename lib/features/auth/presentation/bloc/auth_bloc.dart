import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/core/common/entities/user.dart';
import 'package:blog_app/features/auth/domain/usecases/current_user.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_out.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignUp _userSignUp;
  final UserSignIn _userSignIn;
  final CurrentUser _currentUser;
  final AppUserCubit _appUserCubit;
  final UserSignOut _userSignOut;
  AuthBloc({
    required UserSignUp userSignUp,
    required UserSignIn userSignIn,
    required UserSignOut userSignout,
    required CurrentUser currentUser,
    required AppUserCubit appUserCubit,
  }) : _userSignUp = userSignUp,
       _userSignIn = userSignIn,
       _currentUser = currentUser,
       _appUserCubit = appUserCubit,
       _userSignOut = userSignout,
       super(AuthInitial()) {
    on<AuthEvent>((_, emit) => emit(AuthLoading()));

    on<AuthSignUp>(_onAuthSignUp);

    on<AuthSignIn>(_onAuthSignIn);

    on<AuthSignOutEvent>(_onAuthSignOut);

    on<IsAuthUserLoggedIn>(_checkUserLoggedIn);
  }
  void _onAuthSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    final res = await _userSignUp(
      UserSignUpParams(
        email: event.email,
        password: event.password,
        name: event.name,
      ),
    );
    res.fold(
      (failiure) => emit(AuthFailiure(failiure.error)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignIn(AuthSignIn event, Emitter<AuthState> emit) async {
    final res = await _userSignIn(
      UserSignInParams(email: event.email, password: event.password),
    );
    res.fold(
      (failiure) => emit(AuthFailiure(failiure.error)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _onAuthSignOut(AuthSignOutEvent event, Emitter<AuthState> emit) async{
    final res=await _userSignOut(NoParams());
    res.fold(
      (failiure) => emit(AuthFailiure(failiure.error)),
      (r) => emit(AuthSuccessSignOut(r))
    );
  }

  void _checkUserLoggedIn(
    IsAuthUserLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    final res = await _currentUser(NoParams());
    res.fold(
      (failiure) => emit(AuthFailiure(failiure.error)),
      (user) => _emitAuthSuccess(user, emit),
    );
  }

  void _emitAuthSuccess(User user, Emitter<AuthState> emit) {
    _appUserCubit.updateUser(user);
    emit(AuthSuccess(user));
  }
}
