# Cash Flow Test Suite

## Overview
This directory contains comprehensive unit and integration tests for the Cash Flow Manager application, following Clean Architecture principles.

## Test Structure

```
test/
├── helpers/
│   ├── test_helpers.dart          # Test helper utilities for creating test entities
│   └── mock_repositories.mocks.dart # Generated mocks for repositories
├── domain/
│   ├── usecases/
│   │   ├── transaction/           # Transaction use case tests
│   │   ├── auth/                  # Authentication use case tests
│   │   └── category/              # Category use case tests
│   └── facades/                   # Facade pattern tests
├── core/
│   └── utils/                     # Utility class tests
└── presentation/
    └── bloc/                      # BLoC state management tests
```

## Running Tests

### Run all tests
```bash
flutter test
```

### Run specific test file
```bash
flutter test test/domain/usecases/transaction/add_transaction_test.dart
```

### Run tests with coverage
```bash
flutter test --coverage
```

### Generate test coverage report
```bash
genhtml coverage/lcov.info -o coverage/html
```

## Test Categories

### Unit Tests
- **Use Cases**: Test business logic in isolation with mocked repositories
- **Utilities**: Test helper functions and utility classes
- **Facades**: Test facade pattern implementations

### BLoC Tests
- **State Management**: Test BLoC state transitions and events
- **Error Handling**: Test error scenarios and edge cases

## Test Helpers

The `TestHelpers` class provides factory methods for creating test entities:
- `createTransaction()` - Create test transaction entities
- `createCategory()` - Create test category entities
- `createUser()` - Create test user entities
- `createCashFlowSummary()` - Create test summary entities

## Mocking

We use `mockito` for creating mocks and `build_runner` to generate mock classes:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

## Best Practices

1. **Isolation**: Each test should be independent and not rely on other tests
2. **Arrange-Act-Assert**: Follow the AAA pattern for clear test structure
3. **Naming**: Use descriptive test names that explain what is being tested
4. **Coverage**: Aim for high test coverage, especially for business logic
5. **Mocks**: Use mocks for external dependencies to ensure unit test isolation

## Continuous Integration

Tests should pass in CI/CD pipelines before code can be merged. All tests must:
- Pass successfully
- Have meaningful assertions
- Follow Clean Architecture principles
- Not depend on external services or databases

