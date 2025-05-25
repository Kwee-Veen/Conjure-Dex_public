import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/cardModel.dart';
import 'card_viewModel.dart';

class CardDetailsViewModel extends GetxController {
  var card = Rxn<CardModel>();
  final CardViewModel cardVM = Get.find();

  void setCard(CardModel newCard) {
    card.value = newCard;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cardVM.addRecentCard(newCard.id);
    });
  }
}