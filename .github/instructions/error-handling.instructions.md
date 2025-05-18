---
applyTo: "**/*.dart"
---
# Error Handling Guidelines

## General Strategy
- Catch specific exceptions rather than generic `Exception` or `Error` where possible.
- For operations that can fail (e.g., repository calls), consider returning a `Result` type (e.g., using `package:multiple_result` or a custom sealed class) to clearly distinguish success from failure.
- Use typed exceptions to provide more context about errors.

## User Feedback
- Display errors to users gracefully using:
  - SnackBars for non-critical errors
  - Dialogs for errors requiring user attention
  - Dedicated error widgets for content loading failures
- Avoid showing raw exception messages to users.
- Provide clear, actionable error messages.

## Logging
- Log errors with sufficient context:
  - Error message
  - Stack trace
  - Relevant state/data
- Use `package:logging` or similar structured logging approach.
- Consider different log levels based on error severity.

## Error Handling in Different Layers

### Data Layer
- Handle network errors, timeout exceptions, and data parsing issues.
- Transform external exceptions into application-specific exceptions.
- Implement retry mechanisms where appropriate.

### Domain Layer
- Define business-specific exceptions.
- Validate business rules and throw appropriate exceptions.
- Use Result types for operations that can have multiple failure modes.

### Presentation Layer
- Catch and transform errors into user-friendly messages.
- Update UI state to reflect error conditions.
- Provide recovery options when possible.

## Exception Hierarchy
Consider defining a clear exception hierarchy for your application:
- `AppException` as a base class
- Specialized exceptions like `NetworkException`, `ValidationException`, etc.

## Async Error Handling
- Always handle potential errors in asynchronous operations using `try-catch` blocks with `await`.
- For `Future` chains, use `.catchError()` to handle errors.
- For `Stream`s, consider using `Stream.handleError()` or try-catch in `await for` loops.
