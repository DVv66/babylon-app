import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;

  Future<UserCredential> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await cred.user?.updateDisplayName(fullName);

    await _db.collection('users').doc(cred.user!.uid).set({
      'fullName': fullName,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    });

    return cred;
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() => _auth.signOut();

  Future<String?> fetchFullName(String uid) async {
    final authName = _auth.currentUser?.displayName;
    if (authName != null && authName.trim().isNotEmpty) return authName;

    final snap = await _db.collection('users').doc(uid).get();
    return snap.data()?['fullName'] as String?;
  }
}
