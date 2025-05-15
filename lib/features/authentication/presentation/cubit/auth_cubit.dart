import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/authentication/domain/models/auth_state.dart';
import 'package:my_app/features/authentication/domain/repositories/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._authRepository) : super(const AuthState.initial()) {
    _authStateSubscription = _authRepository.authStateChanges.listen(
      (isAuthenticated) {
        if (isAuthenticated) {
          final userId = _authRepository.getCurrentUserId();
          if (userId != null) {
            emit(AuthState.authenticated(userId));
          }
        } else {
          emit(const AuthState.unauthenticated());
        }
      },
    );
  }
  final AuthRepository _authRepository;
  StreamSubscription<bool>? _authStateSubscription;

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      emit(const AuthState.loading());
      await _authRepository.signInWithEmailAndPassword(email, password);
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    try {
      emit(const AuthState.loading());
      await _authRepository.signUpWithEmailAndPassword(email, password);
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      emit(const AuthState.loading());
      await _authRepository.signOut();
    } catch (e) {
      emit(AuthState.error(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authStateSubscription?.cancel();
    return super.close();
  }
}
