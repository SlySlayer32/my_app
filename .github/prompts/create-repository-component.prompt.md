---
mode: 'agent'
description: 'Generate a repository interface and its implementation, or a data source.'
# tools: ['codebase']
---
Generate a new repository component (interface and implementation) or a data source.

**Component Type:** (Repository / DataSource) ${input:componentType}
**Component Name:** ${input:componentName} (e.g., User, Product, Auth)
**Feature:** (e.g., auth, camera, image_marking, processing, core) ${input:featureName}
**Purpose/Description:** ${input:componentPurpose}

**If Repository:**
1.  **Domain Layer Interface:**
    *   Create `lib/features/${input:featureName}/domain/repositories/${input:componentNameSnakeCase}_repository.dart`.
    *   Define an abstract class `${input:componentNamePascalCase}Repository`.
    *   Declare methods representing data operations (e.g., `Future<Either<Failure, User>> getUser(String id);`).
    *   Use `Either` from a functional programming package (if used, otherwise `Future<ResultType>` with custom error handling) for operations that can fail.
2.  **Data Layer Implementation:**
    *   Create `lib/features/${input:featureName}/data/repositories/${input:componentNameSnakeCase}_repository_impl.dart`.
    *   Implement the `${input:componentNamePascalCase}Repository` interface.
    *   Inject necessary data sources (e.g., `RemoteDataSource`, `LocalDataSource`) via the constructor.
    *   Handle data transformations (DTOs to Domain Entities) if applicable.
    *   Implement error handling and map exceptions to `Failure` types.

**If Data Source:**
1.  **Data Layer Abstract Class (Optional but Recommended):**
    *   Create `lib/features/${input:featureName}/data/datasources/${input:componentNameSnakeCase}_datasource.dart`.
    *   Define an abstract class `${input:componentNamePascalCase}DataSource`.
    *   Declare methods for raw data fetching/storing (e.g., `Future<UserModelDto> fetchUser(String id);`).
2.  **Data Layer Implementation(s):**
    *   Create implementations (e.g., `${input:componentNameSnakeCase}_remote_datasource_impl.dart`, `${input:componentNameSnakeCase}_local_datasource_impl.dart`).
    *   Inject dependencies like HTTP clients, database handlers, Firebase services (`FirebaseAuth`, `FirebaseFirestore`, `FirebaseStorage`), or `SharedPreferences`.
    *   Handle API calls, database queries, or local storage operations.
    *   Throw specific exceptions for error conditions.

**General Requirements:**
- Follow all relevant guidelines from `../instructions/flutter-dart.instructions.md`, and refer to project documentation (`docs/ARCHITECTURE.md`, `docs/DEVELOPMENT_GUIDE.md`) for architectural and development practices.
- Ensure methods are asynchronous (`Future`) where appropriate.
- Use DTOs (Data Transfer Objects) in the data layer if transformations are needed before domain entities are created.
- Inject dependencies using constructor injection.
