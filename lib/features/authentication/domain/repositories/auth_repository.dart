abstract class AuthRepository {
  /// Sign in with email and password
  Future<void> signInWithEmailAndPassword(String email, String password);

  /// Sign up with email and password
  Future<void> signUpWithEmailAndPassword(String email, String password);

  /// Sign out the current user
  Future<void> signOut();

  /// Get the current user's ID
  String? getCurrentUserId();

  /// Stream of authentication state changes
  Stream<bool> get authStateChanges;
}
