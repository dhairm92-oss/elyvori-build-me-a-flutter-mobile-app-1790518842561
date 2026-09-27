import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthToggleModeEvent>(_onToggleMode);
    on<AuthSubmittedEvent>(_onSubmitted);
    on<AuthLogoutEvent>(_onLogout);
  }

  void _onToggleMode(AuthToggleModeEvent event, Emitter<AuthState> emit) {
    emit(AuthInitial(isLogin: event.isLogin));
  }

  Future<void> _onSubmitted(AuthSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    // Simulate network delay for luxury backend call
    await Future.delayed(const Duration(seconds: 2));

    if (event.email.isEmpty || event.password.isEmpty) {
      emit(AuthError(
        message: 'Please fill in all required fields.',
        isLogin: event.isLogin,
      ));
      return;
    }

    if (event.password.length < 6) {
      emit(AuthError(
        message: 'Password must be at least 6 characters.',
        isLogin: event.isLogin,
      ));
      return;
    }

    // Success simulation
    emit(AuthAuthenticated(email: event.email));
  }

  void _onLogout(AuthLogoutEvent event, Emitter<AuthState> emit) {
    emit(const AuthInitial(isLogin: true));
  }
}