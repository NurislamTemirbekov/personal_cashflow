import 'package:get_it/get_it.dart';
import 'package:cash_flow/features/transactions/data/datasources/transaction_datasource_impl.dart';
import 'package:cash_flow/features/transactions/data/repositories/transaction_repository_impl.dart';
import 'package:cash_flow/features/transactions/domain/datasources/transaction_datasource.dart';
import 'package:cash_flow/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:cash_flow/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:cash_flow/features/transactions/domain/usecases/delete_transaction_usecase.dart';
import 'package:cash_flow/features/transactions/domain/usecases/delete_transactions_by_month_usecase.dart';
import 'package:cash_flow/features/transactions/domain/usecases/get_cash_flow_summary_usecase.dart';
import 'package:cash_flow/features/transactions/domain/usecases/get_transactions_usecase.dart';

void registerTransactionModule(GetIt getIt) {
  getIt.registerLazySingleton<TransactionDatasource>(
    () => TransactionDatasourceImpl(),
  );

  getIt.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(getIt<TransactionDatasource>()),
  );

  getIt.registerLazySingleton<AddTransactionUseCase>(
    () => AddTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetTransactionsUseCase>(
    () => GetTransactionsUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<DeleteTransactionUseCase>(
    () => DeleteTransactionUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<DeleteTransactionsByMonthUseCase>(
    () => DeleteTransactionsByMonthUseCase(getIt<TransactionRepository>()),
  );
  getIt.registerLazySingleton<GetCashFlowSummaryUseCase>(
    () => GetCashFlowSummaryUseCase(getIt<TransactionRepository>()),
  );
}



