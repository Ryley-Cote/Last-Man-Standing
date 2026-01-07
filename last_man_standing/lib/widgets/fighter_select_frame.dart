import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/painting.dart';
import 'package:flame/effects.dart';

import '../../last_man_standing_game.dart';
import '../../models/fighter.dart';

typedef FighterTapCallback = void Function(Fighter fighter);
typedef FighterRenameCallback = void Function(Fighter fighter);

class FighterSelectFrame extends PositionComponent
    with TapCallbacks, HasGameReference<LastManStanding> {
  final Fighter fighter;
  final FighterTapCallback onSelected;
  final FighterRenameCallback onNameChange;

  bool _isSelected = false;

  FighterSelectFrame({
    required this.fighter,
    required this.onSelected,
    required this.onNameChange,
    required Vector2 position,
  }) : super(position: position, size: Vector2(350, 110));

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // TODO: Add visual highlighting to selected fighter Frame
    //      - lighting effect behind button if there is time

    // Background
    add(
      RectangleComponent(
        size: size,
        paint: Paint()..color = const Color(0xFF222222),
      ),
    );

    // Avatar frame (left side)
    const double avatarSize = 90;
    add(
      RectangleComponent(
        position: Vector2(10, (size.y - avatarSize) / 2),
        size: Vector2(avatarSize, avatarSize),
        paint: Paint()..color = const Color(0xFF555555),
      ),
    );

    // Fighter Sprite Sheets
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

    // Positioning the character in the centre of the frame
    const double characterSize = 90;
    final spriteSize = Vector2(250, 250);
    final spritePosition = Vector2(
      10 + (characterSize - spriteSize.x) / 2,
      (size.y - characterSize) / 2 + (characterSize - spriteSize.y) / 2,
    );

    add(
      SpriteComponent(
        sprite: characterSprite,
        position: spritePosition,
        size: spriteSize,
      ),
    );

    // Name and Stats panel (Right side)
    final double rightX = 10 + avatarSize + 10;

    add(
      _NameComponent(
        fighter: fighter,
        position: Vector2(rightX, 15),
        onRename: () => onNameChange(fighter),
      ),
    );

    // Stats Row: HP / Atk / Def / Str
    add(
      TextComponent(
        text:
            'HP: ${fighter.hitPoints}   Atk: ${fighter.attack}    Def: ${fighter.defense}   Str: ${fighter.strength}',
        position: Vector2(rightX, 55),
        anchor: Anchor.topLeft,
        textRenderer: TextPaint(style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  // Fighter frame Selection Scaling Effects
  void setSelected(bool selected) {
    if (_isSelected == selected) return;
    _isSelected = selected;

    // Reset scale effects
    for (final effect in children.whereType<ScaleEffect>().toList()) {
      effect.removeFromParent();
    }

    // Frame Scale: Selected => Scale up, Not Selected => default size
    add(
      ScaleEffect.to(
        Vector2.all(selected ? 1.1 : 1.0),
        EffectController(duration: 0.1),
      ),
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);
    onSelected(fighter);
  }
}

class _NameComponent extends TextComponent
    with TapCallbacks, HasGameReference<LastManStanding> {
  final Fighter fighter;
  final VoidCallback onRename;

  _NameComponent({
    required this.fighter,
    required Vector2 position,
    required this.onRename,
  }) : super(
         text: fighter.name,
         position: position,
         anchor: Anchor.topLeft,
         textRenderer: TextPaint(style: const TextStyle(fontSize: 22)),
       );

  @override
  void onTapUp(TapUpEvent event) {
    onRename();
  }
}
