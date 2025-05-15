import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:my_app/features/authentication/presentation/view/login_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) async {
        final authState = context.read<AuthCubit>().state;
        return authState.maybeWhen(
          authenticated: (_) => '/home',
          orElse: () => '/login',
        );
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Scaffold(
        body: Center(child: Text('Home')),
      ),
      redirect: (context, state) {
        final authState = context.read<AuthCubit>().state;
        return authState.maybeWhen(
          unauthenticated: () => '/login',
          orElse: () => null,
        );
      },
    ),
  ],
);
