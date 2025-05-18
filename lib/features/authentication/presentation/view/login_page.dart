import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/features/authentication/domain/models/auth_state.dart';
import 'package:my_app/features/authentication/presentation/cubit/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          state.maybeWhen(
            authenticated: (_) {
              context.go('/home');
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message)),
              );
            },
            orElse: () {},
          );
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    if (state.maybeWhen(
                      loading: () => true,
                      orElse: () => false,
                    )) ...[
                      const Center(child: CircularProgressIndicator()),
                    ] else ...[
                      ElevatedButton(
                        onPressed: _handleLogin,
                        child: const Text('Login'),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          context.go('/signup');
                        },
                        child: const Text('Create Account'),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue.shade300,
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Semantics(
                          label: 'Skip login and go to dashboard',
                          hint: 'Development mode only',
                          button: true,
                          child: TextButton.icon(
                            onPressed: () => context.go('/dashboard'),
                            icon: const Icon(Icons.skip_next, size: 24),
                            label: const Text(
                              'Skip (Dev Mode)',
                              style: TextStyle(fontSize: 16),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.blue.shade700,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<AuthCubit>().signInWithEmailAndPassword(
            _emailController.text,
            _passwordController.text,
          );
    }
  }
}
