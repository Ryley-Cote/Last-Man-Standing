import 'package:flame/game.dart';
import 'package:flame_riverpod/flame_riverpod.dart';

import 'components/screens/main_menu_screen.dart';
import 'components/screens/fighter_selection_screen.dart';
import 'components/screens/training_grounds_screen.dart';
import 'components/screens/battle_arena_screen.dart';
import 'components/screens/fight_results_screen.dart';
import '../../models/enemy.dart';

class LastManStanding extends FlameGame with RiverpodGameMixin {
  late final RouterComponent router;
  Enemy? currentEnemy;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    await images.loadAll(<String>[
      'backgrounds/battlegrounds.png',

      'gui/dragonFilledFrame.png',
      'gui/dragonSlicesCharacterFrame.png',
      'gui/raven_Icons16x16.png',
      'gui/skillIcons.png',

      'sprites_characters/armored_axeman.png',
      'sprites_characters/armored_skeleton.png',
      'sprites_characters/elite_orc.png',
      'sprites_characters/greatsword_skeleton.png',
      'sprites_characters/knight_templar.png',
      'sprites_characters/knight.png',
      'sprites_characters/slime.png',
      'sprites_characters/soldier.png',
      'sprites_characters/swordsman.png',

      'sprites_items/armour_16x16.png',
      'sprites_items/items.png',
      'sprites_items/weapons_16x16.png',
    ]);

    router = RouterComponent(
      initialRoute: 'main_menu_screen',
      routes: {
        'main_menu_screen': Route(MainMenuScreen.new),
        'fighter_selection_screen': Route(FighterSelectionScreen.new),
        'training_grounds_screen': WorldRoute(
          TrainingGroundsWorld.new,
          maintainState: false,
        ),
        'battle_arena_screen': WorldRoute(BattleArenaWorld.new),
        'fight_results_screen': Route(FightResultsScreen.new),
      },
    );
    add(router);
  }
}
