import 'package:flame/widgets.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';

import '../../models/items.dart';

class ItemSelection extends StatelessWidget {
  final List<Item> items;
  final int? selectedItemId;
  final void Function(Item) onItemSelected;

  final SpriteSheet weaponsSheet;
  final SpriteSheet armourSheet;

  const ItemSelection({
    super.key,
    required this.items,
    required this.selectedItemId,
    required this.onItemSelected,
    required this.weaponsSheet,
    required this.armourSheet,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Row(
      children: [
        for (final item in items)
          Expanded(
            child: _ItemCard(
              item: item,
              selected: selectedItemId == item.id,
              weaponsSheet: weaponsSheet,
              armourSheet: armourSheet,
              onTap: () => onItemSelected(item),
            ),
          ),
      ],
    );
  }
}

class _ItemCard extends StatelessWidget {
  final Item item;
  final bool selected;
  final VoidCallback onTap;
  final SpriteSheet weaponsSheet;
  final SpriteSheet armourSheet;

  const _ItemCard({
    required this.item,
    required this.selected,
    required this.onTap,
    required this.weaponsSheet,
    required this.armourSheet,
  });

  @override
  Widget build(BuildContext context) {
    final sheet = switch (item.spriteSheet) {
      ItemSpriteSheet.weapons => weaponsSheet,
      ItemSpriteSheet.armour => armourSheet,
    };

    final sprite = sheet.getSprite(item.spriteColumn, item.spriteRow);

    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 200,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: selected ? const Color(0xFF444444) : const Color(0xFF333333),
            border: Border.all(
              color: selected ? Colors.amber : Colors.grey,
              width: selected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                item.name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 64,
                width: 64,
                child: SpriteWidget(sprite: sprite),
              ),
              SizedBox(height: 10),
              Text(
                item.description,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(height: 10),
              _StatLine(item: item),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatLine extends StatelessWidget {
  final Item item;

  const _StatLine({required this.item});

  @override
  Widget build(BuildContext context) {
    final parts = <String>[];

    if (item.hpBonus != 0) {
      parts.add('+${item.hpBonus} HP');
    }

    if (item.atkBonus != 0) {
      parts.add('+${item.atkBonus} ATK');
    }

    if (item.strBonus != 0) {
      parts.add('+${item.strBonus} STR');
    }

    if (item.defBonus != 0) {
      parts.add('+${item.defBonus} DEF');
    }

    if (parts.isEmpty) {
      return const SizedBox();
    }

    return Text(
      parts.join(' - '),
      textAlign: TextAlign.center,
      style: const TextStyle(color: Colors.lightGreenAccent, fontSize: 12),
    );
  }
}
