import 'dart:math';
import '../../../core/constants/game_constants.dart';

typedef PuzzleSet = ({List<List<int>> puzzle, List<List<int>> solution});

class SudokuGenerator {
  static PuzzleSet generatePuzzle(String difficulty) {
    final solution = _generateSolution();
    final puzzle = _removeClues(solution, difficulty);
    return (puzzle: puzzle, solution: solution);
  }

  static List<List<int>> _generateSolution() {
    final grid = List.generate(GRID_SIZE, (_) => List<int>.filled(GRID_SIZE, 0));
    _fillBoard(grid);
    return grid;
  }

  static bool _fillBoard(List<List<int>> grid) {
    for (int row = 0; row < GRID_SIZE; row++) {
      for (int col = 0; col < GRID_SIZE; col++) {
        if (grid[row][col] == 0) {
          for (int num = 1; num <= 9; num++) {
            if (_isValid(grid, row, col, num)) {
              grid[row][col] = num;
              if (_fillBoard(grid)) return true;
              grid[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  static bool _isValid(List<List<int>> grid, int row, int col, int num) {
    for (int i = 0; i < GRID_SIZE; i++) {
      if (grid[row][i] == num || grid[i][col] == num) return false;
    }

    int boxRow = (row ~/ BOX_SIZE) * BOX_SIZE;
    int boxCol = (col ~/ BOX_SIZE) * BOX_SIZE;
    for (int i = boxRow; i < boxRow + BOX_SIZE; i++) {
      for (int j = boxCol; j < boxCol + BOX_SIZE; j++) {
        if (grid[i][j] == num) return false;
      }
    }
    return true;
  }

  static List<List<int>> _removeClues(List<List<int>> solution, String difficulty) {
    final board = solution.map((row) => [...row]).toList();
    final random = Random();
    int cluesToRemove = GRID_SIZE * GRID_SIZE;
    
    if (difficulty == 'easy') {
      cluesToRemove -= DIFFICULTY_EASY_CLUES;
    } else if (difficulty == 'medium') {
      cluesToRemove -= DIFFICULTY_MEDIUM_CLUES;
    } else if (difficulty == 'hard') {
      cluesToRemove -= DIFFICULTY_HARD_CLUES;
    }

    int removed = 0;
    while (removed < cluesToRemove) {
      int row = random.nextInt(GRID_SIZE);
      int col = random.nextInt(GRID_SIZE);
      
      if (board[row][col] != 0) {
        board[row][col] = 0;
        removed++;
      }
    }
    return board;
  }
}
