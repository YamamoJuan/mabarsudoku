import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/room_entity.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
class RoomModel with _$RoomModel {
  const factory RoomModel({
    required String id,
    required String creatorId,
    required String creatorName,
    required String mode,
    required String difficulty,
    required String status,
    required int maxPlayers,
    required List<String> playerIds,
    required List<String> playerNames,
    required DateTime createdAt,
    required String inviteCode,
    DateTime? startedAt,
    DateTime? finishedAt,
  }) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
      _$RoomModelFromJson(json);
}

extension RoomModelToEntity on RoomModel {
  RoomEntity toEntity() {
    return RoomEntity(
      id: id,
      creatorId: creatorId,
      creatorName: creatorName,
      mode: RoomMode.values.firstWhere((e) => e.name == mode),
      difficulty: difficulty,
      status: RoomStatus.values.firstWhere((e) => e.name == status),
      maxPlayers: maxPlayers,
      playerIds: playerIds,
      playerNames: playerNames,
      createdAt: createdAt,
      inviteCode: inviteCode,
      startedAt: startedAt,
      finishedAt: finishedAt,
    );
  }
}

extension RoomEntityToModel on RoomEntity {
  RoomModel toModel() {
    return RoomModel(
      id: id,
      creatorId: creatorId,
      creatorName: creatorName,
      mode: mode.name,
      difficulty: difficulty,
      status: status.name,
      maxPlayers: maxPlayers,
      playerIds: playerIds,
      playerNames: playerNames,
      createdAt: createdAt,
      inviteCode: inviteCode,
      startedAt: startedAt,
      finishedAt: finishedAt,
    );
  }
}
