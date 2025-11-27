# Cash Flow Manager

A minimalist personal finance management application built with Flutter. Track your income and expenses, visualize your cash flow, and manage your financial data with ease.

## 📱 Features

- **User Authentication**: Secure login and registration with password hashing
- **Transaction Management**: Add, view, and delete income/expense transactions
- **Category System**: Organize transactions by categories (Salary, Food, Transport, etc.)
- **Cash Flow Dashboard**: View income, expenses, and net flow at a glance
- **Visual Charts**: Minimalist charts showing monthly cash flow trends
- **Settings**: Customize language (English/Russian), avatar, and app preferences
- **Offline First**: All data stored locally on device

## 🏗️ Architecture

This project follows **Clean Architecture** principles with **BLoC** pattern for state management:

```
┌─────────────────────────────────────┐
│     Presentation Layer (UI)         │
│   - BLoCs, Widgets, Screens         │
├─────────────────────────────────────┤
│      Domain Layer (Business)        │
│   - Entities, Use Cases, Repos      │
├─────────────────────────────────────┤
│       Data Layer (Storage)          │
│   - Models, Data Sources, Repos     │
└─────────────────────────────────────┘
```

### Layer Responsibilities

- **Presentation Layer**: UI components, BLoC state management, screens, widgets
- **Domain Layer**: Business logic, entities, use cases, repository interfaces
- **Data Layer**: Data persistence, database operations, model conversions

## 🛠️ Tech Stack & Packages

### State Management
- **flutter_bloc** (^9.1.1) - BLoC pattern for state management
- **equatable** (^2.0.7) - Simplified object comparison for BLoC states/events

### Data Persistence
- **sqflite** (^2.4.2) - SQLite database for local data storage
- **shared_preferences** (^2.5.3) - Key-value storage for app settings
- **path_provider** (^2.1.5) - File system paths for database and files
- **path** (^1.9.0) - Path manipulation utilities

### UI Components
- **fl_chart** (^1.1.1) - Beautiful charts for cash flow visualization
- **image_picker** (^1.2.1) - Pick images from gallery/camera for avatar

### Utilities
- **uuid** (^4.5.2) - Generate unique identifiers for transactions and users
- **crypto** (^3.0.7) - Password hashing (SHA-256) for secure authentication
- **intl** (^0.20.2) - Internationalization and date/number formatting

### Internationalization
- **flutter_localizations** - Built-in Flutter localization support
- **generate: true** - Automatic localization code generation from .arb files

### Development Tools
- **flutter_lints** (^5.0.0) - Dart linting rules
- **bloc_test** (^10.0.0) - Testing utilities for BLoC
- **mockito** (^5.5.0) - Mock objects for unit testing
- **build_runner** (^2.7.1) - Code generation for mocks

## 📁 Project Structure

```
lib/
├── core/                    # Shared utilities
│   ├── constants/          # App constants, database constants
│   ├── di/                 # Dependency injection setup
│   ├── theme/              # App theme and colors
│   └── utils/              # Helper functions (validators, date formatter)
│
├── data/                    # Data Layer
│   ├── datasources/        # Database access (SQLite, SharedPreferences)
│   ├── models/             # Data models (convert between DB and entities)
│   └── repositories/       # Repository implementations
│
├── domain/                  # Domain Layer (Business Logic)
│   ├── entities/           # Business objects (Transaction, User, etc.)
│   ├── repositories/       # Repository interfaces (abstract)
│   ├── services/           # Business services (HashService)
│   └── usecases/           # Use cases (business operations)
│
└── presentation/            # Presentation Layer (UI)
    ├── bloc/               # State management (BLoC)
    ├── screens/            # Full-page widgets
    ├── widgets/            # Reusable UI components
    └── routes/             # Navigation configuration

l10n/                        # Internationalization
├── app_en.arb              # English translations
└── app_ru.arb              # Russian translations
```

## 🗄️ Database Schema

### Tables

**users**
- id (TEXT PRIMARY KEY)
- username (TEXT UNIQUE)
- password_hash (TEXT)
- avatar_path (TEXT)
- created_at (INTEGER)

**transactions**
- id (TEXT PRIMARY KEY)
- user_id (TEXT)
- amount (REAL)
- description (TEXT)
- date (INTEGER)
- category_id (TEXT)
- type (TEXT) - 'income' or 'expense'
- created_at (INTEGER)

**categories**
- id (TEXT PRIMARY KEY)
- name (TEXT)
- icon (TEXT)
- type (TEXT) - 'income' or 'expense'
- created_at (INTEGER)

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (^3.9.2)
- Dart SDK
- Android Studio / VS Code / Xcode (for iOS)

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

3. **Generate localization files** (if using .arb files)
   ```bash
   flutter gen-l10n
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Web (for future Telegram Mini App integration)
- ✅ macOS
- ✅ Linux
- ✅ Windows

## 🌍 Internationalization

The app supports multiple languages:
- English (en)
- Russian (ru)

Language preference is saved in SharedPreferences and persists across app restarts.

## 🔐 Security Features

- Password hashing using SHA-256 algorithm
- Local data storage (no data leaves device)
- Secure user authentication
- SQL injection prevention (parameterized queries)

## 🎨 Design Principles

- **Minimalist Design**: Clean, uncluttered interface
- **Visual Distinction**: Clear color coding for income (green) and expenses (red)
- **Intuitive Navigation**: Bottom navigation bar for easy access
- **Fast Interactions**: Quick transaction entry via bottom sheet
- **Swipe to Delete**: Familiar gesture for transaction removal

## 📊 Features Breakdown

### Home Dashboard
- Cash flow summary (Income, Expenses, Net Flow)
- Minimalist chart showing monthly trends
- Transaction list with swipe-to-delete
- Quick add button (FloatingActionButton)

### Transaction Entry
- Modal bottom sheet for quick entry
- Amount and description input
- Date picker
- Category selection dropdown
- Form validation

### Settings
- Language switcher (EN/RU)
- Avatar management
- User profile
- Logout functionality

## 🧪 Testing

The project includes setup for:
- Unit tests (use cases, repositories)
- Widget tests (UI components)
- BLoC tests (state management)
- Integration tests (full user flows)

Run tests:
```bash
flutter test
```

## 📦 Key Dependencies Explained

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | Manages app state using BLoC pattern |
| `sqflite` | Stores transactions, categories, users locally |
| `shared_preferences` | Stores user settings (language, avatar path) |
| `fl_chart` | Displays cash flow charts |
| `image_picker` | Allows users to select avatar images |
| `crypto` | Hashes passwords securely |
| `uuid` | Generates unique IDs for entities |
| `intl` | Formats dates and numbers for localization |

## 🔄 Data Flow

1. **User Action** → UI dispatches event
2. **BLoC** receives event → calls use case
3. **Use Case** → calls repository
4. **Repository** → uses data source
5. **Data Source** → queries database
6. **Response flows back** through layers
7. **BLoC emits state** → UI rebuilds

## 📝 Development Notes

- All business logic is in the Domain layer (independent of Flutter)
- Data layer handles all database operations
- Presentation layer only handles UI and state management
- Models convert between database format and domain entities

## 🔮 Future Enhancements

- Telegram Mini App integration
- Multiple currency support
- Export data (CSV, PDF)
- Recurring transactions
- Budget planning
- Dark mode theme

## 📄 License

This project is private and not published.

## 👤 Author

Cash Flow Manager Development Team

---

Built with ❤️ using Flutter
