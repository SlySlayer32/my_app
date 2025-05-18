---
applyTo: "**/*bloc.dart,**/*cubit.dart,**/*state.dart,**/*event.dart"
---
# State Management Guidelines (BLoC/Cubit)

## General Principles
- Use BLoC/Cubit pattern for state management as per the architecture.
- States should represent the UI state and be immutable.
- Utilize `equatable` for value equality in states.

## Naming Conventions
- **Events:** Suffix with `Event` (e.g., `LoadUserDataEvent`, `SubmitFormEvent`).
- **States:** Suffix with `State` (e.g., `UserDataLoadingState`, `FormSubmissionSuccessState`).
- **BLoCs:** Suffix with `Bloc` (e.g., `UserProfileBloc`).
- **Cubits:** Suffix with `Cubit` (e.g., `CounterCubit`).

## When to Use BLoC vs. Cubit
- **Cubit:** Use for simpler state logic where states are emitted directly by calling methods.
- **BLoC:** Use for more complex scenarios involving multiple events, intricate state transitions, or when event-to-state mapping benefits from `EventHandler`s.

## Side Effects/One-Time Events
- Handle UI side effects (e.g., showing SnackBars, navigation) using `BlocListener` in the UI layer.
- Avoid emitting states purely for one-time events.
- If necessary, consider a separate `Stream` within the BLoC/Cubit for such events, or use a state property that the UI observes and resets.

## Implementation Best Practices
- Keep BLoCs/Cubits focused on a single responsibility.
- Use `freezed` for immutable state classes when appropriate.
- Inject dependencies rather than creating them within the BLoC/Cubit.
- Test BLoCs/Cubits thoroughly with `bloc_test`.
- Handle errors gracefully and emit appropriate error states.
- Document complex state transitions and event handling.
