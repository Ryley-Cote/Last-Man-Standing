import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';

import '../../last_man_standing_game.dart';

typedef VoidCallback = void Function();

class MenuButton extends PositionComponent
    with TapCallbacks, HasGameReference<LastManStanding> {
  MenuButton({
    required this.label,
    required this.onPressed,
    required Vector2 position,
  }) {
    this.position = position;
    size = Vector2(260, 64);
    anchor = Anchor.center;
  }

  final String label;
  final VoidCallback onPressed;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Button Background
    add(
      RectangleComponent(
        size: size,
        anchor: Anchor.topLeft,
        position: Vector2.zero(),
        paint: Paint()
          ..style = PaintingStyle.fill
          ..color = const Color(0xFFDFB37A),
      ),
    );

    // Button Border
    add(
      RectangleComponent(
        size: size,
        anchor: Anchor.topLeft,
        position: Vector2.zero(),
        paint: Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..color = const Color(0xFFDFB37A),
      ),
    );

    // Button Label
    add(
      TextComponent(
        text: label,
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 24,
            color: Color(0xFFF5E6C5),
            fontWeight: FontWeight.w600,
          ),
        ),
        anchor: Anchor.center,
        position: size / 2,
      ),
    );
  }

  @override
  void onTapUp(TapUpEvent event) {
    onPressed();
  }
}
