import 'package:conjure_dex/src/helpers.dart';
import 'package:conjure_dex/src/widgets/popups/popup.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../colours.dart';
import '../data/models/effectModel.dart';

class CardEffect extends StatelessWidget {
  final EffectModel effect;

  const CardEffect({super.key, required this.effect});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final Size screenSize = MediaQuery.of(context).size;
    final double contentWidth = screenSize.width > 700 ? 700 : screenSize.width;
    double effectWidth =
        (contentWidth > 580) ? (contentWidth * 0.92) : (contentWidth * 0.85);

    String statusEffectType = getStatusType(effect.statusEffect),
        statusEffectDescription = getStatusDescription(statusEffectType);

    // Certain statuses need to render alternate icons in dark mode
    var alternateIconStatuses = [0, 5, 9, 10, 11, 12, 13, 14, 15];
    if (isDarkMode && alternateIconStatuses.contains(effect.statusEffect)) {
      statusEffectType += "_white";
    }

    String damageModifierType = effect.damageMod != null
        ? getDamageType(effect.damageMod!.damageType)
        : "";
    int? damageReceivedModifier =
        effect.damageMod != null ? -effect.damageMod!.modifier : null;

    TextStyle? popupTextColour = TextStyle(
        fontSize: 13,
        color: effect.damageMod != null
            ? (effect.damageMod!.modifier > 0
                ? AppColors.lightGreen
                : AppColors.mistyRose)
            : AppColors.aliceBlue);

    final bool hasDescription = effect.effectDescription != null &&
        effect.effectDescription!.isNotEmpty;

    // Start of effect string - will build it as it goes along
    String effectString = "";

    if (effect.effectChance != null) {
      effectString +=
          "${chancePercentageTranslator(effect.effectChance!)} chance";
    }

    if (effect.effectChance == null && effect.removeEffect) {
      effectString += "Remove";
    } else if (effect.removeEffect) {
      effectString += " to remove";
    }

    if (effect.turns != null &&
        effect.effectChance == null &&
        !effect.removeEffect) {
      effectString += "For ${effect.turns} turn${effect.turns! > 1 ? "s" : ""}";
    } else if (effect.turns != null) {
      effectString +=
          " for ${effect.turns} turn${effect.turns! > 1 ? "s" : ""}";
    }

    if (effect.effectChance != null ||
        effect.turns != null ||
        effect.removeEffect) {
      effectString += ":\n";
    }

    hasDescription ? effectString += effect.effectDescription! : null;

    return Card(
      child: Container(
        width: effectWidth,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text(
                  effectString,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
                if (effect.damageMod != null)
                  Popup(
                    popupContent: Text(
                      "${damageModifierType.capitalize} defence ${(effect.damageMod!.modifier > 0 ? '+' : '') + effect.damageMod!.modifier.toString()}"
                      "\n\nTarget takes ${(damageReceivedModifier! > 0 ? '+' : '') + damageReceivedModifier.toString()} damage from $damageModifierType attacks",
                      style: popupTextColour,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/Icons/defence_${getDamageType(effect.damageMod!.damageType)}.png",
                          width: 45,
                          height: 45,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 4),
                        Text(
                          effect.damageMod!.modifier.toString(),
                          style: TextStyle(
                            fontSize: 24,
                            fontFamily: 'TrueCrimes',
                          ),
                        ),
                      ],
                    ),
                  )
                else if (effect.statusEffect != null)
                  Popup(
                    biggerSize: true,
                    popupContent:
                        Text(statusEffectDescription, style: popupTextColour),
                    child: Image.asset(
                      "assets/images/Icons/status_$statusEffectType.png",
                      width: 40,
                      height: 40,
                      fit: BoxFit.contain,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
