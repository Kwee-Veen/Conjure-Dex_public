import 'package:get/get.dart';
import '../data/models/cardModel.dart';
import 'card_viewModel.dart';

class RecentCardsViewModel extends GetxController {
  final CardViewModel cardViewModel = Get.find();

  var cards = <CardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _setCards();
  }

  void _setCards() {
    List<CardModel> recentCards = cardViewModel.cards.where((card) =>
        cardViewModel.recentCardIds.contains(card.id)
    ).toList();
    // Orders the cards by the index of their ids in the recentCardIds list.
    // Helps keep the recent cards order chronological by access date.
    recentCards.sort((a, b) => cardViewModel.recentCardIds
        .indexOf(a.id)
        .compareTo(cardViewModel.recentCardIds.indexOf(b.id)));
    cards.assignAll(recentCards);
  }
}
