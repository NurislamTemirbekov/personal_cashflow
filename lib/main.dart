import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cash_flow/core/di/service_locator.dart';
import 'package:cash_flow/core/theme/app_theme.dart';
import 'package:cash_flow/core/services/theme_service.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_bloc.dart';
import 'package:cash_flow/features/auth/ui/bloc/auth_event.dart';
import 'package:cash_flow/features/transactions/ui/bloc/transaction_bloc.dart';
import 'package:cash_flow/features/categories/ui/bloc/category_bloc.dart';
import 'package:cash_flow/core/routes/app_router.dart';

dynamic getGlobalAppState() => _globalAppState;
dynamic _globalAppState;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _globalAppState = this;
    _loadThemeMode();
  }

  @override
  void dispose() {
    _globalAppState = null;
    super.dispose();
  }

  Future<void> _loadThemeMode() async {
    final isDark = await ThemeService.isDarkMode();
    if (mounted) {
      setState(() {
        _isDarkMode = isDark;
      });
    }
  }

  void updateTheme(bool isDark) {
    if (mounted) {
      setState(() {
        _isDarkMode = isDark;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(
            loginUseCase: getIt(),
            registerUseCase: getIt(),
            logoutUseCase: getIt(),
            authRepository: getIt(),
          )..add(const AuthEvent.checkAuthStatus()),
        ),
        BlocProvider(
          create: (context) => TransactionBloc(
            getTransactionsUseCase: getIt(),
            addTransactionUseCase: getIt(),
            deleteTransactionUseCase: getIt(),
            getCashFlowSummaryUseCase: getIt(),
          ),
        ),
        BlocProvider(
          create: (context) => CategoryBloc(
            getCategoriesUseCase: getIt(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Cash Flow Manager',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
        initialRoute: AppRouter.splash,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
