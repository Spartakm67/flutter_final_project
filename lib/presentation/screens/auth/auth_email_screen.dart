import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_final_project/presentation/screens/categories_screen.dart';
import 'package:provider/provider.dart';

class AuthEmailScreen extends StatefulWidget {
  const AuthEmailScreen({super.key});

  @override
  State<AuthEmailScreen> createState() => _AuthEmailScreenState();
}

class _AuthEmailScreenState extends State<AuthEmailScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLogin = true;
  bool _showSignOut = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    return Scaffold(
      appBar: CustomAppBar(
        title: _isLogin ? 'Login / Авторизація' : 'Sign Up / Реєстрація',
        actions: [
          if (_showSignOut)
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.white,),
              onPressed: authStore.isLoading
                  ? null
                  : () async {
                FocusScope.of(context).unfocus();
                await authStore.signOut();
                _emailController.clear();
                _passwordController.clear();
                setState(() {
                  _showSignOut = false;
                });
              },
            ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Observer(
            builder: (_) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60,),
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  autofocus: true,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    suffixIcon: _passwordController.text.isNotEmpty
                        ? IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    )
                        : null,
                  ),
                  onChanged: (text) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: authStore.isLoading
                      ? null
                      : () async {
                    FocusScope.of(context).unfocus();
                    final email = _emailController.text;
                    final password = _passwordController.text;

                    if (_isLogin) {
                      await authStore.signInWithEmail(email, password);
                      if (authStore.errorMessage == null &&
                          authStore.currentUser != null) {
                        if (context.mounted) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const CategoriesScreen();
                              },
                            ),
                          );
                        }
                      }
                    } else {
                      await authStore.signUpWithEmail(email, password);
                      if (authStore.errorMessage == null) {
                        _emailController.clear();
                        _passwordController.clear();
                        setState(() {
                          _isLogin = true;
                          _showSignOut = true;
                        });
                      }
                    }
                  },
                  child: authStore.isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(_isLogin ? 'Login' : 'Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() => _isLogin = !_isLogin);
                  },
                  child: Text(
                    _isLogin
                        ? 'Create an account'
                        : 'Already have an account? Log in',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final email = _emailController.text.trim();

                    if (email.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter your email')),
                      );
                      return;
                    }

                    final scaffoldMessenger = ScaffoldMessenger.of(context);

                    FocusScope.of(context).unfocus();
                    await authStore.resetPassword(email);

                    if (authStore.errorMessage != null) {
                      scaffoldMessenger.showSnackBar(
                        SnackBar(content: Text(authStore.errorMessage!)),
                      );
                    }
                  },
                  child: const Text('Forgot Password?'),
                ),
                if (authStore.errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: Text(
                      authStore.errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
