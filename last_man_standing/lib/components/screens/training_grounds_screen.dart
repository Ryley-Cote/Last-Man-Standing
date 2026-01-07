import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/painting.dart';
import 'package:last_man_standing/components/providers/game_providers.dart';

import '../../last_man_standing_game.dart';
import '../../models/fighter.dart';

class TrainingGroundsWorld extends World
    with RiverpodComponentMixin, HasGameReference<LastManStanding> {
  late final RectangleComponent _sky;
  late final SpriteComponent _background;
  // Fighter? _fighter;

  // Load Game State
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final background = game.images.fromCache('backgrounds/battlegrounds.png');
    final backgroundSheet = SpriteSheet(
      image: background,
      srcSize: Vector2(128, 234),
    );
    final trainingBackground = backgroundSheet.getSprite(0, 3);

    // Sky
    add(
      _sky = RectangleComponent(
        size: Vector2.zero(),
        paint: Paint()..color = const Color(0xFF87CEEB),
        anchor: Anchor.topLeft,
        position: Vector2.zero(),
      ),
    );

    // Training Grounds background
    add(
      _background = SpriteComponent(
        sprite: trainingBackground,
        size: Vector2.zero(),
        paint: Paint()..color = const Color(0xFF8B5A2B),
        anchor: Anchor.topLeft,
        position: Vector2.zero(),
      ),
    );
  }

  // Load Overlay and Game View
  @override
  void onMount() async {
    super.onMount();

    game.camera.world = this;
    game.camera.viewfinder.zoom = 1;
    game.camera.viewfinder.position = game.size / 2;

    game.overlays.add('training_ground_overlay');

    // Sprite Component
    final gameState = ref.read(gameStateProvider);
    final Fighter? fighter = gameState.activeFighter;

    // Fighter Sprite Sheets
    if (fighter != null) {
      final String spritePath = switch (fighter.spriteSheet) {
        FighterSpriteSheet.axeman => 'sprites_characters/armored_axeman.png',
        FighterSpriteSheet.knightTemplar =>
          'sprites_characters/knight_templar.png',
        FighterSpriteSheet.knight => 'sprites_characters/knight.png',
        FighterSpriteSheet.soldier => 'sprites_characters/soldier.png',
        FighterSpriteSheet.swordsman => 'sprites_characters/swordsman.png',
      };

      // Load sprite sheets from cache
      final sprite = game.images.fromCache(spritePath);

      final sheet = SpriteSheet(image: sprite, srcSize: Vector2(100, 100));

      final characterSprite = sheet.getSprite(
        fighter.spriteColumn,
        fighter.spriteRow,
      );

      // Positioning the character in the world
      final spriteSize = Vector2(450, 450);
      final spritePosition = Vector2(-20, 100);

      add(
        SpriteComponent(
          sprite: characterSprite,
          position: spritePosition,
          size: spriteSize,
        ),
      );
    }
  }

  // Un-Load Overlay over game
  @override
  void onRemove() {
    game.overlays.remove('training_ground_overlay');
    super.onRemove();
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);

    final viewport = game.camera.viewport.size;

    _sky.size = viewport;
    _background.size = viewport;
    _background.position = Vector2.zero();
    _background.anchor = Anchor.topLeft;
  }
}
