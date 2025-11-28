import 'package:cash_flow/domain/entities/cash_flow_summary.dart';

import '../../repositories/transaction_repository.dart';

class GetCashFlowSummary {
  GetCashFlowSummary(this._repository);
   
  final TransactionRepository _repository;

  Future <CashFlowSummary> call (String userId, DateTime startDate, DateTime endDate) async {
    if(startDate.isAfter(endDate)) {
      throw Exception("Start date must be before end date");
    }
    return await _repository.getCashFlowSummary(userId, startDate, endDate);
  }
}