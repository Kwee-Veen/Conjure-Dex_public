import 'package:conjure_dex/colours.dart';
import 'package:flutter/material.dart';
import 'package:popover/popover.dart';

class Popup extends StatelessWidget {
  final Widget child;
  final Widget popupContent;
  final bool? biggerSize;

  const Popup({
    super.key,
    required this.child,
    required this.popupContent,
    this.biggerSize,
  });

  void _showPopup(BuildContext context) {
    final double popupWidth = 220;
    final double popupHeight = (biggerSize == true) ? 200 : 100;

    // Compensates for the fact Popup can't automatically tell if the screen's width has been capped
    final screenWidth = MediaQuery.of(context).size.width;
    final double extraWidth = screenWidth > 700 ? (screenWidth - 700) / 2 : 0;

    showPopover(
      context: context,
      bodyBuilder: (context) => Container(
        padding: const EdgeInsets.all(10),
        child: popupContent,
      ),
      width: popupWidth,
      height: popupHeight,
      backgroundColor: AppColors.blackFeature,
      barrierColor: Colors.transparent,
      transitionDuration: Duration(milliseconds: 150),
      arrowDxOffset: -extraWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showPopup(context),
        child: Container(
          child: child,
        ),
      ),
    );
  }
}
