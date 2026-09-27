part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  final bool isLogin;
  const AuthInitial({this.isLogin = true});

  @override
  List<Object> get props => [isLogin];
}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final String email;
  const AuthAuthenticated({required this.email});

  @override
  List<Object> get props => [email];
}

class AuthError extends AuthState {
  final String message;
  final bool isLogin;
  const AuthError({required this.message, required this.isLogin});

  @override
  List<Object> get props => [message, isLogin];
}