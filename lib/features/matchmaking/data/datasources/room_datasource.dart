import '../models/room_model.dart';

abstract class RoomDataSource {
  Future<RoomModel> createRoom({
    required String creatorId,
    required String creatorName,
    required String mode,
    required String difficulty,
  });

  Future<RoomModel> joinRoom({
    required String roomId,
    required String userId,
    required String userName,
  });

  Future<void> leaveRoom({
    required String roomId,
    required String userId,
  });

  Future<RoomModel> getRoomById(String roomId);

  Future<RoomModel?> getRoomByInviteCode(String inviteCode);

  Future<void> startMatch(String roomId);

  Future<void> finishMatch(String roomId);

  Stream<RoomModel> watchRoom(String roomId);
}

class FirestoreRoomDataSource implements RoomDataSource {
  @override
  Future<RoomModel> createRoom({
    required String creatorId,
    required String creatorName,
    required String mode,
    required String difficulty,
  }) async {
    throw UnimplementedError('Firebase project not configured');
  }

  @override
  Future<RoomModel> joinRoom({
    required String roomId,
    required String userId,
    required String userName,
  }) async {
    throw UnimplementedError('Firebase project not configured');
  }

  @override
  Future<void> leaveRoom({
    required String roomId,
    required String userId,
  }) async {
    throw UnimplementedError('Firebase project not configured');
  }

  @override
  Future<RoomModel> getRoomById(String roomId) async {
    throw UnimplementedError('Firebase project not configured');
  }

  @override
  Future<RoomModel?> getRoomByInviteCode(String inviteCode) async {
    throw UnimplementedError('Firebase project not configured');
  }

  @override
  Future<void> startMatch(String roomId) async {
    throw UnimplementedError('Firebase project not configured');
  }

  @override
  Future<void> finishMatch(String roomId) async {
    throw UnimplementedError('Firebase project not configured');
  }

  @override
  Stream<RoomModel> watchRoom(String roomId) {
    throw UnimplementedError('Firebase project not configured');
  }
}
