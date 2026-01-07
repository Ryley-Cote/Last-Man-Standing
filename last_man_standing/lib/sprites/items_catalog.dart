import '../models/items.dart';

class ItemsCatalog {
  static const List<Item> all = [
    // #1: The Claw
    Item(
      id: 1,
      name: 'The Claw',
      description: 'Do NOT scratch your face.',
      spriteSheet: ItemSpriteSheet.weapons,
      spriteRow: 8,
      spriteColumn: 1,
      atkBonus: 2,
    ),

    // #2: Ogres Slugger
    Item(
      id: 2,
      name: 'Ogres Slugger',
      description: "Club Goes BONK",
      spriteSheet: ItemSpriteSheet.weapons,
      spriteRow: 6,
      spriteColumn: 8,
      strBonus: 2,
    ),

    // #3: Pickaxe
    Item(
      id: 3,
      name: 'Pickaxe',
      description: 'At least its pointy..',
      spriteSheet: ItemSpriteSheet.weapons,
      spriteRow: 6,
      spriteColumn: 2,
      strBonus: 1,
    ),

    // #4: Scimmy
    Item(
      id: 4,
      name: 'Scimmy',
      description: 'Does the curve make it look cooler?',
      spriteSheet: ItemSpriteSheet.weapons,
      spriteRow: 7,
      spriteColumn: 0,
      strBonus: 1,
      atkBonus: 2,
    ),

    // #5: Titanium Axe
    Item(
      id: 5,
      name: 'Titanium Axe',
      description: 'Some good weight behind them swings',
      spriteSheet: ItemSpriteSheet.weapons,
      spriteRow: 8,
      spriteColumn: 2,
      strBonus: 3,
    ),

    // #6: Chain Body
    Item(
      id: 6,
      name: 'Chain Body',
      description: 'Slashes aint got nothin on me',
      spriteSheet: ItemSpriteSheet.armour,
      spriteRow: 7,
      spriteColumn: 1,
      defBonus: 1,
    ),

    // #7: Winged Helm
    Item(
      id: 7,
      name: 'Winged Helm',
      description: 'Mjolnir not included.',
      spriteSheet: ItemSpriteSheet.armour,
      spriteRow: 2,
      spriteColumn: 0,
      defBonus: 1,
    ),

    // #8: Belly Plate
    Item(
      id: 8,
      name: 'Belly Plate',
      description: 'Gotta protect the organs',
      spriteSheet: ItemSpriteSheet.armour,
      spriteRow: 3,
      spriteColumn: 1,
      defBonus: 2,
    ),

    // #9: Spiked Gauntlets
    Item(
      id: 9,
      name: 'Spiked Gauntlets',
      description: 'Well these look sharp',
      spriteSheet: ItemSpriteSheet.armour,
      spriteRow: 8,
      spriteColumn: 3,
      atkBonus: 1,
      defBonus: 1,
    ),

    // #10: Chonk Plate
    Item(
      id: 10,
      name: 'Chonk Plate',
      description: 'Does this come in a smaller size?',
      spriteSheet: ItemSpriteSheet.armour,
      spriteRow: 1,
      spriteColumn: 2,
      defBonus: 3,
    ),
  ];
}
