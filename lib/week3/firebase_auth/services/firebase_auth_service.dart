import 'dart:async';
import '../models/firebase_auth_user.dart';

/// Firebase Authentication Service for Week 3 Assignment 2
/// Implements standard Firebase Auth email & password authentication workflows,
/// error code translation, and session management.
class FirebaseAuthService {
  FirebaseAuthUser? _currentUser;
  final Map<String, String> _registeredUsers = {
    'demo@firebase.google.com': 'Firebase123!',
    'himanshu@flutter.edu': 'Student2026!',
  };

  FirebaseAuthUser? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  /// Sign In with Email and Password
  Future<FirebaseAuthUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 700)); // Network latency

    final normalizedEmail = email.trim().toLowerCase();

    if (!_isValidEmail(normalizedEmail)) {
      throw FirebaseAuthException(
        code: 'invalid-email',
        message: 'The email address is badly formatted.',
      );
    }

    if (password.length < 6) {
      throw FirebaseAuthException(
        code: 'wrong-password',
        message: 'Password provided is incorrect.',
      );
    }

    if (!_registeredUsers.containsKey(normalizedEmail)) {
      // Check if trying to login with an unregistered account
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'No user record found corresponding to this identifier.',
      );
    }

    if (_registeredUsers[normalizedEmail] != password) {
      throw FirebaseAuthException(
        code: 'wrong-password',
        message: 'Invalid credentials. Password does not match.',
      );
    }

    _currentUser = FirebaseAuthUser(
      uid: 'firebase_uid_${normalizedEmail.hashCode}',
      email: normalizedEmail,
      displayName: normalizedEmail.split('@')[0],
      isEmailVerified: true,
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
    );

    return _currentUser!;
  }

  /// Create User / Sign Up with Email and Password
  Future<FirebaseAuthUser> createUserWithEmailAndPassword({
    required String email,
    required String password,
    String? displayName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final normalizedEmail = email.trim().toLowerCase();

    if (!_isValidEmail(normalizedEmail)) {
      throw FirebaseAuthException(
        code: 'invalid-email',
        message: 'The email address is badly formatted.',
      );
    }

    if (password.length < 6) {
      throw FirebaseAuthException(
        code: 'weak-password',
        message: 'The password is too weak (must be at least 6 characters).',
      );
    }

    if (_registeredUsers.containsKey(normalizedEmail)) {
      throw FirebaseAuthException(
        code: 'email-already-in-use',
        message: 'The email address is already in use by another account.',
      );
    }

    // Register user
    _registeredUsers[normalizedEmail] = password;

    _currentUser = FirebaseAuthUser(
      uid: 'firebase_uid_${normalizedEmail.hashCode}',
      email: normalizedEmail,
      displayName: displayName?.isNotEmpty == true
          ? displayName!
          : normalizedEmail.split('@')[0],
      isEmailVerified: true,
      createdAt: DateTime.now(),
    );

    return _currentUser!;
  }

  /// Send Password Reset Email
  Future<void> sendPasswordResetEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final normalized = email.trim().toLowerCase();
    if (!_isValidEmail(normalized)) {
      throw FirebaseAuthException(
        code: 'invalid-email',
        message: 'Please provide a valid email address.',
      );
    }
  }

  /// Sign Out
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _currentUser = null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}

class FirebaseAuthException implements Exception {
  final String code;
  final String message;

  FirebaseAuthException({required this.code, required this.message});

  @override
  String toString() => 'FirebaseAuthException: [$code] $message';
}
