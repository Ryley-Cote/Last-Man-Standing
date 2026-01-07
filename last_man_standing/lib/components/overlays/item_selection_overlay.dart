import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flame/sprite.dart';
import 'package:flame/extensions.dart';
import 'package:last_man_standing/widgets/item_selection.dart';

import '../../last_man_standing_game.dart';
import '../../models/fighter.dart';
import '../../components/providers/game_providers.dart';
import '../../widgets/skills_bar.dart';

class ItemSelectionOverlay extends ConsumerStatefulWidget {
  final LastManStanding game;

  const ItemSelectionOverlay({super.key, required this.game});

  @override
  ConsumerState<ItemSelectionOverlay> createState() => _OverlayState();
}

class _OverlayState extends ConsumerState<ItemSelectionOverlay> {
  late final SpriteSheet _weaponsSheet;
  late final SpriteSheet _armourSheet;

  int? _selectedItemId;

  // Load Item Sprite sheets to overlay
  @override
  void initState() {
    super.initState();

    final weaponSprite = widget.game.images.fromCache(
      'sprites_items/weapons_16x16.png',
    );
    final armourSprite = widget.game.images.fromCache(
      'sprites_items/armour_16x16.png',
    );

    _weaponsSheet = SpriteSheet(image: weaponSprite, srcSize: Vector2(16, 16));
    _armourSheet = SpriteSheet(image: armourSprite, srcSize: Vector2(16, 16));
  }

  // Build Item Selection Overlay
  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider);
    final Fighter? fighter = gameState.activeFighter;
    final selection = gameState.currentItemChoices;

    // Safety Fighter null check
    if (fighter == null || selection.isEmpty) {
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
            Text(
              'The sponsors offer you a gift...',
              style: TextStyle(
                color: Color(0xffffffff),
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            SizedBox(height: 14),
            // Item Selection
            ItemSelection(
              items: selection,
              selectedItemId: _selectedItemId,
              weaponsSheet: _weaponsSheet,
              armourSheet: _armourSheet,
              onItemSelected: (item) {
                setState(() {
                  _selectedItemId = item.id;
                });
              },
            ),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: _selectedItemId == null
                  ? null
                  : () {
                      final item = selection.firstWhere(
                        (item) => item.id == _selectedItemId as int,
                      );
                      ref.read(gameStateProvider.notifier).pickItem(item);

                      widget.game.overlays.remove('item_selection_overlay');
                      widget.game.overlays.add('combat_overlay');
                    },
              child: Text('Confirm Gift'),
            ),
          ],
        ),
      ),
    );
  }
}
