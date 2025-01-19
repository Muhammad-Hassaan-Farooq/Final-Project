part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartScreenState extends AuthState {}

class AuthScreenState extends AuthState {
  final FormStatus status;
  final bool isRememberMe;

  AuthScreenState({required this.status, required this.isRememberMe});

  @override
  List<Object?> get props => [status, isRememberMe];
}
