class DamageModifierModel {
  final int damageType;
  final int modifier;
  final String id;

  DamageModifierModel({
    required this.damageType,
    required this.modifier,
    String? id,
  }) : id = id ?? "";

  factory DamageModifierModel.fromJson(Map<String, dynamic> json) =>
      DamageModifierModel(
        damageType: json['damageType'] ?? 0,
        modifier: json['modifier'] ?? -1,
        id: json['id'] ?? "",
      );
}