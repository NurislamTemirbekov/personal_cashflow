import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cash_flow/features/transactions/domain/usecases/add_transaction_usecase.dart';
import 'package:cash_flow/features/transactions/domain/usecases/delete_transaction_usecase.dart';
import 'package:cash_flow/features/transactions/domain/usecases/get_cash_flow_summary_usecase.dart';
import 'package:cash_flow/features/transactions/domain/usecases/get_transactions_usecase.dart';
import 'package:cash_flow/features/transactions/ui/bloc/transaction_event.dart';
import 'package:cash_flow/features/transactions/ui/bloc/transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final GetTransactionsUseCase _getTransactionsUseCase;
  final AddTransactionUseCase _addTransactionUseCase;
  final DeleteTransactionUseCase _deleteTransactionUseCase;
  final GetCashFlowSummaryUseCase _getCashFlowSummaryUseCase;

  TransactionBloc({
    required GetTransactionsUseCase getTransactionsUseCase,
    required AddTransactionUseCase addTransactionUseCase,
    required DeleteTransactionUseCase deleteTransactionUseCase,
    required GetCashFlowSummaryUseCase getCashFlowSummaryUseCase,
  })  : _getTransactionsUseCase = getTransactionsUseCase,
        _addTransactionUseCase = addTransactionUseCase,
        _deleteTransactionUseCase = deleteTransactionUseCase,
        _getCashFlowSummaryUseCase = getCashFlowSummaryUseCase,
        super(const TransactionState.initial()) {
    on<TransactionEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
    TransactionEvent event,
    Emitter<TransactionState> emit,
  ) async {
    await event.when(
      loadTransactions: (userId) => _onLoadTransactions(userId, emit),
      addTransaction: (transaction) => _onAddTransaction(transaction, emit),
      deleteTransaction: (transactionId) =>
          _onDeleteTransaction(transactionId, emit),
      loadSummary: (userId, startDate, endDate) =>
          _onLoadSummary(userId, startDate, endDate, emit),
      refreshTransactions: (userId) => _onRefreshTransactions(userId, emit),
    );
  }

  Future<void> _onLoadTransactions(
    String userId,
    Emitter<TransactionState> emit,
  ) async {
    emit(const TransactionState.loading());
    try {
      final transactions = await _getTransactionsUseCase(userId);
      emit(TransactionState.loaded(transactions: transactions));
    } catch (e) {
      emit(TransactionState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onAddTransaction(
    transaction,
    Emitter<TransactionState> emit,
  ) async {
    state.maybeWhen(
      loaded: (transactions, summary) {
        emit(TransactionState.loaded(
          transactions: transactions,
          summary: summary,
        ));
      },
      orElse: () {
        emit(const TransactionState.loading());
      },
    );
    try {
      await _addTransactionUseCase(transaction);
      final transactions = await _getTransactionsUseCase(transaction.userId);
      final summary = state.maybeWhen(
        loaded: (_, s) => s,
        orElse: () => null,
      );
      emit(TransactionState.loaded(transactions: transactions, summary: summary));
    } catch (e) {
      emit(TransactionState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onDeleteTransaction(
    String transactionId,
    Emitter<TransactionState> emit,
  ) async {
    state.maybeWhen(
      loaded: (transactions, summary) {
        emit(TransactionState.loaded(
          transactions: transactions,
          summary: summary,
        ));
      },
      orElse: () {
        emit(const TransactionState.loading());
      },
    );
    try {
      await _deleteTransactionUseCase(transactionId);
      state.maybeWhen(
        loaded: (transactions, summary) {
          final updatedTransactions =
              transactions.where((t) => t.id != transactionId).toList();
          emit(TransactionState.loaded(
            transactions: updatedTransactions,
            summary: summary,
          ));
        },
        orElse: () {},
      );
    } catch (e) {
      emit(TransactionState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onLoadSummary(
    String userId,
    DateTime startDate,
    DateTime endDate,
    Emitter<TransactionState> emit,
  ) async {
    try {
      final summary = await _getCashFlowSummaryUseCase(userId, startDate, endDate);
      state.maybeWhen(
        loaded: (transactions, _) {
          emit(TransactionState.loaded(transactions: transactions, summary: summary));
        },
        orElse: () async {
          final transactions = await _getTransactionsUseCase(userId);
          emit(TransactionState.loaded(transactions: transactions, summary: summary));
        },
      );
    } catch (e) {
      emit(TransactionState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onRefreshTransactions(
    String userId,
    Emitter<TransactionState> emit,
  ) async {
    try {
      final transactions = await _getTransactionsUseCase(userId);
      final summary = state.maybeWhen(
        loaded: (_, s) => s,
        orElse: () => null,
      );
      emit(TransactionState.loaded(transactions: transactions, summary: summary));
    } catch (e) {
      emit(TransactionState.error(e.toString().replaceAll('Exception: ', '')));
    }
  }
}

