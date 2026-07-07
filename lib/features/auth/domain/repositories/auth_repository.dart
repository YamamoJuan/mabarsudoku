import 'dart:async';
import '../../../../core/errors/app_exception.dart';

abstract class AuthRepository {
  Future<String> signInAnonymously();
  Future<String> signInWithGoogle();
  Future<void> signOut();
  Stream<bool> get authStateChanges;
  Future<bool> get isAuthenticated;
  Future<String?> get currentUserId;
}
