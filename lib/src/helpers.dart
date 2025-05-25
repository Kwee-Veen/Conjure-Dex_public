import 'package:get/get.dart';

String getType(int value) {
  switch (value) {
    case 1:
      return "magic";
    case 2:
      return "machine";
    case 3:
      return "cosmic";
    case 4:
      return "mutant";
    case 5:
      return "nightmare";
    default:
      return "normal";
  }
}

String getTypeAdvantage(int value) {
  if (value == 0) return "";
  if (value == 1) return "Nightmare";
  return getType(value - 1).capitalize!;
}

String getTypeWeakness(int value) {
  if (value == 0) return "";
  if (value == 5) return "Magic";
  return getType(value + 1).capitalize!;
}

String getDamageType(int? type) {
  String damage = "";
  switch (type) {
    case 0:
      damage = "fire";
    case 1:
      damage = "ice";
    case 2:
      damage = "wind";
    case 3:
      damage = "earth";
    case 4:
      damage = "lightning";
    case 5:
      damage = "water";
    case 6:
      damage = "psychic";
    case 7:
      damage = "nature";
    case 8:
      damage = "light";
    case 9:
      damage = "dark";
    case 10:
      damage = "general";
    case 11:
      damage = "physical";
    case 12:
      damage = "ranged";
    default:
      damage = "";
  }
  return damage;
}

String getTargetType(int input) {
  String target = "";
  switch (input) {
    case 0:
      target = "Self";
    case 1:
      target = "Enemies";
    case 2:
      target = "Allies";
    case 3:
      target = "Everyone";
    default:
      target = "Enemies";
  }
  return target;
}

String getPhysicalOrRangedIcon(bool? input) {
  String icon = "";
  switch (input) {
    case true:
      icon = "damage_physical.png";
    case false:
      icon = "damage_ranged.png";
    case null:
      icon = "";
  }
  return icon;
}

String getMoveCostIcon(int input) {
  String icon = "";
  switch (input) {
    case 0:
      icon = "icon_ap.png";
    case 1:
      icon = "icon_mp.png";
    case 2:
      icon = "icon_hp.png";
    default:
      icon = "icon_ap.png";
  }
  return icon;
}

String getAreaOfEffectIcon(int? input) {
  String icon = "";
  switch (input) {
    case 0:
      icon = "";
    case 1:
      icon = "target_aoe_all.png";
    case 2:
      icon = "target_aoe_linear_cross.png";
    case 3:
      icon = "target_aoe_linear_column.png";
    case 4:
      icon = "target_aoe_linear_row.png";
    default:
      icon = "";
  }
  return icon;
}

String getRangeString(int? minRange, int? range, bool? lineOfSight) {
  String rangeString = "";
  if (lineOfSight == null) {
    rangeString = "";
  } else if (minRange != null) {
    rangeString = "$minRange-$range";
  } else {
    rangeString = "$range";
  }
  return rangeString;
}

String getStatusType(int? input) {
  String status = "";
    switch (input) {
      case 0:
        status = "poison";
      case 1:
        status = "bleed";
      case 2:
        status = "concuss";
      case 3:
        status = "leech";
      case 4:
        status = "slow";
      case 5:
        status = "immobilise";
      case 6:
        status = "petrify";
      case 7:
        status = "blind";
      case 8:
        status = "silence";
      case 9:
        status = "sleep";
      case 10:
        status = "confused";
      case 11:
        status = "paralyse";
      case 12:
        status = "heavy";
      case 13:
        status = "swimming";
      case 14:
        status = "flying";
      case 15:
        status = 'levitate';
      default:
        status = "";
    }
  return status;
}

String chancePercentageTranslator(int? chance) {
  switch (chance) {
    case 5: return "1/20";
    case 10: return "2/20";
    case 15: return "3/20";
    case 17: return "1/6";
    case 20: return "4/20";
    case 25: return "5/20";
    case 30: return "6/20";
    case 33: return "2/6";
    case 35: return "7/20";
    case 40: return "8/20";
    case 45: return "9/20";
    case 50: return "3/6";
    case 55: return "11/20";
    case 60: return "12/20";
    case 65: return "13/20";
    case 67: return "4/6";
    case 70: return "14/20";
    case 75: return "15/20";
    case 80: return "16/20";
    case 83: return "5/6";
    case 85: return "17/20";
    case 90: return "18/20";
    case 95: return "19/20";
    default: return "";
  }
}

String getStatusDescription(String? input) {
  String description = "";
  switch (input) {
    case "poison":
      description = "Poisoned \n\nLose 2HP at end of turn";
    case "bleed":
      description = "Bleeding \n\nLose 2HP for every 1MP spent";
    case "concuss":
      description = "Concussed \n\nLose 1HP for every 1AP spent";
    case "leech":
      description = "Leeched \n\nLose 2HP at end of turn. \n\nThe source of the leech gains 2HP.";
    case "slow":
      description = "Slowed \n\nLose 2MP";
    case "immobilise":
      description = "Immobilised \n\nCannot use MP";
    case "petrify":
      description = "Solidified \n\nTurned to stone. \n\nCan't act, and can't be hurt.";
    case "blind":
      description = "Blinded \n\nThe maximum range of all moves becomes 1";
    case "silence":
      description = "Silenced \n\nCannot use AP";
    case "sleep":
      description = "Sleeping \n\nCannot act. \n\nReawaken upon taking damage.";
    case "confused":
      description = "Confused \n\nYour moves have a 2/6 chance to either: \n\na) fail \nb) be redirected to yourself if they deal damage";
    case "paralyse":
      description = "Paralysed \n\nCannot act.";
    case "heavy":
      description = "Heavy \n\nCan't be pushed or pulled (but can be teleported). \n\nTake 2 damage for every 2MP spent crossing water.";
    case "swimming":
      description = "Swimming \n\nNot slowed by water. \n\n2/6 chance to dodge ranged attacks while in water.";
    case "flying":
      description = "Flying \n\nNot affected by terrain. \n\nDodge traps and non-ranged attacks. \n\nTake x2 damage from moves with 'Reach'";
    case "levitate":
      description = "Levitating \n\nNot affected by terrain. \n\nDodge traps.";
    default:
      description = "";
  }
  return description;
}
