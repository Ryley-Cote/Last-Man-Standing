import 'package:flutter/widgets.dart';

import '../../models/fighter.dart';

class SkillsBar extends StatelessWidget {
  final Fighter fighter;

  const SkillsBar({super.key, required this.fighter});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(color: Color(0xFF222222)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _skillTile('HP', fighter.hitPoints),
          _skillTile('ATK', fighter.attack),
          _skillTile('STR', fighter.strength),
          _skillTile('DEF', fighter.defense),
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
