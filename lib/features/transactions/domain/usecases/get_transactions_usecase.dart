import 'package:cash_flow/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';

class GetTransactionsUseCase {
  GetTransactionsUseCase(this._repository);
  final TransactionRepository _repository;

  Future<List<TransactionModel>> call(String userId) async {
    return await _repository.getTransactions(userId);
  }
}



