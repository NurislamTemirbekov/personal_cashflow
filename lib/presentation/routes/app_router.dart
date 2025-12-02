import 'package:flutter/material.dart';
import 'package:cash_flow/presentation/screens/auth/login_screen.dart';
import 'package:cash_flow/presentation/screens/auth/register_screen.dart';
import 'package:cash_flow/presentation/screens/home/home_screen.dart';
import 'package:cash_flow/presentation/screens/profile/profile_screen.dart';
import 'package:cash_flow/presentation/screens/reports/monthly_report_screen.dart';
import 'package:cash_flow/presentation/screens/reports/reports_history_screen.dart';
import 'package:cash_flow/presentation/screens/splash/splash_screen.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String profile = '/profile';
  static const String monthlyReport = '/monthly-report';
  static const String reportsHistory = '/reports-history';

  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      case monthlyReport:
        return MaterialPageRoute(builder: (_) => const MonthlyReportScreen());
      case reportsHistory:
        return MaterialPageRoute(builder: (_) => const ReportsHistoryScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${routeSettings.name}'),
            ),
          ),
        );
    }
  }
}

