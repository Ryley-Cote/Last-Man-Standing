import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flame_riverpod/flame_riverpod.dart';
import 'package:flutter/painting.dart';
import 'package:last_man_standing/components/providers/game_providers.dart';
import 'package:last_man_standing/sprites/enemy_catalog.dart';

import '../../last_man_standing_game.dart';
import '../../models/fighter.dart';
import '../../models/enemy.dart';

class BattleArenaWorld extends World
    with RiverpodComponentMixin, HasGameReference<LastManStanding> {
  late final RectangleComponent _sky;
  late final SpriteComponent _background;

  // Load Overlay and Game View
  @override
  void onMount() async {
    super.onMount();

    game.camera.world = this;
    game.camera.viewfinder.zoom = 1;
    game.camera.viewfinder.position = game.size / 2;

    game.overlays.add('item_selection_overlay');

    final gameState = ref.read(gameStateProvider);
    final fighter = gameState.activeFighter;
    int currentWeek = gameState.currentWeek - 1;
    final enemy = EnemyCatalog.all[currentWeek];

    if (fighter == null) {
      return;
    }

    if (currentWeek < 0) {
      currentWeek = 0;
    }

    if (currentWeek >= EnemyCatalog.all.length) {
      currentWeek = EnemyCatalog.all.length - 1;
    }

    game.currentEnemy = enemy;

    // Start combat with enemy
    ref.read(gameStateProvider.notifier).startCombat(enemy);

    // Sprite Component

    // Load Player Sprite into world
    final String characterPath = switch (fighter.spriteSheet) {
      FighterSpriteSheet.axeman => 'sprites_characters/armored_axeman.png',
      FighterSpriteSheet.knightTemplar =>
        'sprites_characters/knight_templar.png',
      FighterSpriteSheet.knight => 'sprites_characters/knight.png',
      FighterSpriteSheet.soldier => 'sprites_characters/soldier.png',
      FighterSpriteSheet.swordsman => 'sprites_characters/swordsman.png',
    };

    // Load sprite sheets from cache
    final sprite = game.images.fromCache(characterPath);

    final characterSheet = SpriteSheet(
      image: sprite,
      srcSize: Vector2(100, 100),
    );

    final characterSprite = characterSheet.getSprite(
      fighter.spriteColumn,
      fighter.spriteRow,
    );

    // Load Enemy Sprite into world
    final String enemyPath = switch (enemy.spriteSheet) {
      EnemySpriteSheet.slime => 'sprites_characters/slime.png',
      EnemySpriteSheet.skeleton => 'sprites_characters/armored_skeleton.png',
      EnemySpriteSheet.eliteOrc => 'sprites_characters/elite_orc.png',
    };

    // Load sprite sheets from cache
    final enemyImage = game.images.fromCache(enemyPath);

    final enemySheet = SpriteSheet(
      image: enemyImage,
      srcSize: Vector2(100, 100),
    );

    final enemySprite = enemySheet.getSprite(
      enemy.spriteColumn,
      enemy.spriteRow,
    );

    // Sizing Character and Enemy Sprite
    final spriteSize = Vector2(450, 450);

    // Add Character Sprite
    add(
      SpriteComponent(
        sprite: characterSprite,
        position: Vector2(-80, 150),
        size: spriteSize,
      ),
    );

    // Add Enemy Sprite and flip horizontally
    add(
      SpriteComponent(
        sprite: enemySprite,
        position: Vector2(270, 375),
        size: spriteSize,
        anchor: Anchor.center,
      )..flipHorizontally(),
    );
  }

  // Un-Load Overlay and Game view
  @override
  void onRemove() {
    game.overlays.remove('item_selection_overlay');
    super.onRemove();
  }

  // Load Game State
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final background = game.images.fromCache('backgrounds/battlegrounds.png');
    final backgroundSheet = SpriteSheet(
      image: background,
      srcSize: Vector2(128, 234),
    );
    final trainingBackground = backgroundSheet.getSprite(0, 0);

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
