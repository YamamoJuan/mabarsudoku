import 'dart:async';
import '../entities/room_entity.dart';

abstract class RoomRepository {
  Future<RoomEntity> createRoom({
    required String creatorId,
    required String creatorName,
    required String mode,
    required String difficulty,
  });

  Future<RoomEntity> joinRoom({
    required String roomId,
    required String userId,
    required String userName,
  });

  Future<void> leaveRoom({
    required String roomId,
    required String userId,
  });

  Future<RoomEntity> getRoomById(String roomId);

  Future<RoomEntity?> getRoomByInviteCode(String inviteCode);

  Future<void> startMatch(String roomId);

  Future<void> finishMatch(String roomId);

  Stream<RoomEntity> watchRoom(String roomId);
}
