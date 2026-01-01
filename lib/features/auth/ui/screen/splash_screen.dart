import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_bloc.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_event.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_state.dart';
import 'package:cash_flow/core/routes/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthEvent.checkAuthStatus());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.maybeWhen(
          authenticated: (_) {
            Navigator.of(context).pushReplacementNamed(AppRouter.home);
          },
          unauthenticated: () {
            Navigator.of(context).pushReplacementNamed(AppRouter.login);
          },
          orElse: () {},
        );
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_balance_wallet,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 24),
              Text(
                'Cash Flow Manager',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(height: 48),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}

