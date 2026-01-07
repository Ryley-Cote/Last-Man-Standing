import 'package:flutter/widgets.dart';

import '../models/enemy.dart';

class EnemySkillsBar extends StatelessWidget {
  final Enemy enemy;

  const EnemySkillsBar({super.key, required this.enemy});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Color(0xFF222222)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _skillTile('HP', enemy.hitPoints),
          _skillTile('ATK', enemy.attack),
          _skillTile('STR', enemy.strength),
          _skillTile('DEF', enemy.defense),
        ],
      ),
    );
  }

  Widget _skillTile(String label, int value) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Color(0xffffffff),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: TextStyle(
            color: Color(0xffffffff),
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
