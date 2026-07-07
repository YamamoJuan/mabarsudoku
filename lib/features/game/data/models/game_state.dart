import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    required List<List<int>> grid,
    required List<List<bool>> locked,
    required bool isComplete,
    required int errorsCount,
    required Duration elapsedTime,
    required List<int> selectedCell,
  }) = _GameState;
}
