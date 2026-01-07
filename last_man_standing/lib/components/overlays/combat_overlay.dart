import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:last_man_standing/widgets/combat_log.dart';
import 'package:last_man_standing/widgets/enemy_skills_bar.dart';

import '../../last_man_standing_game.dart';
import '../../models/fighter.dart';
import '../../models/enemy.dart';
import '../../components/providers/game_providers.dart';
import '../../widgets/skills_bar.dart';

class CombatOverlay extends ConsumerStatefulWidget {
  final LastManStanding game;

  const CombatOverlay({super.key, required this.game});

  @override
  ConsumerState<CombatOverlay> createState() => _OverlayState();
}

class _OverlayState extends ConsumerState<CombatOverlay> {
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider);
    final Fighter? fighter = gameState.activeFighter;
    final Enemy? enemy = widget.game.currentEnemy;

    final entries = gameState.combatLog;
    final fighterHp = gameState.fighterCurrentHp ?? fighter!.hitPoints;
    final enemyHp = gameState.enemyCurrentHp ?? enemy!.hitPoints;
    final isActive = gameState.isCombatActive;
    final bool playerDead = fighterHp <= 0;
    final bool enemyDead = enemyHp <= 0;

    // Safety Fighter null check
    if (fighter == null || enemy == null) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: const Color(0xFF222222),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Active Fighter Name + Current Week
            Text(
              '${fighter.name} - Week ${gameState.currentWeek}',
              style: const TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            // Active Fighters Skills
            SkillsBar(fighter: fighter),
            SizedBox(height: 12),
            // Enemy Name
            Text(
              enemy.name,
              style: const TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            // Enemy Skills
            EnemySkillsBar(enemy: enemy),
            const SizedBox(height: 12),
            // Fight Log
            SizedBox(
              height: 179,
              child: CombatLog(
                enemy: enemy,
                fighter: fighter,
                entries: entries,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (isActive) {
                  ref.read(gameStateProvider.notifier).combatLogic(enemy);
                  return;
                }

                if (enemyDead) {
                  ref.read(gameStateProvider.notifier).advanceWeek();
                  widget.game.router.pushNamed('training_ground_screen');
                  return;
                }

                if (playerDead) {
                  widget.game.overlays.remove('training_ground_overlay');
                  widget.game.router.pushReplacementNamed('main_menu_screen');
                }
              },
              child: Text(
                isActive
                    ? 'Next Round'
                    : enemyDead
                    ? 'Victory'
                    : 'Defeat',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
