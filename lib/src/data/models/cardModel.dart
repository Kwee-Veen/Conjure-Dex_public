import 'damageModifierModel.dart';
import 'moveModel.dart';

class CardModel {
  final String id;
  final String name;
  final String? description;
  final int? hp;
  final int? ap;
  final int? mp;
  final int cost;
  final int? type;
  final List<DamageModifierModel> damageModifiers;
  final List<MoveModel> moves;

  CardModel({
    String? id,
    required this.name,
    this.description,
    this.hp,
    this.ap,
    this.mp,
    this.cost = 1,
    this.type,
    this.damageModifiers = const [],
    this.moves = const [],
  }) : id = id ?? "";

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    id: json['id'] ?? "",
    name: json['name'] ?? "",
    description: json['description'],
    hp: json['hp'],
    ap: json['ap'],
    mp: json['mp'],
    cost: json['cost'] ?? 1,
    type: json['type'],
    damageModifiers: (json['damageModifiers'] as List<dynamic>?)
        ?.map((e) => DamageModifierModel.fromJson(e))
        .toList() ??
        [],
    moves: (json['moves'] as List<dynamic>?)
        ?.map((e) => MoveModel.fromJson(e))
        .toList() ??
        [],
  );
}