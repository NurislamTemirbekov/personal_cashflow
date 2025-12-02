import 'package:mockito/annotations.dart';
import 'package:cash_flow/domain/repositories/transaction_repository.dart';
import 'package:cash_flow/domain/repositories/auth_repository.dart';
import 'package:cash_flow/domain/repositories/category_repository.dart';
import 'package:cash_flow/domain/repositories/settings_repository.dart';

@GenerateMocks([
  TransactionRepository,
  AuthRepository,
  CategoryRepository,
  SettingsRepository,
])
void main() {}

