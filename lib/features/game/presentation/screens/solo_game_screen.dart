import 'package:flutter/material.dart';
import '../providers/solo_game_provider.dart';
import '../widgets/sudoku_board.dart';
import '../widgets/numpad.dart';
import '../widgets/game_top_bar.dart';
import '../widgets/difficulty_picker_modal.dart';
import 'game_completion_screen.dart';

class SoloGameScreen extends StatefulWidget {
  const SoloGameScreen({Key? key}) : super(key: key);

  @override
  State<SoloGameScreen> createState() => _SoloGameScreenState();
}

class _SoloGameScreenState extends State<SoloGameScreen> {
  late final SoloGameNotifier _notifier;
  bool _difficultySelected = false;

  @override
  void initState() {
    super.initState();
    _notifier = SoloGameNotifier();
    _notifier.addListener(_onStateChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkSavedGameAndShowPicker();
    });
  }

  void _checkSavedGameAndShowPicker() async {
    final hasSavedGame = await _notifier.hasSavedGame();
    
    if (hasSavedGame && mounted) {
      _showResumeSavedGameDialog();
    } else {
      _showDifficultyPicker();
    }
  }

  void _showResumeSavedGameDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Resume Game'),
        content: const Text('Would you like to resume your saved game?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _notifier.loadSavedGame();
              setState(() => _difficultySelected = true);
            },
            child: const Text('Resume'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showDifficultyPicker();
            },
            child: const Text('New Game'),
          ),
        ],
      ),
    );
  }

  void _showDifficultyPicker() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => DifficultyPickerModal(
        onDifficultySelected: (difficulty) {
          setState(() => _difficultySelected = true);
          _notifier.startNewGame(difficulty: difficulty);
        },
      ),
    );
  }

  void _onStateChanged() {
    if (_notifier.isComplete) {
      _showCompletionScreen();
    }
    setState(() {});
  }

  void _showCompletionScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => GameCompletionScreen(
          elapsedTime: _notifier.elapsedTime,
          errorsCount: _notifier.errorsCount,
          difficulty: _notifier.difficulty,
          onPlayAgain: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SoloGameScreen()),
            );
          },
          onBackHome: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _notifier.removeListener(_onStateChanged);
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_difficultySelected || _notifier.grid.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

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
