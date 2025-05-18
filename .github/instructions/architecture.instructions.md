---
applyTo: "**/*.dart"
---
# Feature Architecture Guidelines

## Feature Structure
The project follows a feature-first architecture based on Very Good Ventures' Scalable Best Practices:
https://verygood.ventures/blog/scalable-best-practices

## Feature Directory Structure
Each feature directory (e.g., `lib/features/feature_name/`) MUST contain the following sub-directories:

### 1. `data/` (Data Acquisition Layer)
- **Responsibilities:** Handles all raw data acquisition from various sources (APIs, databases, device sensors).
- **Contents:** 
  - Repository implementations (from domain interfaces)
  - Data Transfer Objects (DTOs)
  - Data source contracts and implementations (e.g., `UserApiDataSource`)
- **Example:** Fetching user data from REST API or reading preferences from SharedPreferences.

### 2. `domain/` (Business Rules Layer)
- **Responsibilities:** Contains core business logic, rules, and data models.
- **Must be pure Dart** - independent of Flutter or specific data implementations.
- **Contents:** 
  - Business entities (plain Dart objects)
  - Repository interfaces (contracts for data operations)
  - Use cases/interactors that orchestrate actions
- **Example:** A `GetUserUseCase` that defines how to retrieve a user via a `UserRepository` interface.

### 3. `presentation/` (Application Layer)
- **Responsibilities:** Handles UI elements and application-specific logic, including state management.
- **Contents:**
  - Widgets (UI components)
  - BLoCs/Cubits for state management
  - View models
  - UI-specific helpers
- **Example:** A `UserProfilePage` widget using a `UserProfileBloc` to display user information.

## Dependency Injection
- Use `get_it` for service location and dependency injection as configured in `bootstrap.dart` or feature-specific setup.

## Navigation
- Use `go_router` for all navigation, defined in the main router configuration.
- Prefer strongly-typed objects or primitive types when passing arguments.
- Consider deep linking effects on route parameters and state restoration.
