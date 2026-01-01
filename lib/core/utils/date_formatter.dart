import 'package:intl/intl.dart';

class DateFormatter {
  static String formatDate(DateTime date) {
    return DateFormat('MMM dd,yyyy').format(date);
  }

  static String formatDateTime(DateTime date) {
    return DateFormat('MMM dd, yyyy \'at\' hh:mm a').format(date);
  }

  static String formatDateForDatabase(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  static String formatMonthYear(DateTime date) {
    return DateFormat('MMMM yyyy').format(date);
  }

  static String formatDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  static String formatTime(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  static bool isThisWeek(DateTime date) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekEnd = weekStart.add(const Duration(days: 6));
    return date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
        date.isBefore(weekEnd.add(const Duration(days: 1)));
  }

  static DateTime getStartOfMonth(DateTime date) {
    return DateTime(date.year, date.month, 1);
  }

  static DateTime getEndOfMonth(DateTime date) {
    return DateTime(date.year, date.month + 1, 0);
  }

  static DateTime? parseDateFromDatabase(String? dateString) {
    if (dateString == null || dateString.isEmpty) return null;
    try {
      return DateFormat('yyyy-MM-dd').parse(dateString);
    } catch (e) {
      return null;
    }
  }

  static bool isEndOfMonth([DateTime? date]) {
    final checkDate = date ?? DateTime.now();
    final lastDayOfMonth = getEndOfMonth(checkDate);
    final daysUntilEnd = lastDayOfMonth.difference(checkDate).inDays;
    return daysUntilEnd <= 2;
  }

  static bool isLastDayOfMonth([DateTime? date]) {
    final checkDate = date ?? DateTime.now();
    final lastDayOfMonth = getEndOfMonth(checkDate);
    return checkDate.year == lastDayOfMonth.year &&
           checkDate.month == lastDayOfMonth.month &&
           checkDate.day == lastDayOfMonth.day;
  }

  static bool canGenerateReportForMonth(DateTime month) {
    return true;
  }

  static bool canDownloadReport() {
    return true;
  }

}