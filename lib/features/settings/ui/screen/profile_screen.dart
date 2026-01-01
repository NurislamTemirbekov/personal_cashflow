import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cash_flow/features/auth/ui/bloc/auth_bloc.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_event.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_state.dart';
import 'package:cash_flow/core/services/theme_service.dart';
import 'package:cash_flow/core/theme/app_colors.dart';
import 'package:cash_flow/core/constants/app_constants.dart';
import 'package:cash_flow/core/routes/app_router.dart';
import 'package:cash_flow/core/di/service_locator.dart';
import 'package:cash_flow/features/settings/domain/repositories/settings_repository.dart';
import 'package:cash_flow/main.dart';
import 'package:cash_flow/features/auth/domain/datasources/auth_datasource.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isDarkMode = false;
  final SettingsRepository _settingsRepository = getIt<SettingsRepository>();
  final AuthDatasource _authDatasource = getIt<AuthDatasource>();

  @override
  void initState() {
    super.initState();
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final isDark = await ThemeService.isDarkMode();
    setState(() {
      _isDarkMode = isDark;
    });
  }

  Future<void> _toggleTheme() async {
    final newThemeMode = !_isDarkMode;
    await ThemeService.setDarkMode(newThemeMode);
    setState(() {
      _isDarkMode = newThemeMode;
    });
    if (mounted) {
      getGlobalAppState()?.updateTheme(newThemeMode);
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null && mounted) {
      final authState = context.read<AuthBloc>().state;
      authState.maybeWhen(
        authenticated: (user) async {
          await _settingsRepository.updateAvatar(pickedFile.path);
          await _authDatasource.updateUserAvatar(user.id, pickedFile.path);
          if (mounted) {
            context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
          await Future.delayed(const Duration(milliseconds: 200));
          if (mounted) {
            setState(() {});
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Avatar updated successfully')),
            );
          }
        }
        },
        orElse: () {},
      );
    }
  }

  void _handleSignOut() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(const AuthEvent.logout());
              Navigator.of(context).pushNamedAndRemoveUntil(
                AppRouter.login,
                (route) => false,
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          String username = 'User';
          String? avatarPath;

          authState.maybeWhen(
            authenticated: (user) {
              username = user.username;
              avatarPath = user.avatarPath;
            },
            orElse: () {},
          );

          return ListView(
            padding: const EdgeInsets.all(AppConstants.padding16),
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppColors.border, width: 1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor:
                                  Theme.of(context).colorScheme.primaryContainer,
                              backgroundImage: avatarPath != null &&
                                      File(avatarPath!).existsSync()
                                  ? FileImage(File(avatarPath!))
                                  : null,
                              child: avatarPath == null ||
                                      !File(avatarPath!).existsSync()
                                  ? Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimaryContainer,
                                    )
                                  : null,
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.primary,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                    width: 2,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tap avatar to change photo',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textSecondary,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppColors.border, width: 1),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      _isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  title: const Text('Theme'),
                  subtitle: Text(_isDarkMode ? 'Dark Mode' : 'Light Mode'),
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (_) => _toggleTheme(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: AppColors.error.withValues(alpha: 0.3), width: 1),
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.error.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.logout,
                      color: AppColors.error,
                    ),
                  ),
                  title: const Text(
                    'Sign Out',
                    style: TextStyle(color: AppColors.error),
                  ),
                  onTap: _handleSignOut,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
