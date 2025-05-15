import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:my_app/features/authentication/domain/models/auth_state.dart';
import 'package:my_app/features/authentication/domain/repositories/auth_repository.dart';
import 'package:my_app/features/authentication/presentation/cubit/auth_cubit.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('AuthCubit', () {
    late AuthRepository authRepository;
    late StreamController<bool> authStateController;

    setUp(() {
      authRepository = MockAuthRepository();
      authStateController = StreamController<bool>.broadcast();

      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => authStateController.stream);
      when(() => authRepository.getCurrentUserId()).thenReturn(null);
    });

    tearDown(() {
      authStateController.close();
    });

    test('emits unauthenticated state after initialization', () async {
      // Create a controller that doesn't emit anything so we can verify the initial state
      final delayedController = StreamController<bool>.broadcast();
      when(() => authRepository.authStateChanges)
          .thenAnswer((_) => delayedController.stream);

      final authCubit = AuthCubit(authRepository);

      // Initial state should be initial
      expect(authCubit.state, const AuthState.initial());

      // After receiving false from the stream, state should be unauthenticated
      delayedController.add(false);
      await Future<void>.delayed(const Duration(milliseconds: 10));
      expect(authCubit.state, const AuthState.unauthenticated());

      delayedController.close();
      authCubit.close();
    });

    blocTest<AuthCubit, AuthState>(
      'emits [loading, authenticated] when sign in succeeds',
      build: () {
        when(
          () => authRepository.signInWithEmailAndPassword(
            any(),
            any(),
          ),
        ).thenAnswer((_) async {
          // Simulate auth state changing to authenticated after sign in
          await Future<void>.delayed(const Duration(milliseconds: 10));
          when(() => authRepository.getCurrentUserId())
              .thenReturn('test-user-id');
          authStateController.add(true);
        });
        return AuthCubit(authRepository);
      },
      act: (cubit) => cubit.signInWithEmailAndPassword(
        'test@example.com',
        'password',
      ),
      wait: const Duration(milliseconds: 50), // Wait for all async operations
      expect: () => [
        const AuthState.loading(),
        const AuthState.authenticated('test-user-id'),
      ],
    );

    blocTest<AuthCubit, AuthState>(
      'emits [loading, error] when sign in fails',
      build: () {
        when(
          () => authRepository.signInWithEmailAndPassword(
            any(),
            any(),
          ),
        ).thenThrow(Exception('Sign in failed'));
        return AuthCubit(authRepository);
      },
      act: (cubit) => cubit.signInWithEmailAndPassword(
        'test@example.com',
        'password',
      ),
      expect: () => [
        const AuthState.loading(),
        const AuthState.error('Exception: Sign in failed'),
      ],
    );
  });
}
