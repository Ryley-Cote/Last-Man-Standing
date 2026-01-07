import 'package:flutter/material.dart';

class TrainingSelection extends StatelessWidget {
  final int hpPoints;
  final int atkPoints;
  final int strPoints;
  final int defPoints;
  final int actionPointsRemaining;

  final VoidCallback onHpPlus;
  final VoidCallback onHpMinus;
  final VoidCallback onAtkPlus;
  final VoidCallback onAtkMinus;
  final VoidCallback onStrPlus;
  final VoidCallback onStrMinus;
  final VoidCallback onDefPlus;
  final VoidCallback onDefMinus;

  const TrainingSelection({
    super.key,
    required this.hpPoints,
    required this.atkPoints,
    required this.defPoints,
    required this.strPoints,
    required this.actionPointsRemaining,
    required this.onHpPlus,
    required this.onHpMinus,
    required this.onAtkPlus,
    required this.onAtkMinus,
    required this.onStrPlus,
    required this.onStrMinus,
    required this.onDefPlus,
    required this.onDefMinus,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _actionRow('HP', hpPoints, onHpMinus, onHpPlus),
        _actionRow('ATK', atkPoints, onAtkMinus, onAtkPlus),
        _actionRow('STR', strPoints, onStrMinus, onStrPlus),
        _actionRow('DEF', defPoints, onDefMinus, onDefPlus),
        const SizedBox(height: 8),
        Text(
          'Actions Remaining: $actionPointsRemaining',
          style: const TextStyle(color: Color(0xffffffff), fontSize: 20),
        ),
      ],
    );
  }

  Widget _actionRow(
    String label,
    int value,
    VoidCallback onMinus,
    VoidCallback onPlus,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xffffffff), fontSize: 20),
        ),
        Row(
          children: [
            IconButton(onPressed: onMinus, icon: Icon(Icons.remove)),
            Text(
              value.toString(),
              style: const TextStyle(color: Color(0xffffffff), fontSize: 24),
            ),
            IconButton(onPressed: onPlus, icon: Icon(Icons.add)),
          ],
        ),
      ],
    );
  }
}
