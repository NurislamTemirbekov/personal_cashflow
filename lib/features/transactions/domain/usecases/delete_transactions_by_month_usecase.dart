import 'package:cash_flow/features/transactions/domain/repositories/transaction_repository.dart';

class DeleteTransactionsByMonthUseCase {
  final TransactionRepository _repository;

  DeleteTransactionsByMonthUseCase(this._repository);

  Future<void> call(String userId, int year, int month) async {
    await _repository.deleteTransactionsByMonth(userId, year, month);
  }
}

