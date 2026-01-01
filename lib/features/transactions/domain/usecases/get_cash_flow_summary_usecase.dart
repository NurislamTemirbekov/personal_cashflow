import 'package:cash_flow/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:cash_flow/features/transactions/model/cash_flow_summary_model.dart';

class GetCashFlowSummaryUseCase {
  GetCashFlowSummaryUseCase(this._repository);
  final TransactionRepository _repository;

  Future<CashFlowSummaryModel> call(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    if (startDate.isAfter(endDate)) {
      throw Exception("Start date must be before end date");
    }
    return await _repository.getCashFlowSummary(userId, startDate, endDate);
  }
}



