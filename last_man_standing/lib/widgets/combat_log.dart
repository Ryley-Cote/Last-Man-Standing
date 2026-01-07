import 'package:flutter/widgets.dart';

import '../models/enemy.dart';
import '../models/fighter.dart';

class CombatLog extends StatelessWidget {
  final Fighter fighter;
  final Enemy enemy;
  final List<String> entries;

  const CombatLog({
    super.key,
    required this.enemy,
    required this.fighter,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF222222),
        border: Border.all(color: Color(0xffffffff)),
      ),
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (context, log) {
          return Text(
            entries[log],
            style: TextStyle(color: Color(0xffffffff), fontSize: 12),
          );
        },
      ),
    );
  }
}
