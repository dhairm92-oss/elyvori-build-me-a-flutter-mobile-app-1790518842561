import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/user_profile.dart';

// Events
abstract class SettingsEvent extends Equatable {
  const SettingsEvent();
  @override
  List<Object?> get props => [];
}

class LoadSettings extends SettingsEvent {}

class UpdateProfile extends SettingsEvent {
  final UserProfile profile;
  const UpdateProfile(this.profile);
  @override
  List<Object?> get props => [profile];
}

class TogglePushNotifications extends SettingsEvent {
  final bool value;
  const TogglePushNotifications(this.value);
  @override
  List<Object?> get props => [value];
}

class ToggleBiometrics extends SettingsEvent {
  final bool value;
  const ToggleBiometrics(this.value);
  @override
  List<Object?> get props => [value];
}

class UpdateCurrency extends SettingsEvent {
  final String currency;
  const UpdateCurrency(this.currency);
  @override
  List<Object?> get props => [currency];
}

// States
abstract class SettingsState extends Equatable {
  const SettingsState();
  @override
  List<Object?> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final UserProfile profile;
  const SettingsLoaded(this.profile);
  @override
  List<Object?> get props => [profile];
}

class SettingsError extends SettingsState {
  final String message;
  const SettingsError(this.message);
  @override
  List<Object?> get props => [message];
}

// BLoC
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<LoadSettings>(_onLoadSettings);
    on<UpdateProfile>(_onUpdateProfile);
    on<TogglePushNotifications>(_onTogglePushNotifications);
    on<ToggleBiometrics>(_onToggleBiometrics);
    on<UpdateCurrency>(_onUpdateCurrency);
  }

  Future<void> _onLoadSettings(LoadSettings event, Emitter<SettingsState> emit) async {
    emit(SettingsLoading());
    try {
      await Future.delayed(const Duration(milliseconds: 600)); // simulate network fetch
      const initialProfile = UserProfile(
        name: 'Aurelia V. Sterling',
        email: 'aurelia.sterling@luxury.com',
        phone: '+1 (555) 382-9104',
        avatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb',
        pushNotifications: true,
        biometricsEnabled: true,
        currency: 'USD (\$)',
      );
      emit(const SettingsLoaded(initialProfile));
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  Future<void> _onUpdateProfile(UpdateProfile event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      emit(SettingsLoaded(event.profile));
    }
  }

  Future<void> _onTogglePushNotifications(TogglePushNotifications event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final current = (state as SettingsLoaded).profile;
      emit(SettingsLoaded(current.copyWith(pushNotifications: event.value)));
    }
  }

  Future<void> _onToggleBiometrics(ToggleBiometrics event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final current = (state as SettingsLoaded).profile;
      emit(SettingsLoaded(current.copyWith(biometricsEnabled: event.value)));
    }
  }

  Future<void> _onUpdateCurrency(UpdateCurrency event, Emitter<SettingsState> emit) async {
    if (state is SettingsLoaded) {
      final current = (state as SettingsLoaded).profile;
      emit(SettingsLoaded(current.copyWith(currency: event.currency)));
    }
  }
}