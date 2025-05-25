import 'package:get/get.dart';
import 'card_viewModel.dart';
import '../data/models/cardModel.dart';

class BrowseViewModel extends GetxController {
  final CardViewModel cardViewModel = Get.find();

  var filteredCards = <CardModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredCards.assignAll(cardViewModel.cards);

    // Once cardViewModel loads cards from the db, cardsLoaded becomes true, triggering filteredCards to be assigned to their value
    ever(cardViewModel.cardsLoaded, (isLoaded) {
      if (isLoaded) {
        filteredCards.assignAll(cardViewModel.cards);
      }
    });
  }

  void searchCards(String query) {
    if (query.isEmpty) {
      filteredCards.assignAll(cardViewModel.cards);
    } else {
      filteredCards.assignAll(
        cardViewModel.cards.where((card) => card.name.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

}