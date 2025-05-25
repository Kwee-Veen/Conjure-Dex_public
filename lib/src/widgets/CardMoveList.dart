import 'package:conjure_dex/src/viewModels/cardDetails_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CardMove.dart';

class CardMoveList extends StatelessWidget {
  final CardDetailsViewModel vm = Get.put(CardDetailsViewModel());

  CardMoveList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final card = vm.card.value;

      if (card == null) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        shrinkWrap: true,
        // makes the list non-scrollable - otherwise it can be irritating when navigating
        physics: const NeverScrollableScrollPhysics(),
        itemCount: card.moves.length,
        itemBuilder: (context, index) {
          return CardMove(move: card.moves[index]);
        },
      );
    });
  }
}

