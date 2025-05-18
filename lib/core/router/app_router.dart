import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:my_app/features/authentication/presentation/view/login_page.dart';
import 'package:my_app/features/dashboard/presentation/view/dashboard_page.dart';
import 'package:my_app/features/camera/presentation/view/camera_preview_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      redirect: (context, state) async {
        final authState = context.read<AuthCubit>().state;
        return authState.maybeWhen(
          authenticated: (_) => '/dashboard',
          orElse: () => '/login',
        );
      },
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
      redirect: (context, state) {
        // Only in production, redirect unauthenticated users
        // For development, allow access via the Skip button
        const isProduction = false; // Set to true for production

        if (!isProduction) {
          return null; // In development, allow access regardless of auth state
        }

        final authState = context.read<AuthCubit>().state;
        return authState.maybeWhen(
          unauthenticated: () => '/login',
          orElse: () => null,
        );
      },
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
    GoRoute(
      path: '/camera',
      builder: (context, state) => const CameraPreviewPage(),
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
