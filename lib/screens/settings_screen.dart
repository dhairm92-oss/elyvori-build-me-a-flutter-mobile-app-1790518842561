import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import '../blocs/settings_bloc.dart';
import '../services/theme_service.dart';
import '../models/user_profile.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsBloc()..add(LoadSettings()),
      child: const SettingsView(),
    );
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeService = Provider.of<ThemeService>(context);
    final isDark = themeService.isDarkMode;
    final primaryGold = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('SETTINGS & PROFILE'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.wb_sunny : Icons.nightlight_round),
            onPressed: () => themeService.toggleTheme(),
            tooltip: 'Toggle Theme',
          ),
        ],
      ),
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is SettingsLoading || state is SettingsInitial) {
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(primaryGold),
              ),
            );
          } else if (state is SettingsLoaded) {
            final profile = state.profile;
            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildProfileHeader(context, profile, primaryGold),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'APPEARANCE & THEME'),
                _buildThemeSwitcherCard(context, themeService, isDark),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'ACCOUNT MANAGEMENT'),
                _buildAccountSettingsCard(context, profile),
                const SizedBox(height: 24),
                _buildSectionTitle(context, 'PREFERENCES'),
                _buildPreferencesCard(context, profile),
                const SizedBox(height: 32),
                _buildLogoutButton(context),
                const SizedBox(height: 32),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context, UserProfile profile, Color goldColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: goldColor.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(profile.avatarUrl),
            backgroundColor: goldColor.withOpacity(0.2),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: goldColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  profile.phone,
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit, color: goldColor),
            onPressed: () => _showEditProfileDialog(context, profile),
            tooltip: 'Edit Profile',
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          letterSpacing: 1.5,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  Widget _buildThemeSwitcherCard(BuildContext context, ThemeService themeService, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: SwitchListTile(
        secondary: Icon(
          isDark ? Icons.nightlight_round : Icons.wb_sunny,
          color: Theme.of(context).primaryColor,
        ),
        title: const Text('Luxury Dark Mode'),
        subtitle: Text(isDark ? 'Obsidian & Brushed Gold Active' : 'Light Elegance Active'),
        value: isDark,
        activeColor: Theme.of(context).primaryColor,
        onChanged: (val) {
          themeService.toggleTheme();
        },
      ),
    );
  }

  Widget _buildAccountSettingsCard(BuildContext context, UserProfile profile) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.person_outline, color: Theme.of(context).primaryColor),
            title: const Text('Personal Information'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () => _showEditProfileDialog(context, profile),
          ),
          const Divider(height: 1, indent: 56),
          ListTile(
            leading: Icon(Icons.lock_outline, color: Theme.of(context).primaryColor),
            title: const Text('Security & Password'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Security settings tapped.')),
              );
            },
          ),
          const Divider(height: 1, indent: 56),
          ListTile(
            leading: Icon(Icons.verified_user_outlined, color: Theme.of(context).primaryColor),
            title: const Text('VIP Membership Status'),
            trailing: Text('Elite', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildPreferencesCard(BuildContext context, UserProfile profile) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withOpacity(0.2)),
      ),
      child: Column(
        children: [
          SwitchListTile(
            secondary: Icon(Icons.notifications_active_outlined, color: Theme.of(context).primaryColor),
            title: const Text('Push Notifications'),
            subtitle: const Text('Real-time alerts for concierge & transactions'),
            value: profile.pushNotifications,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (val) {
              BlocProvider.of<SettingsBloc>(context).add(TogglePushNotifications(val));
            },
          ),
          const Divider(height: 1, indent: 56),
          SwitchListTile(
            secondary: Icon(Icons.fingerprint, color: Theme.of(context).primaryColor),
            title: const Text('Biometric Authentication'),
            subtitle: const Text('Secure access using FaceID or fingerprint'),
            value: profile.biometricsEnabled,
            activeColor: Theme.of(context).primaryColor,
            onChanged: (val) {
              BlocProvider.of<SettingsBloc>(context).add(ToggleBiometrics(val));
            },
          ),
          const Divider(height: 1, indent: 56),
          ListTile(
            leading: Icon(Icons.monetization_on_outlined, color: Theme.of(context).primaryColor),
            title: const Text('Preferred Currency'),
            trailing: DropdownButton<String>(
              value: profile.currency,
              underline: const SizedBox.shrink(),
              dropdownColor: Theme.of(context).cardColor,
              items: <String>['USD (\$)', 'EUR (€)', 'GBP (£)', 'CHF (CHF)']
                  .map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  BlocProvider.of<SettingsBloc>(context).add(UpdateCurrency(newValue));
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Colors.red.withOpacity(0.6)),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Logged out successfully.')),
        );
      },
      child: const Text(
        'SIGN OUT',
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, UserProfile profile) {
    final nameController = TextEditingController(text: profile.name);
    final phoneController = TextEditingController(text: profile.phone);

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: Theme.of(context).cardColor,
          title: Text('Edit Profile', style: TextStyle(color: Theme.of(context).primaryColor)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {
                final updated = profile.copyWith(
                  name: nameController.text,
                  phone: phoneController.text,
                );
                BlocProvider.of<SettingsBloc>(context).add(UpdateProfile(updated));
                Navigator.pop(dialogContext);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}