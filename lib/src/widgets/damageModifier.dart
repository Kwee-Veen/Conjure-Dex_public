import 'package:conjure_dex/src/data/models/damageModifierModel.dart';
import 'package:conjure_dex/src/widgets/popups/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../colours.dart';
import '../helpers.dart';

class DamageModifier extends StatelessWidget {
  final DamageModifierModel dm;

  const DamageModifier({super.key, required this.dm});

  @override
  Widget build(BuildContext context) {
    final damageReceivedModifier = -dm.modifier;
    final modifierTextColour =
        (dm.modifier > 0 ? AppColors.erinGreen : AppColors.vermilion);
    final popupTextColour = TextStyle(
        color: (dm.modifier > 0 ? AppColors.lightGreen : AppColors.mistyRose));

    String damageModifierType = getDamageType(dm.damageType);

    return Popup(
      popupContent: Text(
          "${damageModifierType.capitalize} defence ${(dm.modifier > 0 ? '+' : '') + dm.modifier.toString()} \n\nTake ${(damageReceivedModifier > 0 ? '+' : '') + damageReceivedModifier.toString()} damage from $damageModifierType attacks",
          style: popupTextColour),
      child: Card(
        margin: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            if (damageModifierType != "")
              Container(
                width: 110,
                height: 110,
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/Icons/defence_$damageModifierType.png",
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(width: 10),
            Text(
              (dm.modifier > 0 ? '+' : '') + dm.modifier.toString(),
              style: TextStyle(
                fontSize: 33,
                fontFamily: 'TrueCrimes',
                color: modifierTextColour,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
