import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = AuthService();

  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _pwCtrl = TextEditingController();

  bool _isLogin = true;
  bool _busy = false;
  bool _obscure = true;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _pwCtrl.dispose();
    super.dispose();
  }

  // Validation helpers
  String? _validateName(String? v) {
    if (_isLogin) return null;
    if (v == null || v.trim().isEmpty) return 'Please enter your full name';
    if (v.trim().length < 2) return 'Name is too short';
    return null;
  }

  String? _validateEmail(String? v) {
    if (v == null || v.trim().isEmpty) return 'Please enter your email';
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v.trim());
    if (!ok) return 'Invalid email format';
    return null;
  }

  String? _validatePassword(String? v) {
    if (v == null || v.isEmpty) return 'Please enter your password';
    if (v.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _busy = true);
    try {
      if (_isLogin) {
        await _auth.login(
          email: _emailCtrl.text.trim(),
          password: _pwCtrl.text,
        );
      } else {
        await _auth.register(
          fullName: _nameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
          password: _pwCtrl.text,
        );
      }
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? e.code);
    } catch (e) {
      _showError(e.toString());
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(24),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _isLogin ? 'Welcome back' : 'Create your account',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 24),

                    if (!_isLogin)
                      TextFormField(
                        controller: _nameCtrl,
                        decoration: const InputDecoration(
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateName,
                        textInputAction: TextInputAction.next,
                      ),
                    if (!_isLogin) const SizedBox(height: 12),

                    TextFormField(
                      controller: _emailCtrl,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: 12),

                    TextFormField(
                      controller: _pwCtrl,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          onPressed: () => setState(() => _obscure = !_obscure),
                          icon: Icon(
                              _obscure ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                      obscureText: _obscure,
                      validator: _validatePassword,
                      onFieldSubmitted: (_) => _submit(),
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(_isLogin
                            ? "Don't have an account?"
                            : "Already have an account?"),
                        TextButton(
                          onPressed: () =>
                              setState(() => _isLogin = !_isLogin),
                          child: Text(_isLogin ? 'Register' : 'Login'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _busy ? null : _submit,
                        child: _busy
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(_isLogin ? 'Login' : 'Register'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
