enum FighterSpriteSheet { axeman, knightTemplar, knight, soldier, swordsman }

class Fighter {
  final String name;
  final int hitPoints;
  final int attack;
  final int defense;
  final int strength;
  final FighterSpriteSheet spriteSheet;
  final int spriteRow;
  final int spriteColumn;

  Fighter({
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
  Fighter copyWith({
    String? name,
    int? hitPoints,
    int? attack,
    int? defense,
    int? strength,
    FighterSpriteSheet? spriteSheet,
    int? spriteRow,
    int? spriteColumn,
  }) {
    return Fighter(
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

  // Shared Preferences

  // Serialize game state data to json (Save)
  Map<String, dynamic> toJson() => {
    'name': name,
    'hitPoints': hitPoints,
    'attack': attack,
    'defense': defense,
    'strength': strength,
    'spriteSheet': spriteSheet.index,
    'spriteRow': spriteRow,
    'spriteColumn': spriteColumn,
  };

  // De-Serialize game state data from json (Load)
  factory Fighter.fromJson(Map<String, dynamic> json) {
    return Fighter(
      name: json['name'],
      hitPoints: json['hitPoints'],
      attack: json['attack'],
      defense: json['defense'],
      strength: json['strength'],
      spriteSheet: FighterSpriteSheet.values[json['spriteSheet'] as int],
      spriteRow: json['spriteRow'] as int,
      spriteColumn: json['spriteColumn'] as int,
    );
  }
}
