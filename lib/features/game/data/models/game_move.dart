import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_move.freezed.dart';
part 'game_move.g.dart';

@freezed
class GameMove with _$GameMove {
  const factory GameMove({
    required int row,
    required int col,
    required int value,
    required DateTime timestamp,
    required bool isValid,
  }) = _GameMove;

  factory GameMove.fromJson(Map<String, dynamic> json) =>
      _$GameMoveFromJson(json);
}
