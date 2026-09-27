part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthToggleModeEvent extends AuthEvent {
  final bool isLogin;
  const AuthToggleModeEvent({required this.isLogin});

  @override
  List<Object> get props => [isLogin];
}

class AuthSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  final String? name;
  final bool isLogin;

  const AuthSubmittedEvent({
    required this.email,
    required this.password,
    this.name,
    required this.isLogin,
  });

  @override
  List<Object> get props => [email, password, name ?? '', isLogin];
}

class AuthLogoutEvent extends AuthEvent {}