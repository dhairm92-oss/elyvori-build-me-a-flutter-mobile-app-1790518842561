part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthModeChanged extends AuthEvent {
  final bool isLogin;
  const AuthModeChanged(this.isLogin);

  @override
  List<Object> get props => [isLogin];
}

class AuthSubmitted extends AuthEvent {
  final String email;
  final String password;
  final bool isLogin;

  const AuthSubmitted({
    required this.email,
    required this.password,
    required this.isLogin,
  });

  @override
  List<Object> get props => [email, password, isLogin];
}
