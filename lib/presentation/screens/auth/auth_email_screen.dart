import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_final_project/domain/store/auth_store/auth_store.dart';
import 'package:flutter_final_project/presentation/widgets/custom_app_bar.dart';
import 'package:flutter_final_project/presentation/widgets/custom_snack_bar.dart';
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

    authStore.showErrorMessage = (message) {
      if (context.mounted) {
        CustomSnackBar.show(
          context: context,
          message: message,
          backgroundColor: Colors.orangeAccent,
          position: SnackBarPosition.top,
          duration: const Duration(seconds: 5),
        );
      }
    };

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

                    if (email.isEmpty) {
                      CustomSnackBar.show(
                        context: context,
                        message: 'Поле Email не може бути порожнім.',
                        backgroundColor: Colors.redAccent,
                        position: SnackBarPosition.top,
                        duration: const Duration(seconds: 3),
                      );
                      return;
                    }
                    if (password.isEmpty) {
                      CustomSnackBar.show(
                        context: context,
                        message: 'Поле Password не може бути порожнім.',
                        backgroundColor: Colors.redAccent,
                        position: SnackBarPosition.top,
                        duration: const Duration(seconds: 3),
                      );
                      return;
                    }
                    if (password.length < 6) {
                      CustomSnackBar.show(
                        context: context,
                        message: 'Пароль має бути довшим за 6 символів.',
                        backgroundColor: Colors.redAccent,
                        position: SnackBarPosition.top,
                        duration: const Duration(seconds: 3),
                      );
                      return;
                    }

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
                      : Text(_isLogin ? 'Log in' : 'Sign Up'),
                ),
                TextButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    setState(() => _isLogin = !_isLogin);
                  },
                  child: Text(
                    _isLogin
                        ? 'Створіть новий екаунт'
                        : 'Вже маєте екаунт? Log in',
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final email = _emailController.text.trim();

                    if (email.isEmpty) {
                      authStore.showErrorMessage?.call('Please enter your email');
                      return;
                    }

                    FocusScope.of(context).unfocus();
                    await authStore.resetReCapPassword(email);
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
