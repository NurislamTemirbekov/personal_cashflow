import 'package:mockito/annotations.dart';
import 'package:cash_flow/features/transactions/domain/repositories/transaction_repository.dart';
import 'package:cash_flow/features/auth/domain/repositories/auth_repository.dart';
import 'package:cash_flow/features/categories/domain/repositories/category_repository.dart';
import 'package:cash_flow/features/settings/domain/repositories/settings_repository.dart';

@GenerateMocks([
  TransactionRepository,
  AuthRepository,
  CategoryRepository,
  SettingsRepository,
])
void main() {}

