import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flame_riverpod/flame_riverpod.dart';

import 'last_man_standing_game.dart';
import 'components/overlays/training_ground_overlay.dart';
import 'components/overlays/item_selection_overlay.dart';
import 'components/overlays/combat_overlay.dart';

void main() {
  runApp(ProviderScope(child: LastManStandingApp()));
}

final gameInstance = LastManStanding();

final GlobalKey<RiverpodAwareGameWidgetState> gameWidgetKey =
    GlobalKey<RiverpodAwareGameWidgetState>();

class LastManStandingApp extends StatelessWidget {
  const LastManStandingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Last Man Standing',
      home: Scaffold(
        body: RiverpodAwareGameWidget(
          key: gameWidgetKey,
          game: gameInstance,
          overlayBuilderMap: {
            'training_ground_overlay': (context, game) {
              return TrainingGroundsOverlay(game: game as LastManStanding);
            },
            'item_selection_overlay': (context, game) {
              return ItemSelectionOverlay(game: game as LastManStanding);
            },
            'combat_overlay': (context, game) {
              return CombatOverlay(game: game as LastManStanding);
            },
          },
        ),
      ),
    );
  }
}
