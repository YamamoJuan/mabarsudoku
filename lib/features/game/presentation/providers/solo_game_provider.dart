import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/constants/game_constants.dart';
import '../../data/models/game_state.dart';
import '../../domain/services/sudoku_generator.dart';
import '../../domain/services/sudoku_validator.dart';
import '../../../shared/services/game_persistence_service.dart';

class SoloGameNotifier extends ChangeNotifier {
  List<List<int>> _grid = [];
  List<List<int>> _solution = [];
  List<List<bool>> _locked = [];
  int _errorsCount = 0;
  bool _isComplete = false;
  int _selectedRow = 0;
  int _selectedCol = 0;
  Timer? _timer;
  int _elapsedSeconds = 0;
  String _difficulty = 'medium';
  
  late GamePersistenceService _persistenceService;
  Timer? _autoSaveTimer;

  List<List<int>> get grid => _grid;
  List<List<bool>> get locked => _locked;
  int get errorsCount => _errorsCount;
  bool get isComplete => _isComplete;
  int get selectedRow => _selectedRow;
  int get selectedCol => _selectedCol;
  String get difficulty => _difficulty;
  Duration get elapsedTime => Duration(seconds: _elapsedSeconds);

  SoloGameNotifier() {
    _initPersistence();
  }

  void _initPersistence() async {
    final prefs = await SharedPreferences.getInstance();
    _persistenceService = GamePersistenceService(prefs);
  }

  void startNewGame({String difficulty = 'medium'}) {
    _difficulty = difficulty;
    _errorsCount = 0;
    _isComplete = false;
    _elapsedSeconds = 0;
    _selectedRow = 0;
    _selectedCol = 0;

    final result = SudokuGenerator.generatePuzzle(difficulty);
    _solution = result.solution;
    _grid = result.puzzle.map((row) => [...row]).toList();
    _locked = List.generate(GRID_SIZE, (row) =>
      List.generate(GRID_SIZE, (col) => _grid[row][col] != EMPTY_CELL_VALUE)
    );

    _startTimer();
    _startAutoSave();
    notifyListeners();
  }

  Future<void> loadSavedGame() async {
    final savedState = await _persistenceService.loadCurrentGame();
    if (savedState == null) return;

    _grid = savedState.grid.map((row) => [...row]).toList();
    _solution = savedState.solution.map((row) => [...row]).toList();
    _locked = savedState.locked.map((row) => [...row]).toList();
    _errorsCount = savedState.errorsCount;
    _isComplete = savedState.isComplete;
    _elapsedSeconds = savedState.elapsedSeconds;
    _difficulty = savedState.difficulty;

    _startTimer();
    _startAutoSave();
    notifyListeners();
  }

  Future<bool> hasSavedGame() async {
    return await _persistenceService.hasCurrentGame();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _elapsedSeconds++;
      notifyListeners();
    });
  }

  void _startAutoSave() {
    _autoSaveTimer?.cancel();
    _autoSaveTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _saveCurrentGame();
    });
  }

  Future<void> _saveCurrentGame() async {
    final gameState = GameState(
      grid: _grid,
      solution: _solution,
      locked: _locked,
      isComplete: _isComplete,
      errorsCount: _errorsCount,
      elapsedSeconds: _elapsedSeconds,
      difficulty: _difficulty,
      createdAt: DateTime.now(),
    );
    await _persistenceService.saveCurrentGame(gameState);
  }

  void selectCell(int row, int col) {
    _selectedRow = row;
    _selectedCol = col;
    notifyListeners();
  }

  void placeNumber(int number) {
    if (_isComplete) return;
    if (_locked[_selectedRow][_selectedCol]) return;

    if (SudokuValidator.isValidMove(_grid, _selectedRow, _selectedCol, number)) {
      _grid[_selectedRow][_selectedCol] = number;
      
      if (_solution[_selectedRow][_selectedCol] != number) {
        _errorsCount++;
      }
      
      if (SudokuValidator.isBoardComplete(_grid)) {
        _isComplete = true;
        _timer?.cancel();
        _autoSaveTimer?.cancel();
        _saveCurrentGame();
      }
    } else {
      _errorsCount++;
    }
    notifyListeners();
  }

  void eraseCell() {
    if (_isComplete) return;
    if (_locked[_selectedRow][_selectedCol]) return;
    _grid[_selectedRow][_selectedCol] = EMPTY_CELL_VALUE;
    notifyListeners();
  }

  void toggleNote(int number) {}

  @override
  void dispose() {
    _timer?.cancel();
    _autoSaveTimer?.cancel();
    _saveCurrentGame();
    super.dispose();
  }
}
