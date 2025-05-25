import 'package:flutter/material.dart';
import '../data/models/cardModel.dart';
import 'miniCardList.dart';

class CardsListWidget extends StatelessWidget {
  final List<CardModel> cards;

  const CardsListWidget({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return Center(child: Text("No cards found"));
    }
    return MiniCardList(cards: cards);
  }
}
