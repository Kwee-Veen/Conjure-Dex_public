import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/cardModel.dart';
import '../viewModels/browse_viewModel.dart';
import '../widgets/CardsListWidget.dart';

class BrowseView extends StatelessWidget {
  final BrowseViewModel viewModel = Get.put(BrowseViewModel());

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double contentWidth = screenWidth > 800 ? 800 : screenWidth;

    return GestureDetector(
      onTap: () {
        // Gets rid of the keyboard when tapping outside the text field
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Conjure Dex")),
        body: Center(
          child: SizedBox(
            width: contentWidth,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (query) => viewModel.searchCards(query),
                    decoration: InputDecoration(
                      hintText: "Search Cards...",
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                Expanded(
                  child: Obx(() {
                    final List<CardModel> cards = viewModel.filteredCards.toList();
                    return CardsListWidget(cards: cards);
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}