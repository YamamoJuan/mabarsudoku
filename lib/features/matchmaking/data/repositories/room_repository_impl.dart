import '../../domain/entities/room_entity.dart';
import '../../domain/repositories/room_repository.dart';
import '../datasources/room_datasource.dart';
import '../models/room_model.dart';

class RoomRepositoryImpl implements RoomRepository {
  final RoomDataSource _dataSource;

  RoomRepositoryImpl(this._dataSource);

  @override
  Future<RoomEntity> createRoom({
    required String creatorId,
    required String creatorName,
    required String mode,
    required String difficulty,
  }) async {
    final model = await _dataSource.createRoom(
      creatorId: creatorId,
      creatorName: creatorName,
      mode: mode,
      difficulty: difficulty,
    );
    return model.toEntity();
  }

  @override
  Future<RoomEntity> joinRoom({
    required String roomId,
    required String userId,
    required String userName,
  }) async {
    final model = await _dataSource.joinRoom(
      roomId: roomId,
      userId: userId,
      userName: userName,
    );
    return model.toEntity();
  }

  @override
  Future<void> leaveRoom({
    required String roomId,
    required String userId,
  }) async {
    await _dataSource.leaveRoom(roomId: roomId, userId: userId);
  }

  @override
  Future<RoomEntity> getRoomById(String roomId) async {
    final model = await _dataSource.getRoomById(roomId);
    return model.toEntity();
  }

  @override
  Future<RoomEntity?> getRoomByInviteCode(String inviteCode) async {
    final model = await _dataSource.getRoomByInviteCode(inviteCode);
    return model?.toEntity();
  }

  @override
  Future<void> startMatch(String roomId) async {
    await _dataSource.startMatch(roomId);
  }

  @override
  Future<void> finishMatch(String roomId) async {
    await _dataSource.finishMatch(roomId);
  }

  @override
  Stream<RoomEntity> watchRoom(String roomId) {
    return _dataSource.watchRoom(roomId).map((model) => model.toEntity());
  }
}
