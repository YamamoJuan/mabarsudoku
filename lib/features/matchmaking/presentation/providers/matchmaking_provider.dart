import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../data/datasources/room_datasource.dart';
import '../../data/repositories/room_repository_impl.dart';
import '../../domain/repositories/room_repository.dart';

final roomDataSourceProvider = Provider<RoomDataSource>((ref) {
  return FirestoreRoomDataSource();
});

final roomRepositoryProvider = Provider<RoomRepository>((ref) {
  final dataSource = ref.read(roomDataSourceProvider);
  return RoomRepositoryImpl(dataSource);
});
