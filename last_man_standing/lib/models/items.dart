enum ItemSpriteSheet { weapons, armour }

class Item {
  final int id;
  final String name;
  final String description;
  final ItemSpriteSheet spriteSheet;
  final int spriteRow;
  final int spriteColumn;
  final int hpBonus;
  final int atkBonus;
  final int strBonus;
  final int defBonus;

  const Item({
    required this.id,
    required this.name,
    required this.description,
    required this.spriteSheet,
    required this.spriteRow,
    required this.spriteColumn,
    this.hpBonus = 0,
    this.atkBonus = 0,
    this.strBonus = 0,
    this.defBonus = 0,
  });

  // Update game state with updated stats and items selected
  Item copyWith({
    int? id,
    String? name,
    String? description,
    ItemSpriteSheet? spriteSheet,
    int? spriteRow,
    int? spriteColumn,
    int? hpBonus,
    int? atkBonus,
    int? strBonus,
    int? defBonus,
  }) {
    return Item(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      spriteSheet: spriteSheet ?? this.spriteSheet,
      spriteRow: spriteRow ?? this.spriteRow,
      spriteColumn: spriteColumn ?? this.spriteColumn,
      hpBonus: hpBonus ?? this.hpBonus,
      atkBonus: atkBonus ?? this.atkBonus,
      strBonus: strBonus ?? this.strBonus,
      defBonus: defBonus ?? this.defBonus,
    );
  }

  // Shared Preferences

  // Serialize item data to json (Save)
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'spriteSheet': spriteSheet.index,
    'spriteRow': spriteRow,
    'spriteColumn': spriteColumn,
    'hpBonus': hpBonus,
    'atkBonus': atkBonus,
    'strBonus': strBonus,
    'defBonus': defBonus,
  };

  // De-Serialize game state data from json (Load)
  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      spriteSheet: ItemSpriteSheet.values[json['spriteSheet'] as int],
      spriteRow: json['spriteRow'] as int,
      spriteColumn: json['spriteColumn'] as int,
      hpBonus: json['hpBonus'] as int? ?? 0,
      atkBonus: json['atkBonus'] as int? ?? 0,
      strBonus: json['strBonus'] as int? ?? 0,
      defBonus: json['defBonus'] as int? ?? 0,
    );
  }
}
