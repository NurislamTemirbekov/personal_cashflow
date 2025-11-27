# Next Files to Write - Complete Guide

Here's what you should write next, in the correct order:

---

## ✅ What You've Completed:

- ✅ Core layer (theme, constants, utils)
- ✅ Domain entities (Transaction, Category, User, CashFlowSummary)
- ✅ Domain use cases (all use cases)
- ✅ Domain hash service
- ✅ Data models (all 4 models)
- ✅ Data sources (all 4 data sources)
- ✅ Database setup

---

## 📝 What to Write Next (In Order):

### **Phase 1: Repository Interfaces (Domain Layer)**

These define the contracts that repositories must implement.

#### **File 1: `lib/domain/repositories/transaction_repository.dart`**

**Why first?** Core repository, most important.

**What to write:**
- Abstract class defining methods for transaction operations
- Methods: `addTransaction()`, `getTransactions()`, `deleteTransaction()`, `getCashFlowSummary()`
- Returns domain entities (Transaction, CashFlowSummary)

**Used by:** Transaction use cases

---

#### **File 2: `lib/domain/repositories/category_repository.dart`**

**What to write:**
- Abstract class for category operations
- Methods: `getCategories()`, `getCategoryById()`
- Returns Category entities

**Used by:** Category use cases

---

#### **File 3: `lib/domain/repositories/auth_repository.dart`**

**What to write:**
- Abstract class for authentication operations
- Methods: `register()`, `login()`, `logout()`, `getCurrentUser()`
- Returns User entity or authentication results

**Used by:** Auth use cases

---

#### **File 4: `lib/domain/repositories/settings_repository.dart`**

**What to write:**
- Abstract class for settings operations
- Methods: `changeLanguage()`, `updateAvatar()`, `getLanguage()`, `getAvatarPath()`
- Handles settings persistence

**Used by:** Settings use cases

---

### **Phase 2: Repository Implementations (Data Layer)**

These implement the repository interfaces using data sources.

#### **File 5: `lib/data/repositories/transaction_repository_impl.dart`**

**What to write:**
- Implements TransactionRepository interface
- Uses TransactionDataSource
- Converts models to entities
- Implements: `addTransaction()`, `getTransactions()`, `deleteTransaction()`, `getCashFlowSummary()`

**Key pattern:**
- Data source returns models → Convert to entities → Return to use case

---

#### **File 6: `lib/data/repositories/category_repository_impl.dart`**

**What to write:**
- Implements CategoryRepository interface
- Uses CategoryDataSource
- Converts CategoryModel to Category entity

---

#### **File 7: `lib/data/repositories/auth_repository_impl.dart`**

**What to write:**
- Implements AuthRepository interface
- Uses UserDataSource + HashService
- Handles password hashing for registration
- Handles password verification for login

---

#### **File 8: `lib/data/repositories/settings_repository_impl.dart`**

**What to write:**
- Implements SettingsRepository interface
- Uses SettingsDataSource (SharedPreferences)

---

### **Phase 3: Dependency Injection Setup**

#### **File 9: `lib/core/di/service_locator.dart`**

**What to write:**
- Setup function that registers all dependencies
- Create data sources
- Create repositories (using data sources)
- Create use cases (using repositories)
- Create BLoCs (using use cases)
- Return instances for dependency injection

---

### **Phase 4: BLoC Files (Presentation Layer)**

After repositories are done, write BLoCs that use use cases.

#### **Files 10-13: BLoC Events**

**Files to write:**
- `lib/presentation/bloc/auth/auth_event.dart`
- `lib/presentation/bloc/cashflow/cashflow_event.dart`
- `lib/presentation/bloc/category/category_event.dart`
- `lib/presentation/bloc/settings/settings_event.dart`

**What to write:**
- Event classes extending Equatable
- Events like: `AuthLoginEvent`, `LoadTransactionsEvent`, etc.

---

#### **Files 14-17: BLoC States**

**Files to write:**
- `lib/presentation/bloc/auth/auth_state.dart`
- `lib/presentation/bloc/cashflow/cashflow_state.dart`
- `lib/presentation/bloc/category/category_state.dart`
- `lib/presentation/bloc/settings/settings_state.dart`

**What to write:**
- State classes extending Equatable
- States like: `AuthLoading`, `AuthSuccess`, `AuthError`, etc.

---

#### **Files 18-21: BLoC Classes**

**Files to write:**
- `lib/presentation/bloc/auth/auth_bloc.dart`
- `lib/presentation/bloc/cashflow/cashflow_bloc.dart`
- `lib/presentation/bloc/category/category_bloc.dart`
- `lib/presentation/bloc/settings/settings_bloc.dart`

**What to write:**
- BLoC classes extending `Bloc<Event, State>`
- Handle events
- Call use cases
- Emit states

---

### **Phase 5: Screens & Widgets (Presentation Layer)**

#### **Files 22-26: Screens**

- Login screen
- Register screen
- Home screen
- Settings screen
- Splash screen

#### **Files 27-32: Widgets**

- Cash flow summary card
- Transaction list
- Transaction item
- Minimalist chart
- Transaction entry sheet
- Category picker
- Avatar picker

---

## 🎯 Immediate Next Steps (Start Here):

### **Step 1: Write Repository Interfaces (4 files)**

These are abstract classes that define contracts. They're simple - just method signatures.

**Start with:** `transaction_repository.dart`

**Then:** category, auth, settings repositories

---

### **Step 2: Write Repository Implementations (4 files)**

These implement the interfaces using your data sources.

**Start with:** `transaction_repository_impl.dart`

**Then:** category, auth, settings repository implementations

---

### **Step 3: Setup Dependency Injection**

Complete `service_locator.dart` to wire everything together.

---

## 📋 Quick Reference: File Priority

**High Priority (Do First):**
1. Repository interfaces (domain) - 4 files
2. Repository implementations (data) - 4 files
3. Service locator setup

**Medium Priority (After Repos):**
4. BLoC events (4 files)
5. BLoC states (4 files)
6. BLoC classes (4 files)

**Lower Priority (UI Layer):**
7. Screens (5 files)
8. Widgets (7+ files)
9. Main.dart setup

---

## 🔗 Dependencies Flow

```
Use Cases (need) → Repository Interfaces
    ↓
Repository Implementations (use) → Data Sources
    ↓
BLoCs (use) → Use Cases
    ↓
Screens/Widgets (use) → BLoCs
```

**Write in this order to avoid missing dependencies!**

---

## 💡 Recommendation

**Start with Repository Interfaces** - They're simple abstract classes and will help you understand what repositories need to provide.

Would you like me to provide the code for the repository interfaces first?

