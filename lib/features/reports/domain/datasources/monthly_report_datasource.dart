import 'package:cash_flow/features/reports/data/models/monthly_report_db_model.dart';

abstract class MonthlyReportDatasource {
  Future<String> saveReport(MonthlyReportDbModel report);
  Future<List<MonthlyReportDbModel>> getReportsByUserId(String userId);
  Future<MonthlyReportDbModel?> getReportByMonth(String userId, int year, int month);
  Future<void> deleteReport(String reportId);
}

