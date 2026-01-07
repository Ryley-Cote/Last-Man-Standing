import '../models/enemy.dart';

class EnemyCatalog {
  static List<Enemy> all = [
    Enemy(
      id: 1,
      name: 'The Slime',
      hitPoints: 10,
      attack: 7,
      defense: 7,
      strength: 7,
      spriteSheet: EnemySpriteSheet.slime,
      spriteRow: 0,
      spriteColumn: 0,
    ),

    Enemy(
      id: 2,
      name: 'Skele-Slasher',
      hitPoints: 10,
      attack: 10,
      defense: 10,
      strength: 10,
      spriteSheet: EnemySpriteSheet.skeleton,
      spriteRow: 0,
      spriteColumn: 0,
    ),

    Enemy(
      id: 3,
      name: 'Elite Orc Warrior',
      hitPoints: 10,
      attack: 14,
      defense: 14,
      strength: 14,
      spriteSheet: EnemySpriteSheet.eliteOrc,
      spriteRow: 0,
      spriteColumn: 0,
    ),
  ];
}
