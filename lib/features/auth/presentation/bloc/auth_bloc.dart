import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthInitial()) {
    on<AuthModeChanged>(_onAuthModeChanged);
    on<AuthSubmitted>(_onAuthSubmitted);
  }

  void _onAuthModeChanged(AuthModeChanged event, Emitter<AuthState> emit) {
    emit(AuthInitial(isLogin: event.isLogin));
  }

  Future<void> _onAuthSubmitted(AuthSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await Future.delayed(const Duration(seconds: 1500)); // simulated network
    if (event.email.isNotEmpty && event.password.length >= 6) {
      emit(AuthSuccess());
    } else {
      emit(const AuthFailure('Invalid credentials. Password must be at least 6 chars.'));
      emit(AuthInitial(isLogin: event.isLogin));
    }
  }
}
