import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/game_state.dart';

class GamePersistenceService {
  static const String _currentGameKey = 'current_game_state';
  static const String _savedGamesKey = 'saved_games_list';

  final SharedPreferences _prefs;

  GamePersistenceService(this._prefs);

  Future<void> saveCurrentGame(GameState gameState) async {
    final json = gameState.toJson();
    await _prefs.setString(_currentGameKey, jsonEncode(json));
  }

  Future<GameState?> loadCurrentGame() async {
    final json = _prefs.getString(_currentGameKey);
    if (json == null) return null;
    
    try {
      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return GameState.fromJson(decoded);
    } catch (e) {
      return null;
    }
  }

  Future<void> deleteCurrentGame() async {
    await _prefs.remove(_currentGameKey);
  }

  Future<bool> hasCurrentGame() async {
    return _prefs.containsKey(_currentGameKey);
  }

  Future<void> clearAllGames() async {
    await _prefs.remove(_currentGameKey);
    await _prefs.remove(_savedGamesKey);
  }
}
