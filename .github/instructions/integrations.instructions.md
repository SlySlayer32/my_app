---
applyTo: "**/*.dart"
---
# External Integrations Guidelines

## Firebase Integration

### Authentication
- Use `FirebaseAuth` via `AuthRepository`.
- Implement proper sign-in, sign-out, and account management flows.
- Handle authentication states consistently throughout the app.
- Support multiple authentication methods as required (email/password, OAuth, etc.).

### Firestore
- Structure data in these main collections:
  - `users`
  - `images`
  - `markings`
  - `processResults`
- Use transactions for related operations to maintain data consistency.
- Follow Firestore best practices for querying and indexing.
- Implement proper data validation and security rules.

### Firebase Storage
- Follow the storage structure pattern: `/users/{userId}/images/{imageId}`
- Implement proper upload/download progress indicators.
- Handle storage errors gracefully.

## Vertex AI Integration
- Interact with Vertex AI via the `VertexAiService` wrapper.
- Handle synchronous and asynchronous API calls appropriately.
- Implement error handling and retry mechanisms as defined.
- Process AI responses appropriately for UI presentation.

## API Integration Best Practices
- Use repository pattern to abstract data sources.
- Implement proper caching strategies.
- Handle network connectivity issues gracefully.
- Monitor API rate limits.
- Implement request timeouts and retry logic.

## Local Storage
- Use appropriate storage mechanisms based on data type and sensitivity:
  - Secure storage for sensitive information
  - Shared preferences for user settings
  - Local database for structured data
  - File system for larger assets

## Background Processing
- For long-running operations, consider using isolates or background services.
- Provide user feedback for background operations.
- Handle app lifecycle changes appropriately.
