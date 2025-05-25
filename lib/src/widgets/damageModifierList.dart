import 'package:flutter/material.dart';
import '../data/models/damageModifierModel.dart';
import 'damageModifier.dart';

class DamageModifierList extends StatelessWidget {
  final List<DamageModifierModel> damageModifiers;

  const DamageModifierList({
    super.key,
    required this.damageModifiers,
  });

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        // calculates the width so there's at most 2 damage modifiers per row
        final double itemWidth = (constraints.maxWidth) / 2;
        return SingleChildScrollView(
          child: Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              children: damageModifiers.map((mod) {
                return SizedBox(
                  width: itemWidth,
                  child: DamageModifier(
                    dm: mod,
                  ),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
