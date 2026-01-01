import 'package:cash_flow/features/reports/data/models/monthly_report_db_model.dart';
import 'package:cash_flow/features/reports/domain/repositories/monthly_report_repository.dart';

class SaveMonthlyReportUseCase {
  final MonthlyReportRepository _repository;

  SaveMonthlyReportUseCase(this._repository);

  Future<String> call(MonthlyReportDbModel report) async {
    return await _repository.saveReport(report);
  }
}

