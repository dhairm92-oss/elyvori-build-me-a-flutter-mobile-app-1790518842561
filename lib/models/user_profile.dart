import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String name;
  final String email;
  final String phone;
  final String avatarUrl;
  final bool pushNotifications;
  final bool biometricsEnabled;
  final String currency;

  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.pushNotifications,
    required this.biometricsEnabled,
    required this.currency,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? phone,
    String? avatarUrl,
    bool? pushNotifications,
    bool? biometricsEnabled,
    String? currency,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      pushNotifications: pushNotifications ?? this.pushNotifications,
      biometricsEnabled: biometricsEnabled ?? this.biometricsEnabled,
      currency: currency ?? this.currency,
    );
  }

  @ValueOf()
  @Listable()
  @override
  List<Object?> get props => [
        name,
        email,
        phone,
        avatarUrl,
        pushNotifications,
        biometricsEnabled,
        currency,
      ];
}