import 'dart:math';
import 'package:faker/faker.dart';

import '../models/fighter.dart';

class FighterGenerator {
  static final _rng = Random();
  static final _faker = Faker();

  static const int _defaultRow = 0;
  static const int _defaultColumn = 0;

  // Randomize the fighters stats
  static int _roll() => 2 + _rng.nextInt(4); // 2–5

  // Randomize the fighter sprite sheets
  static FighterSpriteSheet _randomFighter() {
    final sheetValue = FighterSpriteSheet.values;
    return sheetValue[_rng.nextInt(sheetValue.length)];
  }

  // Shorten Faker Name to Fit in Selection Frame
  static String _truncate(String value, int maxLength) {
    if (value.length <= maxLength) return value;
    return value.substring(0, maxLength);
  }

  static Fighter generate({String? name}) {
    final shortenedName = name ?? _faker.person.name();
    return Fighter(
      name: _truncate(shortenedName, 20),
      hitPoints: 10,
      attack: _roll(),
      defense: _roll(),
      strength: _roll(),
      spriteSheet: _randomFighter(),
      spriteRow: _defaultRow,
      spriteColumn: _defaultColumn,
    );
  }

  static List<Fighter> generateFighterOptions(int count) {
    return List.generate(count, (_) => generate());
  }
}
