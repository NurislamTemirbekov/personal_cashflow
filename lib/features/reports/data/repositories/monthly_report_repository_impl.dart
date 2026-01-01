import 'package:cash_flow/features/reports/data/models/monthly_report_db_model.dart';
import 'package:cash_flow/features/reports/domain/datasources/monthly_report_datasource.dart';
import 'package:cash_flow/features/reports/domain/repositories/monthly_report_repository.dart';

class MonthlyReportRepositoryImpl implements MonthlyReportRepository {
  final MonthlyReportDatasource _datasource;

  MonthlyReportRepositoryImpl(this._datasource);

  @override
  Future<String> saveReport(MonthlyReportDbModel report) async {
    return await _datasource.saveReport(report);
  }

  @override
  Future<List<MonthlyReportDbModel>> getReportsByUserId(String userId) async {
    return await _datasource.getReportsByUserId(userId);
  }

  @override
  Future<MonthlyReportDbModel?> getReportByMonth(String userId, int year, int month) async {
    return await _datasource.getReportByMonth(userId, year, month);
  }

  @override
  Future<void> deleteReport(String reportId) async {
    await _datasource.deleteReport(reportId);
  }
}

