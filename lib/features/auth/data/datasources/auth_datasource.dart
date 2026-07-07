import 'dart:async';
import '../../../core/errors/app_exception.dart';
import '../../../core/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthDataSource {
  Future<String> signInAnonymously();
  Future<String> signInWithGoogle();
  Future<void> signOut();
  Stream<bool> get authStateChanges;
  Future<String?> get currentUserId;
}

class FirestoreAuthDataSource implements AuthDataSource {
  final FirebaseFirestore _firestore;
  final StreamController<bool> _authController = StreamController<bool>.broadcast();

  FirestoreAuthDataSource(this._firestore);

  @override
  Future<String> signInAnonymously() async {
    // Placeholder: return mock ID
    return 'placeholder_user_id';
  }

  @override
  Future<String> signInWithGoogle() async {
    throw FirebaseException(message: 'Google Sign-In not configured');
  }

  @override
  Future<void> signOut() async {}

  @override
  Stream<bool> get authStateChanges => _authController.stream;

  @override
  Future<String?> get currentUserId async => null;
}
