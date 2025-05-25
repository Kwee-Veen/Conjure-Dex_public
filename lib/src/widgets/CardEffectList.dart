import 'package:flutter/material.dart';
import '../data/models/effectModel.dart';
import 'CardEffect.dart';

class CardEffectList extends StatelessWidget {
  final List<EffectModel> effects;

  const CardEffectList({super.key, required this.effects});

  @override
  Widget build(BuildContext context) {
    if (effects.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: effects.asMap().entries.map((entry) {
        EffectModel effect = entry.value;
        return CardEffect(effect: effect);
      }).toList(),
    );
  }
}