import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/errors/app_exception.dart';
import '../../data/datasources/auth_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';

final authDataSourceProvider = Provider<AuthDataSource>((ref) {
  return FirestoreAuthDataSource(ref.read(firestoreProvider));
});

final firestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance; // Placeholder
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dataSource = ref.read(authDataSourceProvider);
  return AuthRepositoryImpl(dataSource);
});

final authStateProvider = StreamProvider<bool>((ref) {
  final repo = ref.read(authRepositoryProvider);
  return repo.authStateChanges;
});

final authLoadingProvider = StateProvider<bool>((ref) => false);
