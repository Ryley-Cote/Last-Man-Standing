import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/game_state.dart';
import '../state/game_state_notifier.dart';

// final gameStateProvider = StateProvider<GameState>((ref) {
//   return GameState();
// });

final gameStateProvider = StateNotifierProvider<GameStateNotifier, GameState>((
  ref,
) {
  return GameStateNotifier();
});

// final fighterOptionsProvider = Provider<List<Fighter>>((ref) {
//   return FighterGenerator.generateFighterOptions(3);
// });

// final selectedFighterProvider = StateProvider<Fighter?>((ref) {
//   return null;
// });
