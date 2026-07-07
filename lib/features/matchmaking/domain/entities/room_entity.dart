import 'package:freezed_annotation/freezed_annotation.dart';

part 'room_entity.freezed.dart';

enum RoomMode { coop, versus, ranked }
enum RoomStatus { waiting, playing, finished }

@freezed
class RoomEntity with _$RoomEntity {
  const factory RoomEntity({
    required String id,
    required String creatorId,
    required String creatorName,
    required RoomMode mode,
    required String difficulty,
    required RoomStatus status,
    required int maxPlayers,
    required List<String> playerIds,
    required List<String> playerNames,
    required DateTime createdAt,
    required String inviteCode,
    required DateTime? startedAt,
    required DateTime? finishedAt,
  }) = _RoomEntity;
}
