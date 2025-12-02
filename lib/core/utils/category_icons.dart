import 'package:flutter/material.dart';

class CategoryIcons {
  static IconData getIconData(String iconCode) {
    switch (iconCode) {
      case '💼':
        return Icons.business_center;
      case '🚗':
        return Icons.directions_car;
      case '📈':
        return Icons.trending_up;
      case '📚':
        return Icons.school;
      case '🍔':
        return Icons.restaurant;
      case '💪':
        return Icons.fitness_center;
      case '👕':
        return Icons.checkroom;
      case '💳':
        return Icons.payment;
      case '💸':
        return Icons.money_off;
      default:
        return Icons.category;
    }
  }
  
  static String getIconCodeForCategory(String categoryId) {
    if (categoryId.contains('transport')) return '🚗';
    if (categoryId.contains('investment')) return '📈';
    if (categoryId.contains('education')) return '📚';
    if (categoryId.contains('foods')) return '🍔';
    if (categoryId.contains('gym')) return '💪';
    if (categoryId.contains('clothes')) return '👕';
    if (categoryId.contains('bills')) return '💳';
    if (categoryId.contains('debts')) return '💸';
    if (categoryId.contains('salary')) return '💼';
    return '📊';
  }
}

