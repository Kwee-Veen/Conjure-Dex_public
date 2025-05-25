import 'package:conjure_dex/colours.dart';
import 'package:conjure_dex/src/helpers.dart';
import 'package:conjure_dex/src/widgets/popups/popup.dart';
import 'package:flutter/material.dart';
import '../data/models/moveModel.dart';
import 'CardEffectList.dart';

class CardMove extends StatelessWidget {
  final MoveModel move;

  const CardMove({super.key, required this.move});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    String moveCostIcon = getMoveCostIcon(move.altCost),
        physicalOrRangedIcon = getPhysicalOrRangedIcon(move.physical),
        range = getRangeString(move.minRange, move.range, move.lineOfSight),
        aoeTypeIcon = getAreaOfEffectIcon(move.areaOfEffectType),
        target = getTargetType(move.target),

        damageTypeIcon = (move.damageType != null && move.damageType != 0)
            ? getDamageType(move.damageType! - 1)
            : "",

        damageBlockString =
          'Deals ${move.damage} ${move.physical == true ? "physical " : "ranged "}${move.damageType != 0 ? "$damageTypeIcon " : ""}damage',

        rangeBlockString = (move.range == 0
          ? "Can only be cast on self"
          : (
            move.range == 1 ? "Range: 1"
            : 'Range:${(move.minRange != null && move.minRange! > 0) ? " ${move.minRange} to" : ""} ${move.range}'
                '\n\n${(move.lineOfSight == true) ? "Requires" : "Does not require"} line of sight with the target.'
                '\n\n${move.linear == true ? "Linear: must be cast in a straight line." : ""}'
          )
        ),

        aoeBlockString = ( (move.areaOfEffectSize != null && move.areaOfEffectSize! > 0)
          ? '${move.areaOfEffectType == 1 ? "Full AoE. \n\nAffects a ${move.areaOfEffectSize}-cell area around target. \n\nIncludes diagonal cells, which count as 2 cells away." : ""}'
            '${move.areaOfEffectType == 2 ? "Cross AoE. \n\nAffects a ${move.areaOfEffectSize}-cell area around target. \n\nDoesn't include diagonal cells." : ""}'
            '${move.areaOfEffectType == 3 ? "Column AoE. \n\nAffects a ${move.areaOfEffectSize}-cell area behind target." : ""}'
            '${move.areaOfEffectType == 4 ? "Row AoE. \n\nAffects a ${move.areaOfEffectSize}-cell area to the target's sides." : ""}'
          : ''
        );

    Color cardColour =
            isDarkMode ? AppColors.blackFeature : AppColors.whiteFeature,
        titleColour =
            isDarkMode ? AppColors.uranianBlue : AppColors.darkUranianBlue,
        targetColour =
            isDarkMode ? AppColors.papayaWhip : AppColors.darkPapayaWhip,
        damageColour = isDarkMode ? AppColors.sunGlow : AppColors.darkSunGlow,
        rangeColour =
            isDarkMode ? AppColors.nonPhotoBlue : AppColors.darkNonPhotoBlue,
        aoeColour =
            isDarkMode ? AppColors.champagnePink : AppColors.darkChampagnePink;

    TextStyle popupTextStyling = TextStyle(color: AppColors.aliceBlue, fontSize: 13);

    return Card(
      color: cardColour,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        child: Column(
          children: [
            // Row 1: Move Image & Name block, and target block
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Move Cost & Name block
                Expanded(
                  child: Row(
                    children: [
                      if (move.apCost != null)
                        Popup(
                          popupContent: Text(
                              "Move cost: ${move.apCost} ${moveCostIcon.substring(5, moveCostIcon.length - 4).toUpperCase()}",
                              style: popupTextStyling),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.asset(
                                "assets/images/Icons/$moveCostIcon",
                                width: 50,
                                height: 50,
                              ),
                              Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                color: Colors.transparent,
                                child: Text(
                                  move.apCost.toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontFamily: 'TrueCrimes',
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      const SizedBox(width: 8),
                      if (move.name != "")
                        Text(
                          move.name,
                          style: TextStyle(
                            fontFamily: 'TrueCrimes',
                            fontSize: 26,
                            color: titleColour,
                          ),
                        ),
                    ],
                  ),
                ),

                // Target block
                if (target != "Self")
                  Popup(
                    popupContent:
                        Text("${move.name} affects $target.", style: popupTextStyling),
                    child: Text(
                      target,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: targetColour,
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 5),

            // Row 2: Damage block, Range block, and Area of Effect block
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Damage block
                Expanded(
                  flex: 3,
                  child: move.damage != null
                      ? Popup(
                          popupContent:
                              Text(damageBlockString, style: popupTextStyling),
                          child: Row(
                            children: [
                            SizedBox(width: 10),
                              if (physicalOrRangedIcon != "")
                                Image.asset(
                                  "assets/images/Icons/$physicalOrRangedIcon",
                                  width: 37,
                                  height: 37,
                                  colorBlendMode: isDarkMode
                                      ? BlendMode.srcIn
                                      : BlendMode.dst,
                                  color: isDarkMode ? Colors.white : null,
                                ),
                              if (physicalOrRangedIcon != "") SizedBox(width: 6),
                              Text(
                                move.damage.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'TrueCrimes',
                                  color: damageColour,
                                ),
                              ),
                              if (damageTypeIcon != "" &&
                                  damageTypeIcon != "general")
                                Image.asset(
                                  "assets/images/Icons/damage_$damageTypeIcon.png",
                                  width: 45,
                                  height: 45,
                                ),
                            ],
                          ))
                      : const SizedBox.shrink(),
                ),

                // Range block
                Expanded(
                  flex: 3,
                  child: range != ""
                      ? Popup(
                          biggerSize: (move.range != null && move.range! > 1 ? true : false),
                          popupContent:
                              Text(rangeBlockString, style: popupTextStyling),
                          child: Row(
                            children: [
                              SizedBox(width: 10),
                              Image.asset(
                                "assets/images/Icons/${move.lineOfSight == false ? "status_blind" : "target_range"}.png",
                                width: 50,
                                height: 50,
                                colorBlendMode: isDarkMode
                                    ? BlendMode.srcIn
                                    : BlendMode.dst,
                                color: isDarkMode ? Colors.white : null,
                              ),
                              Text(
                                range,
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'TrueCrimes',
                                  color: rangeColour,
                                ),
                              ),
                              if (move.linear)
                                Image.asset(
                                  "assets/images/Icons/target_linear.png",
                                  width: 30,
                                  height: 30,
                                  colorBlendMode: isDarkMode
                                      ? BlendMode.srcIn
                                      : BlendMode.dst,
                                  color: isDarkMode ? Colors.white : null,
                                ),
                            ],
                          ),
                        )
                      : const SizedBox.shrink(),
                ),

                // Area of Effect block
                Expanded(
                  flex: 2,
                  child: (move.areaOfEffectSize != null &&
                          move.areaOfEffectSize! > 0 &&
                          aoeTypeIcon != "")
                      ? Popup(
                          biggerSize: true,
                          popupContent: Text(aoeBlockString, style: popupTextStyling),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/images/Icons/$aoeTypeIcon",
                                width: 40,
                                height: 40,
                                colorBlendMode: isDarkMode
                                    ? BlendMode.srcIn
                                    : BlendMode.dst,
                                color: isDarkMode ? Colors.white : null,
                              ),
                              Text(
                                move.areaOfEffectSize.toString(),
                                style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'TrueCrimes',
                                  color: aoeColour,
                                ),
                              ),
                            ],
                          ))
                      : const SizedBox.shrink(),
                ),
              ],
            ),
            Row(
              children: [
                CardEffectList(effects: move.effects),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
