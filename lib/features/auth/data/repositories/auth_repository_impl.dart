import 'dart:async';
import '../../../../core/errors/app_exception.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepositoryImpl(this._dataSource);

  @override
  Future<String> signInAnonymously() async {
    try {
      return await _dataSource.signInAnonymously();
    } on AppException {
      rethrow;
    } catch (e) {
      throw AuthException(message: 'Failed to sign in anonymously', originalError: e);
    }
  }

  @override
  Future<String> signInWithGoogle() async {
    try {
      return await _dataSource.signInWithGoogle();
    } on AppException {
      rethrow;
    } catch (e) {
      throw AuthException(message: 'Failed to sign in with Google', originalError: e);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _dataSource.signOut();
    } catch (e) {
      throw AuthException(message: 'Failed to sign out', originalError: e);
    }
  }

  @override
  Stream<bool> get authStateChanges => _dataSource.authStateChanges;

  @override
  Future<bool> get isAuthenticated async => await _dataSource.currentUserId != null;

  @override
  Future<String?> get currentUserId async => await _dataSource.currentUserId;
}
