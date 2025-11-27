# Repository Interfaces & Implementations - Code Guide

Complete code for repository interfaces and implementations.

---

## 📁 File 1: `lib/domain/repositories/transaction_repository.dart`

**What to write:**

```dart
import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/cash_flow_summary.dart';

abstract class TransactionRepository {
  Future<void> addTransaction(Transaction transaction);
  Future<List<Transaction>> getTransactions(String userId);
  Future<List<Transaction>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
  Future<void> deleteTransaction(String transactionId);
  Future<CashFlowSummary> getCashFlowSummary(
    String userId,
    DateTime startDate,
    DateTime endDate,
  );
}
```

**Summary:**
- Abstract class (contract)
- Methods return domain entities (Transaction, CashFlowSummary)
- Used by transaction use cases

---

## 📁 File 2: `lib/domain/repositories/category_repository.dart`

**What to write:**

```dart
import 'package:cash_flow/domain/entities/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
  Future<Category?> getCategoryById(String categoryId);
}
```

**Summary:**
- Simple abstract class
- Returns Category entities
- Used by category use cases

---

## 📁 File 3: `lib/domain/repositories/auth_repository.dart`

**What to write:**

```dart
import 'package:cash_flow/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> register(String username, String password);
  Future<User> login(String username, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
}
```

**Summary:**
- Authentication operations
- Returns User entities
- Used by auth use cases

---

## 📁 File 4: `lib/domain/repositories/settings_repository.dart`

**What to write:**

```dart
abstract class SettingsRepository {
  Future<void> changeLanguage(String languageCode);
  Future<String> getLanguage();
  Future<void> updateAvatar(String avatarPath);
  Future<String?> getAvatarPath();
  Future<void> saveCurrentUserId(String userId);
  Future<String?> getCurrentUserId();
  Future<void> clearCurrentUserId();
}
```

**Summary:**
- Settings operations
- Simple methods for language and avatar
- Used by settings use cases

---

## 📁 File 5: `lib/data/repositories/transaction_repository_impl.dart`

**What to write:**

```dart
import 'package:cash_flow/domain/entities/transaction.dart';
import 'package:cash_flow/domain/entities/cash_flow_summary.dart';
import 'package:cash_flow/domain/repositories/transaction_repository.dart';
import 'package:cash_flow/data/datasources/local/transaction_datasource.dart';
import 'package:cash_flow/data/models/transaction_model.dart';
import 'package:cash_flow/core/utils/date_formatter.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  final TransactionDatasource _dataSource;

  TransactionRepositoryImpl(this._dataSource);

  @override
  Future<void> addTransaction(Transaction transaction) async {
    final model = TransactionModel.fromEntity(transaction);
    await _dataSource.insertTransaction(model);
  }

  @override
  Future<List<Transaction>> getTransactions(String userId) async {
    final models = await _dataSource.getTransactions(userId);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<List<Transaction>> getTransactionsByDateRange(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final models = await _dataSource.getTransactionsByDateRange(
      userId,
      startDate,
      endDate,
    );
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    await _dataSource.deleteTransaction(transactionId);
  }

  @override
  Future<CashFlowSummary> getCashFlowSummary(
    String userId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final transactions = await getTransactionsByDateRange(
      userId,
      startDate,
      endDate,
    );

    double totalIncome = 0;
    double totalExpenses = 0;

    for (var transaction in transactions) {
      if (transaction.isIncome) {
        totalIncome += transaction.amount;
      } else {
        totalExpenses += transaction.amount;
      }
    }

    return CashFlowSummary.create(
      totalIncome: totalIncome,
      totalExpenses: totalExpenses,
      periodStart: startDate,
      periodEnd: endDate,
    );
  }
}
```

**Summary:**
- Implements TransactionRepository
- Uses TransactionDatasource
- Converts models to entities
- Calculates cash flow summary from transactions

---

## 📁 File 6: `lib/data/repositories/category_repository_impl.dart`

**What to write:**

```dart
import 'package:cash_flow/domain/entities/category.dart';
import 'package:cash_flow/domain/repositories/category_repository.dart';
import 'package:cash_flow/data/datasources/local/category_datasource.dart';
import 'package:cash_flow/data/models/category_model.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryDatasource _dataSource;

  CategoryRepositoryImpl(this._dataSource);

  @override
  Future<List<Category>> getCategories() async {
    final models = await _dataSource.getCategories();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Category?> getCategoryById(String categoryId) async {
    final model = await _dataSource.getCategoryById(categoryId);
    return model?.toEntity();
  }
}
```

**Summary:**
- Implements CategoryRepository
- Uses CategoryDatasource
- Converts models to entities

---

## 📁 File 7: `lib/data/repositories/auth_repository_impl.dart`

**What to write:**

```dart
import 'package:cash_flow/domain/entities/user.dart';
import 'package:cash_flow/domain/repositories/auth_repository.dart';
import 'package:cash_flow/domain/services/hash_service.dart';
import 'package:cash_flow/data/datasources/local/user_datasource.dart';
import 'package:cash_flow/data/datasources/local/settings_datasource.dart';
import 'package:cash_flow/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final UserDataSource _userDataSource;
  final SettingsDatasource _settingsDataSource;
  final HashService _hashService;

  AuthRepositoryImpl(
    this._userDataSource,
    this._settingsDataSource,
    this._hashService,
  );

  @override
  Future<User> register(String username, String password) async {
    final existingUser = await _userDataSource.getUserByUsername(username);
    if (existingUser != null) {
      throw Exception('Username already exists');
    }

    final passwordHash = _hashService.hashPassword(password);
    final userId = DateTime.now().millisecondsSinceEpoch.toString();
    
    final userModel = UserModel(
      id: userId,
      username: username,
      avatarPath: null,
      createdAtTimestamp: DateTime.now().millisecondsSinceEpoch,
    );

    await _userDataSource.createUser(userModel, passwordHash);
    await _settingsDataSource.saveCurrentUserId(userId);

    return userModel.toEntity();
  }

  @override
  Future<User> login(String username, String password) async {
    final userModel = await _userDataSource.getUserByUsername(username);
    if (userModel == null) {
      throw Exception('User not found');
    }

    final storedHash = await _userDataSource.getPasswordHash(username);
    if (storedHash == null) {
      throw Exception('Invalid credentials');
    }

    final isValid = _hashService.verifyPassword(password, storedHash);
    if (!isValid) {
      throw Exception('Invalid password');
    }

    await _settingsDataSource.saveCurrentUserId(userModel.id);
    return userModel.toEntity();
  }

  @override
  Future<void> logout() async {
    await _settingsDataSource.clearCurrentUserId();
  }

  @override
  Future<User?> getCurrentUser() async {
    final userId = await _settingsDataSource.getCurrentUserId();
    if (userId == null) return null;

    final userModel = await _userDataSource.getUserByUsername(userId);
    return userModel?.toEntity();
  }
}
```

**Summary:**
- Implements AuthRepository
- Uses UserDataSource, SettingsDatasource, HashService
- Handles registration, login, logout
- Validates passwords

---

## 📁 File 8: `lib/data/repositories/settings_repository_impl.dart`

**What to write:**

```dart
import 'package:cash_flow/domain/repositories/settings_repository.dart';
import 'package:cash_flow/data/datasources/local/settings_datasource.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsDatasource _dataSource;

  SettingsRepositoryImpl(this._dataSource);

  @override
  Future<void> changeLanguage(String languageCode) async {
    await _dataSource.saveLanguage(languageCode);
  }

  @override
  Future<String> getLanguage() async {
    return await _dataSource.getLanguage();
  }

  @override
  Future<void> updateAvatar(String avatarPath) async {
    await _dataSource.saveAvatarPath(avatarPath);
  }

  @override
  Future<String?> getAvatarPath() async {
    return await _dataSource.getAvatarPath();
  }

  @override
  Future<void> saveCurrentUserId(String userId) async {
    await _dataSource.saveCurrentUserId(userId);
  }

  @override
  Future<String?> getCurrentUserId() async {
    return await _dataSource.getCurrentUserId();
  }

  @override
  Future<void> clearCurrentUserId() async {
    await _dataSource.clearCurrentUserId();
  }
}
```

**Summary:**
- Implements SettingsRepository
- Uses SettingsDatasource (SharedPreferences)
- Simple pass-through methods

---

## ✅ After Writing These 8 Files:

You'll have:
- ✅ Complete repository layer
- ✅ Domain contracts defined
- ✅ Data implementations ready
- ✅ Ready for use cases to use repositories

**Then you can move to:**
- Service Locator setup
- BLoC files
- Screens and widgets

---

## 🎯 Write Order:

1. Repository interfaces (4 files) - Start here
2. Repository implementations (4 files)
3. Then continue with BLoCs

Start writing these files! 🚀

