import '../../../core/constants/game_constants.dart';

class SudokuValidator {
  static bool isValidMove(List<List<int>> grid, int row, int col, int value) {
    if (value < 1 || value > 9) return false;
    
    if (!_isRowValid(grid, row, value)) return false;
    if (!_isColumnValid(grid, col, value)) return false;
    if (!_isBoxValid(grid, row, col, value)) return false;
    
    return true;
  }

  static bool _isRowValid(List<List<int>> grid, int row, int value) {
    for (int col = 0; col < GRID_SIZE; col++) {
      if (grid[row][col] == value) return false;
    }
    return true;
  }

  static bool _isColumnValid(List<List<int>> grid, int col, int value) {
    for (int row = 0; row < GRID_SIZE; row++) {
      if (grid[row][col] == value) return false;
    }
    return true;
  }

  static bool _isBoxValid(List<List<int>> grid, int row, int col, int value) {
    int boxRow = (row ~/ BOX_SIZE) * BOX_SIZE;
    int boxCol = (col ~/ BOX_SIZE) * BOX_SIZE;
    
    for (int i = boxRow; i < boxRow + BOX_SIZE; i++) {
      for (int j = boxCol; j < boxCol + BOX_SIZE; j++) {
        if (grid[i][j] == value) return false;
      }
    }
    return true;
  }

  static bool isBoardComplete(List<List<int>> grid) {
    for (int i = 0; i < GRID_SIZE; i++) {
      for (int j = 0; j < GRID_SIZE; j++) {
        if (grid[i][j] == EMPTY_CELL_VALUE) return false;
      }
    }
    return true;
  }

  static bool isBoardValid(List<List<int>> grid) {
    for (int i = 0; i < GRID_SIZE; i++) {
      for (int j = 0; j < GRID_SIZE; j++) {
        int value = grid[i][j];
        if (value != EMPTY_CELL_VALUE) {
          grid[i][j] = EMPTY_CELL_VALUE;
          if (!isValidMove(grid, i, j, value)) {
            grid[i][j] = value;
            return false;
          }
          grid[i][j] = value;
        }
      }
    }
    return true;
  }
}
