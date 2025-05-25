import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/models/cardModel.dart';

class MiniCard extends StatelessWidget {
  final CardModel card;
  final VoidCallback onTap;

  const MiniCard({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: card.id,
      flightShuttleBuilder: (
        BuildContext flightContext,
        Animation<double> animation,
        HeroFlightDirection flightDirection,
        BuildContext fromHeroContext,
        BuildContext toHeroContext,
      ) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            double currentOpacity = 0.3 + 0.7 * animation.value;
            return Opacity(
              opacity: currentOpacity,
              child: toHeroContext.widget,
            );
          },
        );
      },
      child: Card(
        elevation: 4,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/CardImages/${card.id}.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(card.name,
                  style: TextStyle(fontFamily: 'TrueCrimes', fontSize: 17)),
              subtitle: Text("Cost: ${card.cost}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  )),
              onTap: () {
                Get.toNamed('/open/${card.id}');
              },
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              dense: true,
            ),
          ],
        ),
      ),
    );
  }
}
