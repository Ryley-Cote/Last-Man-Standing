enum EnemySpriteSheet { slime, skeleton, eliteOrc }

class Enemy {
  final int id;
  final String name;
  final int hitPoints;
  final int attack;
  final int defense;
  final int strength;
  final EnemySpriteSheet spriteSheet;
  final int spriteRow;
  final int spriteColumn;

  Enemy({
    required this.id,
    required this.name,
    required this.hitPoints,
    required this.attack,
    required this.defense,
    required this.strength,
    required this.spriteSheet,
    required this.spriteRow,
    required this.spriteColumn,
  });

  // Update game state with updated stats
  Enemy copyWith({
    int? id,
    String? name,
    int? hitPoints,
    int? attack,
    int? defense,
    int? strength,
    EnemySpriteSheet? spriteSheet,
    int? spriteRow,
    int? spriteColumn,
  }) {
    return Enemy(
      id: id ?? this.id,
      name: name ?? this.name,
      hitPoints: hitPoints ?? this.hitPoints,
      attack: attack ?? this.attack,
      strength: strength ?? this.strength,
      defense: defense ?? this.defense,
      spriteSheet: spriteSheet ?? this.spriteSheet,
      spriteRow: spriteRow ?? this.spriteRow,
      spriteColumn: spriteColumn ?? this.spriteColumn,
    );
  }
}
