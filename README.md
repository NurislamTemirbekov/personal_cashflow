# Cash Flow Manager

A comprehensive personal finance management application built with Flutter, following Clean Architecture principles, SOLID design patterns, and modern software engineering best practices.

## 📱 Purpose

Cash Flow Manager is a mobile application designed to help users track their income and expenses efficiently. The app provides:

- **Income Management**: Track and manage monthly salary and investments
- **Expense Tracking**: Monitor spending across multiple categories (Transport, Investment, Education, Foods, Gym, Clothes, Bills, Debts)
- **Visual Analytics**: Interactive PieChart visualization of expense distribution
- **Monthly Reports**: Generate and print detailed financial reports in check-style format
- **Report History**: Access and review past monthly reports
- **User Profile**: Manage user account with avatar customization
- **Theme Support**: Light and dark mode for comfortable viewing
- **Data Persistence**: Local SQLite database for offline access

## 🏗️ Architecture

This project follows **Clean Architecture** principles with clear separation of concerns across three main layers:

### Architecture Layers

```
┌─────────────────────────────────────────┐
│         Presentation Layer              │
│  (BLoC Pattern, Screens, Widgets)      │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│           Domain Layer                  │
│  (Entities, Use Cases, Repositories)   │
└─────────────────────────────────────────┘
                  ↓
┌─────────────────────────────────────────┐
│            Data Layer                   │
│  (Data Sources, Models, Implementations)│
└─────────────────────────────────────────┘
```

### Layer Details

#### 1. **Domain Layer** (Business Logic)
- **Entities**: Pure Dart classes representing business objects
  - `Transaction`, `Category`, `User`, `CashFlowSummary`
- **Repositories**: Abstract interfaces defining data contracts
  - `TransactionRepository`, `CategoryRepository`, `AuthRepository`, `SettingsRepository`
- **Use Cases**: Single-purpose business logic operations
  - Transaction: Add, Delete, Get, GetSummary
  - Auth: Login, Register, Logout
  - Category: GetCategories
  - Settings: UpdateAvatar
- **Services**: Domain-specific services
  - `HashService` for password hashing
- **Facades**: Simplified interfaces for complex operations
  - `CashFlowFacade` provides unified access to financial operations

#### 2. **Data Layer** (Data Management)
- **Data Sources**: Direct database/file operations
  - `TransactionDatasource`, `CategoryDatasource`, `UserDataSource`, `SettingsDatasource`
  - SQLite database using `sqflite`
  - SharedPreferences for settings
- **Models**: Data Transfer Objects (DTOs)
  - Convert between database format and domain entities
  - `TransactionModel`, `CategoryModel`, `UserModel`, `CashFlowSummaryModel`
- **Repository Implementations**: Concrete implementations of domain repositories
  - `TransactionRepositoryImpl`, `CategoryRepositoryImpl`, etc.

#### 3. **Presentation Layer** (UI)
- **BLoC Pattern**: State management using `flutter_bloc`
  - `AuthBloc`, `CashFlowBloc`, `CategoryBloc`, `SettingsBloc`
- **Screens**: Full-page UI components
  - Auth: Login, Register
  - Home: Main dashboard with transactions
  - Profile: User profile management
  - Reports: Monthly reports and history
- **Widgets**: Reusable UI components
  - `CashFlowSummaryCard`, `ExpenseRadarChart`, `CheckStyleReport`
- **Routes**: Navigation configuration

#### 4. **Core Layer** (Shared Infrastructure)
- **Dependency Injection**: GetIt service locator
- **Theme**: App-wide styling and colors
- **Constants**: Centralized constants
- **Utils**: Reusable utility functions
  - `ExpenseCalculator`, `DateFormatter`, `Validators`, `NumberToWords`

## 🛠️ Technologies & Tools

### Core Framework
- **Flutter SDK**: ^3.9.2
- **Dart**: Modern object-oriented programming language

### State Management
- **flutter_bloc**: ^9.1.1 - BLoC pattern implementation for predictable state management
- **equatable**: ^2.0.7 - Value equality comparison for objects

### Database & Storage
- **sqflite**: ^2.4.2 - SQLite database for local data persistence
- **shared_preferences**: ^2.5.3 - Key-value storage for settings and preferences
- **path_provider**: ^2.1.5 - File system path utilities
- **path**: ^1.9.0 - Path manipulation utilities

### Dependency Injection
- **get_it**: ^8.0.2 - Service locator for dependency injection

### UI & Visualization
- **fl_chart**: ^1.1.1 - Beautiful charts (PieChart) for data visualization
- **cupertino_icons**: ^1.0.8 - iOS-style icons

### Utilities
- **uuid**: ^4.5.2 - Unique identifier generation
- **crypto**: ^3.0.7 - Cryptographic functions (password hashing)
- **intl**: ^0.20.2 - Internationalization and localization
- **image_picker**: ^1.2.1 - Image selection for avatar

### Reporting
- **printing**: ^5.14.2 - Print and share documents
- **pdf**: ^3.11.3 - PDF document generation
- **signature**: ^5.4.0 - Signature capture for reports

### Development Tools
- **flutter_lints**: ^5.0.0 - Linting rules for Flutter
- **flutter_launcher_icons**: ^0.13.1 - Generate app icons for all platforms
- **build_runner**: ^2.7.1 - Code generation
- **bloc_test**: ^10.0.0 - Testing utilities for BLoC
- **mockito**: ^5.5.0 - Mocking framework for testing

## 📋 Design Patterns

### 1. Clean Architecture
- Strict dependency rule: dependencies point inward
- Business logic independent of frameworks and UI
- Testable and maintainable codebase

### 2. SOLID Principles
- **Single Responsibility**: Each class has one reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Implementations can be substituted
- **Interface Segregation**: Focused, specific interfaces
- **Dependency Inversion**: Depend on abstractions, not concretions

### 3. DRY (Don't Repeat Yourself)
- Reusable utility classes (`ExpenseCalculator`, `DateFormatter`)
- Centralized constants and configuration
- Shared validation logic

### 4. Facade Pattern
- `CashFlowFacade` simplifies complex subsystem interactions
- Provides unified interface to multiple use cases
- Reduces coupling between layers

### 5. Repository Pattern
- Abstraction layer for data access
- Allows easy swapping of data sources
- Centralized data access logic

### 6. BLoC Pattern
- Separation of business logic from UI
- Predictable state management
- Testable and maintainable UI logic

## 📁 Project Structure

```
lib/
├── core/                      # Shared infrastructure
│   ├── constants/            # App constants
│   ├── di/                   # Dependency injection
│   ├── services/             # Shared services
│   ├── theme/                # Theming configuration
│   └── utils/                # Utility functions
│
├── domain/                   # Business logic layer
│   ├── entities/             # Business objects
│   ├── facades/              # Facade pattern
│   ├── repositories/         # Repository interfaces
│   ├── services/             # Domain services
│   └── usecases/             # Business use cases
│
├── data/                     # Data layer
│   ├── datasources/          # Data sources
│   ├── models/               # Data models
│   └── repositories/         # Repository implementations
│
├── presentation/             # UI layer
│   ├── bloc/                 # State management
│   ├── routes/               # Navigation
│   ├── screens/              # App screens
│   └── widgets/              # Reusable widgets
│
└── main.dart                 # Application entry point
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (^3.9.2)
- Dart SDK
- Android Studio / Xcode (for mobile development)
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd cash_flow
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate app icons** (if needed)
   ```bash
   flutter pub run flutter_launcher_icons
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Features

### Core Features
- ✅ User authentication (Login/Register)
- ✅ Transaction management (Add/Delete)
- ✅ Category-based expense tracking
- ✅ Monthly financial summaries
- ✅ Interactive expense charts
- ✅ Check-style monthly reports
- ✅ Report history
- ✅ User profile with avatar
- ✅ Dark/Light theme toggle

### Categories
**Income:**
- Salary
- Investment

**Expenses:**
- Transport
- Investment
- Education
- Foods
- Gym
- Clothes
- Bills
- Debts

## 🔒 Security

- Password hashing using cryptographic algorithms
- Local data storage with SQLite
- Secure user session management

## 📊 Data Model

### Entities
- **User**: User account information
- **Transaction**: Financial transaction record
- **Category**: Expense/Income category
- **CashFlowSummary**: Monthly financial summary

### Database Schema
- Users table: User accounts and credentials
- Transactions table: Transaction records
- Categories table: Predefined categories
- Settings: User preferences and settings

## 🧪 Testing

The project structure supports:
- Unit testing for use cases
- Widget testing for UI components
- Integration testing for repositories
- BLoC testing with `bloc_test`

## 📝 Code Quality

- ✅ Follows Flutter style guide
- ✅ Linting enabled with `flutter_lints`
- ✅ Clean Architecture compliance
- ✅ SOLID principles applied
- ✅ DRY principle followed
- ✅ No code duplication
- ✅ Well-documented code structure

## 🔄 Version

**Current Version**: 1.0.0+1

## 📄 License

This project is proprietary and confidential.

## 👥 Development

Built following industry best practices:
- Clean Architecture
- SOLID principles
- Design patterns (Facade, Repository, BLoC)
- Testable and maintainable code
- Scalable architecture

## 🎯 Future Enhancements

Potential features for future versions:
- Cloud synchronization
- Multi-currency support
- Budget planning
- Export to Excel/CSV
- Recurring transactions
- Category customization

---

**Status**: Production Ready ✅

**Architecture Quality**: Excellent ⭐⭐⭐⭐⭐
