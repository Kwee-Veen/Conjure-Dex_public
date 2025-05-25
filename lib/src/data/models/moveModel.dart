import 'effectModel.dart';

class MoveModel {
  final String name;
  final int? apCost;
  final int altCost;
  final int? damage;
  final int? damageType;
  final bool? physical;
  final int? range;
  final int? minRange;
  final bool? lineOfSight;
  final bool linear;
  final int? areaOfEffectType;
  final int? areaOfEffectSize;
  final List<EffectModel> effects;
  final int target;
  final String id;

  MoveModel({
    required this.name,
    this.apCost,
    this.altCost = 0,
    this.damage,
    this.damageType,
    this.physical,
    this.range,
    this.minRange,
    this.lineOfSight,
    this.linear = false,
    this.areaOfEffectType,
    this.areaOfEffectSize,
    this.effects = const [],
    this.target = 1,
    String? id,
  }) : id = id ?? "";

  factory MoveModel.fromJson(Map<String, dynamic> json) => MoveModel(
    name: json['name'] ?? "",
    apCost: json['apCost'],
    altCost: json['altCost'] ?? 0,
    damage: json['damage'],
    damageType: json['damageType'],
    physical: json['physical'],
    range: json['range'],
    minRange: json['minRange'],
    lineOfSight: json['lineOfSight'],
    linear: json['linear'] ?? false,
    areaOfEffectType: json['areaOfEffectType'],
    areaOfEffectSize: json['areaOfEffectSize'],
    effects: (json['effects'] as List<dynamic>?)
        ?.map((e) => EffectModel.fromJson(e))
        .toList() ??
        [],
    target: json['target'] ?? 1,
    id: json['id'] ?? "",
  );
}