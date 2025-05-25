import 'package:conjure_dex/colours.dart';
import 'package:conjure_dex/src/widgets/CardMoveList.dart';
import 'package:conjure_dex/src/widgets/damageModifierList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/cardModel.dart';
import '../helpers.dart';
import '../viewModels/cardDetails_viewModel.dart';
import '../viewModels/card_viewModel.dart';
import '../widgets/popups/popup.dart';

class CardDetailsView extends StatelessWidget {
  final CardDetailsViewModel viewModel = Get.put(CardDetailsViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      var cardViewModel = Get.find<CardViewModel>();

      if (!cardViewModel.cardsLoaded.value) {
        return Center(child: CircularProgressIndicator());
      }

      String? id = Get.parameters['id'];
      bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
      CardModel? card = cardViewModel.cards.firstWhereOrNull((c) => c.id == id);

      // If no matching card found, will state the same for 1.3 seconds before heading back to the Browse view (seems long enough?)
      if (card == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Future.delayed(Duration(seconds: 1, milliseconds: 300), () {
            Get.offNamedUntil('/', ModalRoute.withName('/'));
          });
        });
        return Center(
            child: Text(
          'Card not found',
          style: const TextStyle(
            fontSize: 27,
            fontWeight: FontWeight.w900,
          ),
        ));
      }

      WidgetsBinding.instance.addPostFrameCallback((_) {
        viewModel.setCard(card);
      });

      // caps the card image width at 560px at max
      final double cardImageWidth =
          (MediaQuery.of(context).size.width * 0.85).clamp(0.0, 560.0);

      final popupFont = TextStyle(color: AppColors.aliceBlue, fontSize: 13);
      final type = getType(card.type!).capitalize;
      final String typeAdvantageString = (card.type! != 0)
          ? "+1 damage to ${getTypeAdvantage(card.type!)}. \n+1 damage from ${getTypeWeakness(card.type!)}."
          : "No strengths or weaknesses";

      return Scaffold(
        appBar: AppBar(
            title: Row(
          children: [
            Text(
              card.name,
              style: TextStyle(
                  fontFamily: 'TrueCrimes',
                  fontSize: (card.name.length > 15) ? 26 : 30,
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Popup(
              popupContent: Text("Summoning cost: ${card.cost.toString()}",
                  style: popupFont),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/Icons/icon_crystal_purple.png",
                    width: 55,
                    height: 55,
                  ),
                  Text(
                    card.cost.toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'TrueCrimes',
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Popup(
              popupContent:
                  Text("$type type: \n$typeAdvantageString", style: popupFont),
              child: Image.asset(
                "assets/images/Icons/type_${type?.toLowerCase()}.png",
                width: 60,
                height: 60,
                // if in dark mode, transforms the type icon to white
                colorBlendMode: isDarkMode ? BlendMode.srcIn : BlendMode.dst,
                color: isDarkMode ? Colors.white : null,
              ),
            ),
          ],
        )),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Hero(
                          tag: card.id,
                          child: Material(
                            color: Colors.transparent,
                            child: Container(
                              width: cardImageWidth,
                              height: cardImageWidth,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/CardImages/${card.id}.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        right: 1,
                        top: 0,
                        child: SizedBox(
                          height: cardImageWidth,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 50),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                for (var stat in [
                                  {
                                    'icon': 'icon_hp.png',
                                    'value': card.hp,
                                    'tooltip':
                                        "Hit points: ${card.hp} HP\nRequired to stay alive."
                                  },
                                  {
                                    'icon': 'icon_ap.png',
                                    'value': card.ap,
                                    'tooltip':
                                        "Action points: ${card.ap} AP\nSpent to use moves. \nReplenished each turn."
                                  },
                                  {
                                    'icon': 'icon_mp.png',
                                    'value': card.mp,
                                    'tooltip':
                                        "Movement points: ${card.mp} MP\nHow far you can move. \nReplenished each turn."
                                  },
                                ])
                                  Popup(
                                    popupContent: Text(
                                        stat['tooltip'].toString(),
                                        style: popupFont),
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/Icons/${stat['icon']}",
                                          width: 75,
                                          height: 75,
                                        ),
                                        Text(
                                          stat['value'].toString(),
                                          style: const TextStyle(
                                            fontSize: 32,
                                            fontFamily: 'TrueCrimes',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                Popup(
                                  biggerSize: true,
                                  popupContent: Image.asset(
                                    "assets/images/CardImages/${card.id}_QR.png",
                                    fit: BoxFit.contain,
                                  ),
                                  child: SizedBox(
                                    width: 65,
                                    height: 65,
                                    child: Image.asset(
                                      "assets/images/CardImages/${card.id}_QR.png",
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CardMoveList(),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DamageModifierList(
                            damageModifiers: card.damageModifiers),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
