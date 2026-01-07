import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:flutter/painting.dart';

import '../../last_man_standing_game.dart';

class BackButton extends TextComponent
    with TapCallbacks, HasGameReference<LastManStanding> {
  final VoidCallback onPressed;

  BackButton({required this.onPressed, required Vector2 position})
    : super(
        text: '< BACK',
        textRenderer: TextPaint(
          style: const TextStyle(
            fontSize: 24,
            color: Color(0xFFFFFFFF),
            fontWeight: FontWeight.bold,
          ),
        ),
        position: position,
        anchor: Anchor.topLeft,
      );

  @override
  void onTapUp(TapUpEvent event) => onPressed();
}
