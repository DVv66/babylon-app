import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = AuthService();
  String? _fullName;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadName();
  }

  Future<void> _loadName() async {
    final uid = _auth.currentUser?.uid;
    if (uid != null) {
      final name = await _auth.fetchFullName(uid);
      setState(() {
        _fullName = name ?? 'User';
        _loading = false;
      });
    } else {
      setState(() => _loading = false);
    }
  }

  Future<void> _logout() async {
    await _auth.logout();
  }

  @override
  Widget build(BuildContext context) {
    final display = _loading ? '...' : (_fullName ?? 'User');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton.icon(
            onPressed: _logout,
            icon: const Icon(Icons.logout),
            label: const Text('Logout'),
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Hey, $display! You're successfully logged in.",
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
