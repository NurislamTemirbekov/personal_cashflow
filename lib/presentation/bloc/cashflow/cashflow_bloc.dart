import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../domain/usecases/transaction/add_transaction.dart';
import '../../../../domain/usecases/transaction/delete_transaction.dart';
import '../../../../domain/usecases/transaction/get_cash_flow_summary.dart';
import '../../../../domain/usecases/transaction/get_transactions.dart';
import 'cashflow_event.dart';
import 'cashflow_state.dart';

class CashFlowBloc extends Bloc<CashFlowEvent, CashFlowState> {
  final GetTransactions _getTransactionsUseCase;
  final AddTransaction _addTransactionUseCase;
  final DeleteTransaction _deleteTransactionUseCase;
  final GetCashFlowSummary _getCashFlowSummaryUseCase;

  CashFlowBloc({
    GetTransactions? getTransactionsUseCase,
    AddTransaction? addTransactionUseCase,
    DeleteTransaction? deleteTransactionUseCase,
    GetCashFlowSummary? getCashFlowSummaryUseCase,
  })  : _getTransactionsUseCase =
            getTransactionsUseCase ?? getIt<GetTransactions>(),
        _addTransactionUseCase =
            addTransactionUseCase ?? getIt<AddTransaction>(),
        _deleteTransactionUseCase =
            deleteTransactionUseCase ?? getIt<DeleteTransaction>(),
        _getCashFlowSummaryUseCase =
            getCashFlowSummaryUseCase ?? getIt<GetCashFlowSummary>(),
        super(const CashFlowInitial()) {
    on<LoadTransactionsEvent>(_onLoadTransactions);
    on<AddTransactionEvent>(_onAddTransaction);
    on<DeleteTransactionEvent>(_onDeleteTransaction);
    on<LoadSummaryEvent>(_onLoadSummary);
    on<RefreshTransactionsEvent>(_onRefreshTransactions);
  }

  Future<void> _onLoadTransactions(
    LoadTransactionsEvent event,
    Emitter<CashFlowState> emit,
  ) async {
    emit(const CashFlowLoading());
    try {
      final transactions = await _getTransactionsUseCase(event.userId);
      emit(CashFlowLoaded(transactions: transactions));
    } catch (e) {
      emit(CashFlowError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onAddTransaction(
    AddTransactionEvent event,
    Emitter<CashFlowState> emit,
  ) async {
    if (state is CashFlowLoaded) {
      final currentState = state as CashFlowLoaded;
      emit(CashFlowLoaded(
        transactions: currentState.transactions,
        summary: currentState.summary,
      ));
    } else {
      emit(const CashFlowLoading());
    }
    try {
      await _addTransactionUseCase(event.transaction);
      final transactions =
          await _getTransactionsUseCase(event.transaction.userId);
      final currentState = state is CashFlowLoaded ? state as CashFlowLoaded : null;
      emit(CashFlowLoaded(
        transactions: transactions,
        summary: currentState?.summary,
      ));
    } catch (e) {
      emit(CashFlowError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onDeleteTransaction(
    DeleteTransactionEvent event,
    Emitter<CashFlowState> emit,
  ) async {
    if (state is CashFlowLoaded) {
      final currentState = state as CashFlowLoaded;
      emit(CashFlowLoaded(
        transactions: currentState.transactions,
        summary: currentState.summary,
      ));
    } else {
      emit(const CashFlowLoading());
    }
    try {
      await _deleteTransactionUseCase(event.transactionId);
      if (state is CashFlowLoaded) {
        final currentState = state as CashFlowLoaded;
        final updatedTransactions = currentState.transactions
            .where((t) => t.id != event.transactionId)
            .toList();
        emit(CashFlowLoaded(
          transactions: updatedTransactions,
          summary: currentState.summary,
        ));
      }
    } catch (e) {
      emit(CashFlowError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onLoadSummary(
    LoadSummaryEvent event,
    Emitter<CashFlowState> emit,
  ) async {
    try {
      final summary = await _getCashFlowSummaryUseCase(
        event.userId,
        event.startDate,
        event.endDate,
      );
      if (state is CashFlowLoaded) {
        final currentState = state as CashFlowLoaded;
        emit(currentState.copyWith(summary: summary));
      } else {
        final transactions = await _getTransactionsUseCase(event.userId);
        emit(CashFlowLoaded(transactions: transactions, summary: summary));
      }
    } catch (e) {
      emit(CashFlowError(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> _onRefreshTransactions(
    RefreshTransactionsEvent event,
    Emitter<CashFlowState> emit,
  ) async {
    try {
      final transactions = await _getTransactionsUseCase(event.userId);
      final currentState = state is CashFlowLoaded ? state as CashFlowLoaded : null;
      emit(CashFlowLoaded(
        transactions: transactions,
        summary: currentState?.summary,
      ));
    } catch (e) {
      emit(CashFlowError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}

