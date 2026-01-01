import 'package:cash_flow/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:cash_flow/features/transactions/model/transaction_model.dart';

class AddTransactionUseCase {
  AddTransactionUseCase(this._repository);
  final TransactionRepository _repository;

  Future<void> call(TransactionModel transaction) async {
    if (transaction.amount <= 0) {
      throw Exception("Amount must be greater than 0");
    }
    await _repository.addTransaction(transaction);
  }
}



