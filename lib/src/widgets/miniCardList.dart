import 'package:flutter/material.dart';

import '../data/models/cardModel.dart';
import 'miniCard.dart';

class MiniCardList extends StatelessWidget {
  final List<CardModel> cards;

  const MiniCardList({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];

        return MiniCard(
          card: card,
          onTap: () {
          },
        );

      },
    );

  }
}