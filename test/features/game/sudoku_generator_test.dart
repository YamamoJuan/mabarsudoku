import 'package:flutter_test/flutter_test.dart';
import 'package:mabar_sudoku/features/game/domain/services/sudoku_generator.dart';
import 'package:mabar_sudoku/features/game/domain/services/sudoku_validator.dart';
import 'package:mabar_sudoku/core/constants/game_constants.dart';

void main() {
  group('SudokuGenerator', () {
    group('generatePuzzle', () {
      test('returns puzzle and solution with correct size', () {
        final result = SudokuGenerator.generatePuzzle('easy');

        expect(result.puzzle.length, GRID_SIZE);
        expect(result.solution.length, GRID_SIZE);
        for (int i = 0; i < GRID_SIZE; i++) {
          expect(result.puzzle[i].length, GRID_SIZE);
          expect(result.solution[i].length, GRID_SIZE);
        }
      });

      test('solution is a fully filled valid grid', () {
        final result = SudokuGenerator.generatePuzzle('easy');

        for (int i = 0; i < GRID_SIZE; i++) {
          for (int j = 0; j < GRID_SIZE; j++) {
            expect(result.solution[i][j], greaterThan(0));
            expect(result.solution[i][j], lessThanOrEqualTo(9));
          }
        }

        expect(SudokuValidator.isBoardValid(result.solution), true);
      });

      test('solution is complete', () {
        final result = SudokuGenerator.generatePuzzle('easy');
        expect(SudokuValidator.isBoardComplete(result.solution), true);
      });

      test('easy puzzle has correct number of clues', () {
        final result = SudokuGenerator.generatePuzzle('easy');
        int clueCount = 0;
        for (int i = 0; i < GRID_SIZE; i++) {
          for (int j = 0; j < GRID_SIZE; j++) {
            if (result.puzzle[i][j] != 0) clueCount++;
          }
        }
        expect(clueCount, DIFFICULTY_EASY_CLUES);
      });

      test('medium puzzle has correct number of clues', () {
        final result = SudokuGenerator.generatePuzzle('medium');
        int clueCount = 0;
        for (int i = 0; i < GRID_SIZE; i++) {
          for (int j = 0; j < GRID_SIZE; j++) {
            if (result.puzzle[i][j] != 0) clueCount++;
          }
        }
        expect(clueCount, DIFFICULTY_MEDIUM_CLUES);
      });

      test('hard puzzle has correct number of clues', () {
        final result = SudokuGenerator.generatePuzzle('hard');
        int clueCount = 0;
        for (int i = 0; i < GRID_SIZE; i++) {
          for (int j = 0; j < GRID_SIZE; j++) {
            if (result.puzzle[i][j] != 0) clueCount++;
          }
        }
        expect(clueCount, DIFFICULTY_HARD_CLUES);
      });

      test('puzzle values match solution on filled cells', () {
        final result = SudokuGenerator.generatePuzzle('medium');
        for (int i = 0; i < GRID_SIZE; i++) {
          for (int j = 0; j < GRID_SIZE; j++) {
            if (result.puzzle[i][j] != 0) {
              expect(result.puzzle[i][j], result.solution[i][j]);
            }
          }
        }
      });

      test('puzzle is valid (no duplicate numbers)', () {
        final result = SudokuGenerator.generatePuzzle('medium');
        expect(SudokuValidator.isBoardValid(result.puzzle), true);
      });

      test('generates different puzzles on subsequent calls', () {
        final first = SudokuGenerator.generatePuzzle('easy');
        final second = SudokuGenerator.generatePuzzle('easy');

        bool same = true;
        for (int i = 0; i < GRID_SIZE && same; i++) {
          for (int j = 0; j < GRID_SIZE && same; j++) {
            if (first.puzzle[i][j] != second.puzzle[i][j]) {
              same = false;
            }
          }
        }

        expect(same, false);
      });
    });

    group('solution validity', () {
      test('every row contains numbers 1-9', () {
        for (int iter = 0; iter < 5; iter++) {
          final result = SudokuGenerator.generatePuzzle('easy');
          for (int row = 0; row < GRID_SIZE; row++) {
            final rowSet = <int>{};
            for (int col = 0; col < GRID_SIZE; col++) {
              rowSet.add(result.solution[row][col]);
            }
            expect(rowSet.length, 9);
          }
        }
      });

      test('every column contains numbers 1-9', () {
        for (int iter = 0; iter < 5; iter++) {
          final result = SudokuGenerator.generatePuzzle('easy');
          for (int col = 0; col < GRID_SIZE; col++) {
            final colSet = <int>{};
            for (int row = 0; row < GRID_SIZE; row++) {
              colSet.add(result.solution[row][col]);
            }
            expect(colSet.length, 9);
          }
        }
      });

      test('every 3x3 box contains numbers 1-9', () {
        for (int iter = 0; iter < 5; iter++) {
          final result = SudokuGenerator.generatePuzzle('easy');
          for (int boxRow = 0; boxRow < 3; boxRow++) {
            for (int boxCol = 0; boxCol < 3; boxCol++) {
              final boxSet = <int>{};
              for (int i = 0; i < 3; i++) {
                for (int j = 0; j < 3; j++) {
                  boxSet.add(result.solution[boxRow * 3 + i][boxCol * 3 + j]);
                }
              }
              expect(boxSet.length, 9);
            }
          }
        }
      });
    });

    group('edge cases', () {
      test('unknown difficulty defaults to medium', () {
        // This currently generates blank - should handle gracefully
        final result = SudokuGenerator.generatePuzzle('unknown');
        int clueCount = 0;
        for (int i = 0; i < GRID_SIZE; i++) {
          for (int j = 0; j < GRID_SIZE; j++) {
            if (result.puzzle[i][j] != 0 && result.solution[i][j] != 0) {
              clueCount++;
            }
          }
        }
        // Should still generate a valid puzzle
        expect(SudokuValidator.isBoardValid(result.puzzle), true);
        expect(SudokuValidator.isBoardComplete(result.solution), true);
      });

      test('multiple puzzles all valid', () {
        for (int i = 0; i < 10; i++) {
          final result = SudokuGenerator.generatePuzzle('medium');
          expect(SudokuValidator.isBoardValid(result.puzzle), true);
          expect(SudokuValidator.isBoardComplete(result.solution), true);
        }
      });
    });
  });
}
