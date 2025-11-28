import '../../entities/transaction.dart';
import '../../repositories/transaction_repository.dart';

class GetTransactions{
  GetTransactions(this._repository);
  final TransactionRepository _repository;

  Future<List<Transaction>> call (String userId) async { 
    return await _repository.getTransactions(userId);
  }
  
}