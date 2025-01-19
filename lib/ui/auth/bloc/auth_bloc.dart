import 'package:equatable/equatable.dart';
import 'package:final_project/data/repositories/auth/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(StartScreenState()) {
    on<ChangePageEvent>(_onChangePage);
    on<SignUpEvent>(_onSignup);
    on<SignInEvent>(_onSignin);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<ChangeRememberMeEvent>(_onChangeRememberMe);
  }

  void _onChangePage(ChangePageEvent event, Emitter<AuthState> emit) {
    if (event.page == Page.AUTH) {
      emit(AuthScreenState(
          status: FormStatus.IDLE,
          isRememberMe: (state is AuthScreenState)
              ? (state as AuthScreenState).isRememberMe
              : false));
    } else {
      emit(StartScreenState());
    }
  }

  void _onSignup(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthScreenState(
        status: FormStatus.LOADING,
        isRememberMe: (state is AuthScreenState)
            ? (state as AuthScreenState).isRememberMe
            : false));
    try {
      await authRepository.signUp(event.email, event.password);
      emit(AuthScreenState(
          status: FormStatus.IDLE,
          isRememberMe: (state is AuthScreenState)
              ? (state as AuthScreenState).isRememberMe
              : false));
    } catch (error) {
      emit(AuthScreenState(
          status: FormStatus.IDLE,
          isRememberMe: (state is AuthScreenState)
              ? (state as AuthScreenState).isRememberMe
              : false));
    }
  }

  void _onSignin(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthScreenState(
        status: FormStatus.LOADING,
        isRememberMe: (state is AuthScreenState)
            ? (state as AuthScreenState).isRememberMe
            : false));
    try {
      await authRepository.login(event.email, event.password);
      emit(AuthScreenState(
          status: FormStatus.IDLE,
          isRememberMe: (state is AuthScreenState)
              ? (state as AuthScreenState).isRememberMe
              : false));
    } catch (error) {
      emit(AuthScreenState(
          status: FormStatus.IDLE,
          isRememberMe: (state is AuthScreenState)
              ? (state as AuthScreenState).isRememberMe
              : false));
    }
  }

  void _onGoogleSignIn(GoogleSignInEvent event, Emitter<AuthState> emit) {
    emit(AuthScreenState(
        status: FormStatus.LOADING,
        isRememberMe: (state is AuthScreenState)
            ? (state as AuthScreenState).isRememberMe
            : false));
    try {
      authRepository.signInWithGoogle();
      emit(AuthScreenState(
          status: FormStatus.IDLE,
          isRememberMe: (state is AuthScreenState)
              ? (state as AuthScreenState).isRememberMe
              : false));
    } catch (error) {}
  }

  void _onChangeRememberMe(
      ChangeRememberMeEvent event, Emitter<AuthState> emit) {
    emit(AuthScreenState(status: FormStatus.IDLE, isRememberMe: event.val));
  }
}

enum Page { START, AUTH }

enum FormStatus { IDLE, LOADING }
