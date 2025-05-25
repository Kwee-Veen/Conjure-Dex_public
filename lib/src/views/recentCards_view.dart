import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/cardModel.dart';
import '../viewModels/recentCards_viewModel.dart';
import '../widgets/CardsListWidget.dart';

class RecentCardsView extends StatelessWidget {
  final RecentCardsViewModel viewModel = Get.put(RecentCardsViewModel());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text("Recently Viewed Cards")),
        body: Center(
          child: Obx(() {
            final List<CardModel> cards = viewModel.cards.toList();
            if (cards.isEmpty) {
              return Center(child: Text("No recently viewed cards"));
            }
            return CardsListWidget(cards: cards);
          }),
        ),
      ),
    );
  }
}
