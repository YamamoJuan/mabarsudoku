import 'package:flutter/material.dart';
import '../providers/solo_game_provider.dart';
import '../widgets/sudoku_board.dart';
import '../widgets/numpad.dart';
import '../widgets/game_top_bar.dart';

class SoloGameScreen extends StatefulWidget {
  const SoloGameScreen({Key? key}) : super(key: key);

  @override
  State<SoloGameScreen> createState() => _SoloGameScreenState();
}

class _SoloGameScreenState extends State<SoloGameScreen> {
  late final SoloGameNotifier _notifier;

  @override
  void initState() {
    super.initState();
    _notifier = SoloGameNotifier();
    _notifier.addListener(_onStateChanged);
    _notifier.startNewGame();
  }

  void _onStateChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _notifier.removeListener(_onStateChanged);
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GameTopBar(
              elapsedTime: _notifier.elapsedTime,
              difficulty: _notifier.difficulty,
              errorsCount: _notifier.errorsCount,
              onBackPressed: () => Navigator.pop(context),
            ),
            Expanded(
              child: Center(
                child: SudokuBoard(
                  grid: _notifier.grid,
                  locked: _notifier.locked,
                  selectedRow: _notifier.selectedRow,
                  selectedCol: _notifier.selectedCol,
                  onCellSelected: _notifier.selectCell,
                ),
              ),
            ),
            Numpad(
              onNumberSelected: _notifier.placeNumber,
              onErase: _notifier.eraseCell,
              onNote: () {},
            ),
          ],
        ),
      ),
    );
  }
}
