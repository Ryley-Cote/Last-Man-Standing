import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../last_man_standing_game.dart';
import '../../models/fighter.dart';
import '../../components/providers/game_providers.dart';
import '../../widgets/skills_bar.dart';
import '../../widgets/training_selection.dart';

class TrainingGroundsOverlay extends ConsumerStatefulWidget {
  final LastManStanding game;

  const TrainingGroundsOverlay({super.key, required this.game});

  @override
  ConsumerState<TrainingGroundsOverlay> createState() => _OverlayState();
}

class _OverlayState extends ConsumerState<TrainingGroundsOverlay> {
  int hpPoints = 0;
  int atkPoints = 0;
  int strPoints = 0;
  int defPoints = 0;

  int get allocatedPoints => hpPoints + atkPoints + defPoints + strPoints;

  // Build Training Ground Overlay
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider);
    final Fighter? fighter = gameState.activeFighter;
    final actionsAvailable = gameState.trainingActions;
    final actionPointsRemaining = actionsAvailable - allocatedPoints;

    // Safety Fighter null check
    if (fighter == null) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(16),
        color: Color(0xFF222222),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Active Fighter Name + Current Week
            Text(
              '${fighter.name} - Week ${gameState.currentWeek}',
              style: TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            // Active Fighters Skills
            SkillsBar(fighter: fighter),
            SizedBox(height: 12),
            // Training Selection
            TrainingSelection(
              // Base Points
              hpPoints: hpPoints,
              atkPoints: atkPoints,
              defPoints: defPoints,
              strPoints: strPoints,
              actionPointsRemaining: actionPointsRemaining,

              // Add Points
              onHpPlus: () => _add(() => hpPoints++, actionsAvailable),
              onAtkPlus: () => _add(() => atkPoints++, actionsAvailable),
              onStrPlus: () => _add(() => strPoints++, actionsAvailable),
              onDefPlus: () => _add(() => defPoints++, actionsAvailable),

              // Remove Points
              onHpMinus: () => setState(() {
                if (hpPoints > 0) {
                  hpPoints--;
                }
              }),
              onAtkMinus: () => setState(() {
                if (atkPoints > 0) {
                  atkPoints--;
                }
              }),
              onStrMinus: () => setState(() {
                if (strPoints > 0) {
                  strPoints--;
                }
              }),
              onDefMinus: () => setState(() {
                if (defPoints > 0) {
                  defPoints--;
                }
              }),
            ),
            SizedBox(height: 12),
            // Confirm Training Points Allocation Button
            ElevatedButton(
              onPressed: allocatedPoints == 0
                  ? null
                  : () {
                      // Add training stats
                      final notifier = ref.read(gameStateProvider.notifier);
                      notifier.applyTraining(
                        hp: hpPoints,
                        atk: atkPoints,
                        str: strPoints,
                        def: defPoints,
                      );

                      // Generate 3 Item Choices
                      notifier.generateItemChoices();

                      // Navigate to the Battle Arena
                      widget.game.router.pushNamed('battle_arena_screen');

                      // Render in item selection overlay on top of Arena world
                      widget.game.overlays.add('item_selection_overlay');
                    },
              child: Text('Confirm Training'),
            ),
            const SizedBox(height: 8),

            // TEMP: Back to main menu for testing
            ElevatedButton(
              onPressed: () {
                widget.game.overlays.remove('training_ground_overlay');
                widget.game.router.pushReplacementNamed('main_menu_screen');
              },
              child: const Text('Main Menu'),
            ),
          ],
        ),
      ),
    );
  }

  void _add(void Function() increment, int actionsAvailable) {
    if (allocatedPoints < actionsAvailable) {
      setState(increment);
    }
  }
}
