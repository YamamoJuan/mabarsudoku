import 'package:flutter_test/flutter_test.dart';
import 'package:mabar_sudoku/features/game/domain/services/sudoku_validator.dart';
import 'package:mabar_sudoku/core/constants/game_constants.dart';

void main() {
  group('SudokuValidator', () {
    late List<List<int>> testGrid;

    setUp(() {
      testGrid = List.generate(GRID_SIZE, (_) => List<int>.filled(GRID_SIZE, 0));
    });

    group('isValidMove', () {
      test('allows placing valid number in empty cell', () {
        testGrid[0][0] = 0;
        expect(SudokuValidator.isValidMove(testGrid, 0, 0, 5), true);
      });

      test('rejects number already in same row', () {
        testGrid[0][0] = 5;
        testGrid[0][5] = 0;
        expect(SudokuValidator.isValidMove(testGrid, 0, 5, 5), false);
      });

      test('rejects number already in same column', () {
        testGrid[0][0] = 5;
        testGrid[5][0] = 0;
        expect(SudokuValidator.isValidMove(testGrid, 5, 0, 5), false);
      });

      test('rejects number already in same 3x3 box', () {
        testGrid[0][0] = 5;
        testGrid[1][2] = 0;
        expect(SudokuValidator.isValidMove(testGrid, 1, 2, 5), false);
      });

      test('rejects invalid number range (0)', () {
        expect(SudokuValidator.isValidMove(testGrid, 0, 0, 0), false);
      });

      test('rejects invalid number range (10)', () {
        expect(SudokuValidator.isValidMove(testGrid, 0, 0, 10), false);
      });

      test('allows all valid numbers 1-9 in empty grid', () {
        for (int num = 1; num <= 9; num++) {
          expect(SudokuValidator.isValidMove(testGrid, 0, 0, num), true);
        }
      });

      test('validates different boxes independently', () {
        testGrid[0][0] = 5;
        testGrid[3][3] = 0;
        expect(SudokuValidator.isValidMove(testGrid, 3, 3, 5), true);
      });
    });

    group('isBoardComplete', () {
      test('returns false for empty board', () {
        expect(SudokuValidator.isBoardComplete(testGrid), false);
      });

      test('returns false for partially filled board', () {
        for (int i = 0; i < 5; i++) {
          testGrid[i][i] = i + 1;
        }
        expect(SudokuValidator.isBoardComplete(testGrid), false);
      });

      test('returns true when all cells filled', () {
        for (int i = 0; i < GRID_SIZE; i++) {
          for (int j = 0; j < GRID_SIZE; j++) {
            testGrid[i][j] = ((i + j) % 9) + 1;
          }
        }
        expect(SudokuValidator.isBoardComplete(testGrid), true);
      });

      test('returns false if any cell is 0', () {
        for (int i = 0; i < GRID_SIZE; i++) {
          for (int j = 0; j < GRID_SIZE; j++) {
            testGrid[i][j] = ((i + j) % 9) + 1;
          }
        }
        testGrid[5][5] = 0;
        expect(SudokuValidator.isBoardComplete(testGrid), false);
      });
    });

    group('isBoardValid', () {
      test('returns true for empty grid', () {
        expect(SudokuValidator.isBoardValid(testGrid), true);
      });

      test('returns false when row has duplicates', () {
        testGrid[0][0] = 5;
        testGrid[0][1] = 5;
        expect(SudokuValidator.isBoardValid(testGrid), false);
      });

      test('returns false when column has duplicates', () {
        testGrid[0][0] = 5;
        testGrid[1][0] = 5;
        expect(SudokuValidator.isBoardValid(testGrid), false);
      });

      test('returns false when box has duplicates', () {
        testGrid[0][0] = 5;
        testGrid[1][1] = 5;
        expect(SudokuValidator.isBoardValid(testGrid), false);
      });

      test('returns true for valid sparse grid', () {
        testGrid[0][0] = 1;
        testGrid[1][3] = 2;
        testGrid[5][5] = 3;
        expect(SudokuValidator.isBoardValid(testGrid), true);
      });
    });

    group('edge cases', () {
      test('corner cells validation', () {
        testGrid[0][0] = 1;
        testGrid[0][8] = 2;
        testGrid[8][0] = 3;
        testGrid[8][8] = 4;
        expect(SudokuValidator.isBoardValid(testGrid), true);
      });

      test('all numbers 1-9 in first row', () {
        for (int i = 0; i < 9; i++) {
          testGrid[0][i] = i + 1;
        }
        expect(SudokuValidator.isBoardValid(testGrid), true);
      });

      test('valid move with surrounding numbers', () {
        testGrid[0][0] = 1;
        testGrid[0][1] = 2;
        testGrid[1][0] = 3;
        testGrid[1][1] = 4;
        expect(SudokuValidator.isValidMove(testGrid, 0, 2, 5), true);
      });
    });
  });
}
