import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/game_constants.dart';

class SudokuBoard extends StatelessWidget {
  final List<List<int>> grid;
  final List<List<bool>> locked;
  final int selectedRow;
  final int selectedCol;
  final Function(int, int) onCellSelected;

  const SudokuBoard({
    Key? key,
    required this.grid,
    required this.locked,
    required this.selectedRow,
    required this.selectedCol,
    required this.onCellSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 9,
          ),
          itemCount: 81,
          itemBuilder: (context, index) {
            final row = index ~/ 9;
            final col = index % 9;
            final value = grid[row][col];
            final isLocked = locked[row][col];
            final isSelected = row == selectedRow && col == selectedCol;
            final isRelated = row == selectedRow || col == selectedCol ||
                (row ~/ BOX_SIZE) == (selectedRow ~/ BOX_SIZE) &&
                (col ~/ BOX_SIZE) == (selectedCol ~/ BOX_SIZE);

            Color backgroundColor = AppTheme.SUDOKU_CELL_EDITABLE;
            if (isLocked) {
              backgroundColor = AppTheme.SUDOKU_CELL_LOCKED;
            } else if (isSelected) {
              backgroundColor = AppTheme.SUDOKU_CELL_SELECTED;
            } else if (isRelated && value == 0) {
              backgroundColor = AppTheme.SUDOKU_CELL_RELATED;
            }

            final border = _getBorder(row, col);
            return GestureDetector(
              onTap: () => onCellSelected(row, col),
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                  border: border,
                ),
                child: Center(
                  child: value != 0
                      ? Text(
                          '$value',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: isLocked ? AppTheme.TEXT_PRIMARY : Colors.blue,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  BoxBorder _getBorder(int row, int col) {
    return Border(
      right: col % 3 == 2
          ? const BorderSide(color: Colors.black, width: 2)
          : BorderSide(color: Colors.grey.shade300),
      bottom: row % 3 == 2
          ? const BorderSide(color: Colors.black, width: 2)
          : BorderSide(color: Colors.grey.shade300),
    );
  }
}
