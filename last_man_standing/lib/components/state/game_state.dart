import '../../models/fighter.dart';
import '../../models/items.dart';

class GameState {
  final Fighter? activeFighter;
  final int currentWeek;
  final int currentFightIndex;
  final int trainingActions;

  final List<Item> inventory;
  final List<Item> currentItemChoices;

  final int? fighterCurrentHp;
  final int? enemyCurrentHp;
  final List<String> combatLog;
  final bool isCombatActive;

  const GameState({
    this.activeFighter,
    this.currentWeek = 1,
    this.currentFightIndex = 0,
    this.trainingActions = 3,
    this.inventory = const [],
    this.currentItemChoices = const [],
    this.fighterCurrentHp,
    this.enemyCurrentHp,
    this.combatLog = const [],
    this.isCombatActive = false,
  });

  GameState copyWith({
    Fighter? activeFighter,
    int? currentWeek,
    int? currentFightIndex,
    int? trainingActions,

    List<Item>? inventory,
    List<Item>? currentItemChoices,

    int? fighterCurrentHp,
    int? enemyCurrentHp,
    List<String>? combatLog,
    bool? isCombatActive,
  }) {
    return GameState(
      activeFighter: activeFighter ?? this.activeFighter,
      currentWeek: currentWeek ?? this.currentWeek,
      currentFightIndex: currentFightIndex ?? this.currentFightIndex,
      trainingActions: trainingActions ?? this.trainingActions,

      inventory: inventory ?? this.inventory,
      currentItemChoices: currentItemChoices ?? this.currentItemChoices,

      fighterCurrentHp: fighterCurrentHp ?? this.fighterCurrentHp,
      enemyCurrentHp: enemyCurrentHp ?? this.enemyCurrentHp,
      combatLog: combatLog ?? this.combatLog,
      isCombatActive: isCombatActive ?? this.isCombatActive,
    );
  }

  // Shared Preferences

  // Serialize game state data to json
  Map<String, dynamic> toJson() => {
    'activeFighter': activeFighter?.toJson(),
    'currentWeek': currentWeek,
    'currentFightIndex': currentFightIndex,
    'trainingActions': trainingActions,

    'inventory': inventory.map((e) => e.toJson()).toList(),
    'currentItemChoices': currentItemChoices.map((e) => e.toJson()).toList(),
  };

  // De-Serialize game state data from json
  factory GameState.fromJson(Map<String, dynamic> json) {
    return GameState(
      activeFighter: json['activeFighter'] != null
          ? Fighter.fromJson(json['activeFighter'])
          : null,
      currentWeek: json['currentWeek'] ?? 1,
      currentFightIndex: json['currentFightIndex'] ?? 0,
      trainingActions: json['trainingActions'] ?? 3,

      inventory: (json['inventory'] as List<dynamic>? ?? [])
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
      currentItemChoices: (json['currentItemChoices'] as List<dynamic>? ?? [])
          .map((e) => Item.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
