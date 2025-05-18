---
mode: 'agent'
description: 'Generate a new domain use case adhering to project standards.'
# tools: ['codebase']
---
Generate a new Domain Use Case.

**Use Case Name:** ${input:useCaseName} (e.g., SignIn, GetUserProfile, UploadImage)
**Feature:** (e.g., auth, camera, image_marking, processing) ${input:featureName}
**Purpose/Description:** ${input:useCasePurpose}
**Parameters (if any):** ${input:useCaseParams} (e.g., `String email, String password`)
**Return Type:** ${input:useCaseReturnType} (e.g., `Future<Either<Failure, User>>`, `Future<void>`)

**Requirements:**
1.  Place the use case in `lib/features/${input:featureName}/domain/usecases/${input:useCaseNameSnakeCase}_usecase.dart`.
2.  Create a class named `${input:useCaseNamePascalCase}UseCase`.
3.  The use case should have a single public method, typically `call` or a descriptive name (e.g., `execute`).
    *   Example: `Future<Either<Failure, User>> call(Params params)` or `Future<void> execute({required String email})`.
4.  Inject required repository interfaces from the domain layer via the constructor.
    *   Example: `final ${input:RepositoryInterfaceName} _repository;`
5.  The use case should contain business logic related to the specific task.
6.  It should call methods on the injected repository.
7.  Return types should align with the repository methods, often using `Either<Failure, SuccessType>` for operations that can fail.
8.  If the use case requires parameters, consider creating a simple `Params` class (extending `Equatable`) if there are multiple parameters.
    *   Example:
        ```dart
        class ${input:useCaseNamePascalCase}Params extends Equatable {
          final String email;
          // ... other params

          const ${input:useCaseNamePascalCase}Params({required this.email, ...});

          @override
          List<Object?> get props => [email, ...];
        }
        ```
9.  Follow all relevant guidelines from `../instructions/flutter-dart.instructions.md` and project architecture guidelines (see `docs/ARCHITECTURE.md`).
10. The use case must be pure Dart and have no dependencies on Flutter or external packages beyond what's defined for the domain layer (e.g., `equatable`, `dartz` or similar for `Either`).
