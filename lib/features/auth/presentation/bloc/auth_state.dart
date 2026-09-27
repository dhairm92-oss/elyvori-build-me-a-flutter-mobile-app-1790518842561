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

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;
  const AuthFailure(this.error);

  @override
  List<Object> get props => [error];
}
