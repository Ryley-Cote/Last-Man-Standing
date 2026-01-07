import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/painting.dart';
import 'package:last_man_standing/components/providers/game_providers.dart';
import 'package:last_man_standing/widgets/menu_button.dart';

import '../../last_man_standing_game.dart';
import '../../models/fighter.dart';
import '../../services/fighter_generator.dart';
import '../../widgets/fighter_select_frame.dart';
import '../../widgets/back_button.dart';

class FighterSelectionScreen extends Component
    with HasGameReference<LastManStanding> {
  late final RectangleComponent _background;
  late final TextComponent _title;
  late final MenuButton _confirmButton;
  late final BackButton _backButton;
  late final List<FighterSelectFrame> _frames;

  late final List<Fighter> _fighters;
  Fighter? _selected;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final size = game.size;

    // Background
    _background = RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF8B5A2B),
      anchor: Anchor.topLeft,
      position: Vector2.zero(),
    );

    // Back Button
    _backButton = BackButton(
      onPressed: () => game.router.pop(),
      position: Vector2(20, 20),
    );

    // Screen Title
    _title = TextComponent(
      text: 'Choose Your Champion!',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 35,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y * 0.12),
    );

    // Generate 3 fighter options
    _fighters = FighterGenerator.generateFighterOptions(3);

    // Frame Layout
    const frameWidth = 380.0;
    final cardX = (size.x - frameWidth) / 2;
    double startY = size.y * 0.22;
    const double spacing = 140;

    _frames = <FighterSelectFrame>[];

    for (final fighter in _fighters) {
      _frames.add(
        FighterSelectFrame(
          fighter: fighter,
          onSelected: _onFighterSelect,
          onNameChange: _onNameChange,
          position: Vector2(cardX, startY),
        ),
      );
      startY += spacing;
    }

    // Selection Confirmation Button
    _confirmButton = MenuButton(
      label: 'Confirm Fighter',
      onPressed: _onConfirmedPressed,
      position: Vector2(size.x / 2, size.y * 0.88),
    );

    // Render all screen elements
    addAll([_background, _backButton, _title, ..._frames, _confirmButton]);
  }

  // Callback Methods

  void _onFighterSelect(Fighter fighter) {
    _selected = fighter;
    for (final frame in _frames) {
      frame.setSelected(frame.fighter == fighter);
    }
  }

  void _onNameChange(Fighter fighter) {
    // TODO: Create and Implement editable character names
  }

  void _onConfirmedPressed() {
    if (_selected == null) {
      return;
    } else {
      game.ref.read(gameStateProvider.notifier).setActiveFighter(_selected!);

      game.router.pushNamed('training_grounds_screen');
    }
  }
}
