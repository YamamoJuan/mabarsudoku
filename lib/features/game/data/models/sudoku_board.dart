import 'package:freezed_annotation/freezed_annotation.dart';

part 'sudoku_board.freezed.dart';
part 'sudoku_board.g.dart';

@freezed
class SudokuBoard with _$SudokuBoard {
  const factory SudokuBoard({
    required List<List<int>> grid,
    required List<List<int>> solution,
    required List<List<bool>> locked,
    required String difficulty,
  }) = _SudokuBoard;

  factory SudokuBoard.fromJson(Map<String, dynamic> json) =>
      _$SudokuBoardFromJson(json);
}
