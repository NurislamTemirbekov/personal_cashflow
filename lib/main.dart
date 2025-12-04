import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cash_flow/core/di/service_locator.dart';
import 'package:cash_flow/core/theme/app_theme.dart';
import 'package:cash_flow/core/services/theme_service.dart';
import 'package:cash_flow/core/services/telegram_service.dart';
import 'package:cash_flow/presentation/bloc/auth/auth_bloc.dart';
import 'package:cash_flow/presentation/bloc/auth/auth_event.dart';
import 'package:cash_flow/presentation/bloc/cashflow/cashflow_bloc.dart';
import 'package:cash_flow/presentation/bloc/category/category_bloc.dart';
import 'package:cash_flow/presentation/routes/app_router.dart';

_MyAppState? getGlobalAppState() => _globalAppState;
_MyAppState? _globalAppState;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  
  if (kIsWeb) {
    TelegramService.init().catchError((e) {
      debugPrint('Telegram init error: $e');
    });
  }
  
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
    _syncTelegramTheme();
  }

  @override
  void dispose() {
    _globalAppState = null;
    super.dispose();
  }

  Future<void> _loadThemeMode() async {
    if (kIsWeb) {
      if (mounted) {
        setState(() {
          _isDarkMode = false;
        });
      }
      return;
    }
    
    final isDark = await ThemeService.isDarkMode();
    if (mounted) {
      setState(() {
        _isDarkMode = isDark;
      });
    }
  }

  void _syncTelegramTheme() {
    if (kIsWeb) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        if (TelegramService.isRunningInTelegram) {
          try {
            TelegramService.setHeaderColor(Colors.white);
            TelegramService.setBackgroundColor(Colors.white);
          } catch (e) {
            debugPrint('Error syncing Telegram theme: $e');
          }
        }
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
          create: (context) => AuthBloc()..add(const CheckAuthStatusEvent()),
        ),
        BlocProvider(create: (context) => CashFlowBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
      ],
      child: MaterialApp(
        title: 'Cash Flow Manager',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: kIsWeb ? ThemeMode.light : (_isDarkMode ? ThemeMode.dark : ThemeMode.light),
        initialRoute: AppRouter.splash,
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
