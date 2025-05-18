---
applyTo: "**/*.dart"
---
# Dart & Flutter Coding Standards

## General Dart Style
- Use `final` for variables that will not be reassigned after initialization.
- Use `const` for compile-time constants, including widget constructors where possible.
- Follow the Effective Dart style guide: [https://dart.dev/guides/language/effective-dart/style](https://dart.dev/guides/language/effective-dart/style)
- Utilize `equatable` for value equality in models and states.
- Use `freezed_annotation` or `json_annotation` for model classes that require serialization/deserialization.

## Asynchronous Programming Best Practices
- **`async/await`:** Use `async` and `await` consistently for `Future`-based operations to improve readability.
- **Error Handling:** Always handle potential errors in asynchronous operations using `try-catch` blocks with `await`, or by using `.catchError()` on `Future`s.
- **`StreamSubscription` Management:** When subscribing to `Stream`s, always cancel the `StreamSubscription` in the `dispose()` method (or `close()` method for BLoCs/Cubits) to prevent memory leaks.

## Linting and Code Formatting
- **Formatting:** Run `dart format .` on your code before committing to ensure consistent style.
- **Analysis:** Adhere strictly to the linting rules defined in `analysis_options.yaml`. All analyzer warnings and errors must be addressed.
- **Suppressing Rules:** Avoid suppressing lint rules. If absolutely necessary for a specific, justified case, use `// ignore: lint_rule` for a single line or `// ignore_for_file: lint_rule` for an entire file, accompanied by a comment explaining the reason.

## Code Comments and Documentation
- **When to Comment:**
  - Explain complex or non-obvious logic.
  - Document important decisions or workarounds.
- **Dartdoc:** Use `///` Dartdoc comments for all public APIs (classes, methods, functions, top-level variables). Ensure descriptions are clear and parameters/return values are explained.
- **Project Documentation:** Update relevant project documentation when code changes impact broader architecture or development processes.

## Security Considerations
- **Secrets Management:** Avoid hardcoding API keys, credentials, or other sensitive information directly in the source code.
- **Input Sanitization:** Be mindful of user-generated content. Sanitize inputs if they are to be displayed in HTML-like contexts or used in constructing queries.
- **Firebase Security:** Ensure Firebase Firestore/Storage security rules are appropriately configured to protect data.
- **Data Privacy:** Handle user data responsibly and in accordance with privacy best practices and any applicable regulations.
- **Dependencies:** Regularly review and update dependencies to patch known vulnerabilities.
