import 'package:cash_flow/features/transactions/domain/repositories/transaction_repository.dart';

class DeleteTransactionUseCase {
  DeleteTransactionUseCase(this._repository);
  final TransactionRepository _repository;

  Future<void> call(String transactionId) async {
    if (transactionId.isEmpty) {
      throw Exception("Transaction ID cannot be empty");
    }
    await _repository.deleteTransaction(transactionId);
  }
}



