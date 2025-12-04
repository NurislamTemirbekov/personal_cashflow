import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:flutter/material.dart';
import 'package:telegram_web_app/telegram_web_app.dart';


class TelegramService {
  static TelegramWebApp? _telegramWebApp;
  static bool _isInitialized = false;

  static bool get isAvailable => kIsWeb;

  static TelegramWebApp? get instance => _telegramWebApp;


  static Future<void> init() async {
    if (!kIsWeb) {
      return;
    }

    try {
      _telegramWebApp = TelegramWebApp.instance;
      _isInitialized = true;
      _telegramWebApp?.expand();
      _telegramWebApp?.enableClosingConfirmation();
    } catch (e) {
      debugPrint('Telegram Web App initialization error: $e');
      _isInitialized = false;
    }
  }

  static bool get isInitialized => _isInitialized && _telegramWebApp != null;


  static WebAppUser? getUser() {
    if (!isInitialized) return null;
    try {
      return _telegramWebApp?.initDataUnsafe?.user;
    } catch (e) {
      debugPrint('Error getting Telegram user: $e');
      return null;
    }
  }

  static int? getUserId() {
    return getUser()?.id;
  }

  static String? getUsername() {
    return getUser()?.username;
  }

  static String? getFirstName() {
    return getUser()?.firstName;
  }

  static String? getLastName() {
    return getUser()?.lastName;
  }

  static String? getFullName() {
    final user = getUser();
    if (user == null) return null;
    
    final firstName = user.firstName ?? '';
    final lastName = user.lastName ?? '';
    
    if (firstName.isEmpty && lastName.isEmpty) {
      return user.username;
    }
    
    return [firstName, lastName].where((name) => name.isNotEmpty).join(' ').trim();
  }

  static String? getPhotoUrl() {
    return getUser()?.photoUrl;
  }

  static TelegramInitData? getInitData() {
    if (!isInitialized) return null;
    try {
      return _telegramWebApp?.initData;
    } catch (e) {
      debugPrint('Error getting init data: $e');
      return null;
    }
  }

  static WebAppInitData? getInitDataUnsafe() {
    if (!isInitialized) return null;
    try {
      return _telegramWebApp?.initDataUnsafe;
    } catch (e) {
      debugPrint('Error getting init data unsafe: $e');
      return null;
    }
  }

  static void close() {
    if (!isInitialized) return;
    try {
      _telegramWebApp?.close();
    } catch (e) {
      debugPrint('Error closing Telegram app: $e');
    }
  }

  static void showMainButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    if (!isInitialized) return;
    
    try {
      final mainButton = _telegramWebApp?.mainButton;
      if (mainButton == null) return;
      
      mainButton.setText(text);
      mainButton.onClick(() => onPressed());
      mainButton.show();
    } catch (e) {
      debugPrint('Error showing main button: $e');
    }
  }

  static void hideMainButton() {
    if (!isInitialized) return;
    try {
      _telegramWebApp?.mainButton?.hide();
    } catch (e) {
      debugPrint('Error hiding main button: $e');
    }
  }

  static void showBackButton({required VoidCallback onPressed}) {
    if (!isInitialized) return;
    try {
      final backButton = _telegramWebApp?.backButton;
      if (backButton == null) return;
      
      backButton.onClick(() => onPressed());
      backButton.show();
    } catch (e) {
      debugPrint('Error showing back button: $e');
    }
  }

  static void hideBackButton() {
    if (!isInitialized) return;
    try {
      _telegramWebApp?.backButton?.hide();
    } catch (e) {
      debugPrint('Error hiding back button: $e');
    }
  }

  static void hapticFeedback([HapticFeedbackImpact impact = HapticFeedbackImpact.medium]) {
    if (!isInitialized) return;
    try {
      _telegramWebApp?.hapticFeedback?.impactOccurred(impact);
    } catch (e) {
      debugPrint('Error with haptic feedback: $e');
    }
  }

  static bool get isRunningInTelegram {
    if (!kIsWeb) return false;
    if (!isInitialized) return false;
    
    try {
      return _telegramWebApp != null;
    } catch (e) {
      return false;
    }
  }

  static void setHeaderColor(Color color) {
    if (!isInitialized) return;
    try {
      _telegramWebApp?.setHeaderColor(color);
    } catch (e) {
      debugPrint('Error setting header color: $e');
    }
  }

  static void setBackgroundColor(Color color) {
    if (!isInitialized) return;
    try {
      _telegramWebApp?.setBackgroundColor(color);
    } catch (e) {
      debugPrint('Error setting background color: $e');
    }
  }
}
