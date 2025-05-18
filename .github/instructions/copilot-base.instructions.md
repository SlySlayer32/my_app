---
applyTo: "**"
---
# General Project Context for GitHub Copilot

This is a Flutter project primarily written in Dart.
The project follows a feature-first architecture (e.g., `lib/features/feature_name/`).
State management is primarily handled using the BLoC/Cubit pattern.

## Key Technologies and Libraries
- Flutter (cross-platform UI framework)
- Dart (programming language)
- Firebase (Authentication, Firestore)
- Vertex AI
- `go_router` for navigation
- `get_it` for dependency injection
- `freezed` and `equatable` for data classes and value equality

All code must be null-safe and adhere to the linting rules defined in `analysis_options.yaml`.
The project is structured to support both web and mobile platforms, with a focus on responsive design.

Refer to specific instruction files for details on:
- Code style and formatting (`code-style.instructions.md`)
- Architecture and feature structure (`architecture.instructions.md`)
- State management with BLoC/Cubit (`state-management.instructions.md`)
- Testing guidelines (`testing.instructions.md`)
- Error handling (`error-handling.instructions.md`)
- UI/UX guidelines (`ui-guidelines.instructions.md`)
- Integration with external services (`integrations.instructions.md`)
- Asset and image handling (`assets-handling.instructions.md`)
- Internationalization (`i18n.instructions.md`)
