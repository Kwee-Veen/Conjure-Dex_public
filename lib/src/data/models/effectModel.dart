import 'damageModifierModel.dart';

class EffectModel {
  final int target;
  final int? effectChance;
  final bool removeEffect;
  final int? statusEffect;
  final DamageModifierModel? damageMod;
  final int? turns;
  final String? effectDescription;
  final String id;

  EffectModel({
    required this.target,
    this.effectChance,
    this.removeEffect = false,
    this.statusEffect,
    this.damageMod,
    this.turns,
    this.effectDescription,
    String? id,
  }) : id = id ?? "";

  factory EffectModel.fromJson(Map<String, dynamic> json) => EffectModel(
    target: json['target'] ?? 0,
    effectChance: json['effectChance'],
    removeEffect: json['removeEffect'] ?? false,
    statusEffect: json['statusEffect'],
    damageMod: json['damageMod'] != null
        ? DamageModifierModel.fromJson(json['damageMod'])
        : null,
    turns: json['turns'],
    effectDescription: json['effectDescription'],
    id: json['id'] ?? "",
  );
}