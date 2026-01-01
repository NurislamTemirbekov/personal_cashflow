import 'package:cash_flow/features/reports/data/models/monthly_report_db_model.dart';
import 'package:cash_flow/features/reports/domain/repositories/monthly_report_repository.dart';

class GetMonthlyReportsUseCase {
  final MonthlyReportRepository _repository;

  GetMonthlyReportsUseCase(this._repository);

  Future<List<MonthlyReportDbModel>> call(String userId) async {
    return await _repository.getReportsByUserId(userId);
  }
}

