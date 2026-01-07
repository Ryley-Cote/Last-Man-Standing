import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';

import 'game_state.dart';
import '../../models/fighter.dart';
import '../../models/enemy.dart';
import '../../sprites/items_catalog.dart';
import '../../models/items.dart';

class GameStateNotifier extends StateNotifier<GameState> {
  GameStateNotifier() : super(const GameState()) {
    load();
  }

  static const savedGame = 'game_state';
  final roll = Random();

  // Load Game state and saved data on app start (De-Serialize Json)
  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString(savedGame);

    if (jsonData != null) {
      state = GameState.fromJson(jsonDecode(jsonData));
    }
  }

  // Save Game state and Saved Data on updates (Serialize Json)
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = jsonEncode(state.toJson());
    await prefs.setString(savedGame, jsonData);
  }

  void setActiveFighter(Fighter fighter) {
    state = state.copyWith(
      activeFighter: fighter,
      currentWeek: 1,
      currentFightIndex: 0,
      trainingActions: 3,
    );
    save();
  }

  // Set weekly training actions
  void applyTraining({int hp = 0, int atk = 0, int str = 0, int def = 0}) {
    final fighter = state.activeFighter;

    if (fighter == null) {
      return;
    }

    final updatedFighter = fighter.copyWith(
      hitPoints: fighter.hitPoints + hp,
      attack: fighter.attack + atk,
      strength: fighter.strength + str,
      defense: fighter.defense + def,
    );

    // Reset Training points each week
    state = state.copyWith(activeFighter: updatedFighter, trainingActions: 3);
    save();
  }

  // Item Selection
  void generateItemChoices() {
    final itemCatalog = ItemsCatalog.all;

    if (itemCatalog.isEmpty) {
      return;
    }

    // Shuffle List and display 3 options
    final List<Item> shuffleList = [...itemCatalog]..shuffle(roll);
    final choices = shuffleList.take(3).toList();

    state = state.copyWith(currentItemChoices: choices);
    save();
  }

  // Add Items to inventory and stat boosts to stats
  void pickItem(Item item) {
    final fighter = state.activeFighter;

    if (fighter == null) {
      return;
    }

    // Update fighter stats with item boost
    final updatedFighter = fighter.copyWith(
      hitPoints: fighter.hitPoints + item.hpBonus,
      attack: fighter.attack + item.atkBonus,
      strength: fighter.strength + item.strBonus,
      defense: fighter.defense + item.defBonus,
    );

    final updatedInventory = [...state.inventory, item];

    state = state.copyWith(
      activeFighter: updatedFighter,
      inventory: updatedInventory,
      currentItemChoices: [],
    );
    save();
  }

  // Start Combat after selecting an item
  void startCombat(Enemy enemy) {
    final fighter = state.activeFighter;
    if (fighter == null) {
      return;
    }

    state = state.copyWith(
      fighterCurrentHp: fighter.hitPoints,
      enemyCurrentHp: enemy.hitPoints,
      combatLog: [
        'Week ${state.currentWeek}: ${fighter.name} VS. ${enemy.name}!',
      ],
      isCombatActive: true,
    );
  }

  void combatLogic(Enemy enemy) {
    final fighter = state.activeFighter;

    if (fighter == null || !state.isCombatActive) {
      return;
    }

    int fighterHp = state.fighterCurrentHp ?? fighter.hitPoints;
    int enemyHp = state.enemyCurrentHp ?? enemy.hitPoints;
    final log = List<String>.from(state.combatLog);

    void logLine(String line) => log.add(line);

    bool rollToHit({required int attackRoll, required int defenseRoll}) {
      // Roll for success. 80% if atk lvl >= def lvl; 50% if def lvl is >= atk level
      final successChance = attackRoll >= defenseRoll ? 0.8 : 0.5;
      return roll.nextDouble() < successChance;
    }

    int rollForDamage(int strength) {
      return roll.nextInt(strength) + 1;
    }

    // Character Attack
    if (enemyHp > 0) {
      final hit = rollToHit(
        attackRoll: fighter.attack,
        defenseRoll: enemy.defense,
      );

      if (hit) {
        final damage = rollForDamage(fighter.strength);
        enemyHp = max(0, enemyHp - damage);
        logLine('${fighter.name} hits ${enemy.name} for $damage damage');

        if (enemyHp <= 0) {
          logLine('${enemy.name} is defeated!');
        } else {
          logLine('${fighter.name} attacks but misses');
        }
      }
    }

    // Enemy Attack
    if (enemyHp > 0 && fighterHp > 0) {
      final hit = rollToHit(
        attackRoll: enemy.attack,
        defenseRoll: fighter.defense,
      );

      if (hit) {
        final damage = rollForDamage(enemy.strength);
        fighterHp = max(0, fighterHp - damage);
        logLine('${enemy.name} hits ${fighter.name} for $damage damage');

        if (fighterHp <= 0) {
          logLine('${fighter.name} is defeated!');
        } else {
          logLine('${enemy.name} attacks but misses');
        }
      }
    }

    // Check character and enemy health for zeros
    final stillActive = fighterHp > 0 && enemyHp > 0;

    state = state.copyWith(
      fighterCurrentHp: fighterHp,
      enemyCurrentHp: enemyHp,
      combatLog: log,
      isCombatActive: stillActive,
    );
  }

  void advanceWeek() {
    state = state.copyWith(
      currentWeek: state.currentWeek + 1,

      fighterCurrentHp: null,
      enemyCurrentHp: null,
      combatLog: [],
      isCombatActive: false,
    );
  }

  void resetRun() {
    state = const GameState();
    save();
  }
}
