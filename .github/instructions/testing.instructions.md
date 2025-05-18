---
applyTo: "**/*_test.dart"
---
# Testing Guidelines

## Types of Tests

### Unit Tests
- For testing individual functions, methods, or classes (e.g., BLoC/Cubit logic, utility functions).
- Use `package:test` and `package:bloc_test`.
- Focus on testing business logic in isolation.

### Widget Tests
- For testing individual widgets.
- Use `package:flutter_test`.
- Verify widget rendering, behavior, and interactions.

### Integration Tests
- For testing complete features or user flows.
- Test how multiple components work together.

## Test Organization
- **Location:** Place test files in a `test/` directory that mirrors the `lib/` directory structure.
  - Example: For `lib/features/auth/presentation/bloc/auth_bloc.dart`, create `test/features/auth/presentation/bloc/auth_bloc_test.dart`.
- **Naming:** Test files should end with `_test.dart`.
- **Structure:** Use `group` to organize related tests, and provide clear, descriptive test names.

## Mocking
- Use `package:mockito` for creating mock dependencies.
- Generate mocks using `build_runner` when appropriate.
- Consider `package:mocktail` as an alternative that doesn't require code generation.

## Best Practices
- Follow the Arrange-Act-Assert pattern:
  - Arrange: Set up the test environment
  - Act: Execute the code to be tested
  - Assert: Verify the expected behavior
- Test edge cases and error scenarios, not just the happy path.
- Keep tests independent from each other.
- Avoid testing implementation details; focus on behavior.
- Write readable test descriptions that describe the expected behavior.
- Aim for high test coverage but prioritize critical and complex components.
- Ensure tests run quickly to encourage frequent execution during development.
