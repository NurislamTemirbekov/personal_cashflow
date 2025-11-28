import 'package:cash_flow/domain/repositories/transaction_repository.dart';

import '../../entities/transaction.dart';

class AddTransaction {
  AddTransaction(this._repository);
  final TransactionRepository _repository;

  Future<void> call (Transaction transaction) async {
    if(transaction.amount <= 0) {
      throw Exception("Amount must be greater than 0");
    }
    if(transaction.description.isEmpty) {
      throw Exception("Description cannot be empty");
    }
    await _repository.addTransaction(transaction);
  }
}