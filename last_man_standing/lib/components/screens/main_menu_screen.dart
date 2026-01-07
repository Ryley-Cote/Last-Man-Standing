import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/painting.dart';
import 'package:last_man_standing/components/providers/game_providers.dart';
import 'package:last_man_standing/widgets/menu_button.dart';

import '../state/game_state.dart';
import '../../last_man_standing_game.dart';

class MainMenuScreen extends Component with HasGameReference<LastManStanding> {
  late final RectangleComponent _background;
  late final TextComponent _title;
  late final MenuButton _continueButton;
  late final MenuButton _newGameButton;
  late final MenuButton _pastRunsButton;
  late final MenuButton _settingsButton;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final size = game.size;
    final gameState = game.ref.read(gameStateProvider);
    final hasActiveRun = gameState.activeFighter != null;

    // Background
    _background = RectangleComponent(
      size: size,
      paint: Paint()..color = const Color(0xFF8B5A2B),
      anchor: Anchor.topLeft,
      position: Vector2.zero(),
    );

    // Title
    _title = TextComponent(
      text: 'Last Man Standing',
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 48,
          color: Color(0xFFFFFFFF),
          fontWeight: FontWeight.bold,
        ),
      ),
      anchor: Anchor.center,
      position: Vector2(size.x / 2, size.y * 0.18),
    );

    // Continue Button - Visible only when there is an active run
    _continueButton = MenuButton(
      label: 'Continue Run',
      onPressed: () => game.router.pushNamed('training_grounds_screen'),
      position: Vector2(size.x / 2, size.y * 0.30),
    );

    // New Game Button
    _newGameButton = MenuButton(
      label: 'New Run',
      onPressed: () => game.router.pushNamed('fighter_selection_screen'),
      position: Vector2(size.x / 2, size.y * 0.45),
    );

    // Past Runs Button
    _pastRunsButton = MenuButton(
      label: 'Past Runs',
      onPressed: () => game.router.pushNamed('fighter_selection_screen'),
      position: Vector2(size.x / 2, size.y * 0.60),
    );

    // Settings Button
    _settingsButton = MenuButton(
      label: 'Settings',
      onPressed: () => game.router.pushNamed('fighter_selection_screen'),
      position: Vector2(size.x / 2, size.y * 0.75),
    );

    final menuComponents = <Component>[
      _background,
      _title,
      _continueButton,
      _newGameButton,
      _pastRunsButton,
      _settingsButton,
    ];

    // Insert Continue Button if there is an active run
    // if (hasActiveRun) {
    //   menuComponents.insert(2, _continueButton);
    // }

    // Render all screen elements
    addAll(menuComponents);
  }

  // Un-Load Overlay over game
  // @override
  // void onRemove() {
  //   game.overlays.remove('training_ground_overlay');
  //   super.onRemove();
  // }
}
