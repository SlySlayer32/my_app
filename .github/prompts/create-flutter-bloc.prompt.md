---
mode: 'agent'
description: 'Generate a new Flutter BLoC/Cubit adhering to project standards.'
# tools: ['codebase']
---
Generate a new BLoC/Cubit for state management.

**BLoC/Cubit Name:** ${input:blocName}
**Feature:** (e.g., auth, camera, image_marking, processing) ${input:featureName}
**Purpose/Description:** ${input:blocPurpose}

**Requirements:**
1.  Create three files in `lib/features/${input:featureName}/presentation/bloc/${input:blocNameSnakeCase_lowercase}/`:
    *   `${input:blocNameSnakeCase_lowercase}_bloc.dart` (or `_cubit.dart`)
    *   `${input:blocNameSnakeCase_lowercase}_event.dart` (if BLoC)
    *   `${input:blocNameSnakeCase_lowercase}_state.dart`
2.  **Events (for BLoC):**
    *   Define events that extend `Equatable`.
    *   Events should represent user actions or system occurrences.
    *   Example: `final class ${input:EventName} extends ${input:blocName}Event { ... }`
3.  **States:**
    *   Define states that extend `Equatable`.
    *   States should represent the UI state (e.g., Initial, Loading, Success, Failure).
    *   Include necessary data in success/loaded states.
    *   Example: `sealed class ${input:blocName}State extends Equatable { ... }`
    *   `final class ${input:blocName}Initial extends ${input:blocName}State { ... }`
    *   `final class ${input:blocName}Loading extends ${input:blocName}State { ... }`
    *   `final class ${input:blocName}Success extends ${input:blocName}State { final Data data; ... }`
    *   `final class ${input:blocName}Failure extends ${input:blocName}State { final String error; ... }`
4.  **BLoC/Cubit Logic:**
    *   The BLoC should take necessary use cases or repositories as dependencies via its constructor.
    *   Implement event handlers (for BLoC) or methods (for Cubit) to process logic and emit new states.
    *   Use `on<Event>((event, emit) async { ... });` for event mapping in BLoCs.
    *   Ensure proper error handling and emit failure states with error messages.
5.  **Dependencies:**
    *   Inject dependencies (e.g., UseCases, Repositories) through the constructor.
    *   These dependencies will be provided by `get_it`.
6.  Follow all relevant guidelines from `../instructions/flutter-dart.instructions.md` and project architecture guidelines (see `docs/ARCHITECTURE.md`).
7.  Use `equatable` for props in events and states.
