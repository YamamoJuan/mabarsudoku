import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    required List<List<int>> grid,
    required List<List<int>> solution,
    required List<List<bool>> locked,
    required bool isComplete,
    required int errorsCount,
    required int elapsedSeconds,
    required String difficulty,
    required DateTime createdAt,
  }) = _GameState;

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);
}
