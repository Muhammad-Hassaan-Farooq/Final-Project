part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class ChangePageEvent extends AuthEvent {
  final Page page;

  const ChangePageEvent({required this.page});
}

class SignUpEvent extends AuthEvent{
  final String email;
  final String password;

  const SignUpEvent({required this.email, required this.password});

}

class SignInEvent extends AuthEvent{
  final String email;
  final String password;

  const SignInEvent({required this.email, required this.password});

}

class GoogleSignInEvent extends AuthEvent{

}

class ChangeRememberMeEvent extends AuthEvent{
  final bool val;
  const ChangeRememberMeEvent({required this.val});
}


