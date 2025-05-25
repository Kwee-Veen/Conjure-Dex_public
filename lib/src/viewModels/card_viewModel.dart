import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../data/models/cardModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardViewModel extends GetxController {
  var cards = <CardModel>[].obs;
  var cardsLoaded = false.obs;
  var recentCardIds = <String>[].obs;
  final int maxRecent = 12;

  @override
  void onInit() {
    super.onInit();
    _loadDBCards();
    _loadRecentCards();
  }

  Future<void> _loadDBCards() async {
    try {
      final jsonString = await rootBundle.loadString('assets/ConjureCards.json');
      final jsonData = json.decode(jsonString);
      final loadedCards = jsonData.map<CardModel>((item) => CardModel.fromJson(item)).toList();
      // shuffle puts the retrieved cards in random order, for fun novelty's sake
      loadedCards.shuffle();
      cards.assignAll(loadedCards);
      cardsLoaded.value = true;
    
    } catch (e) {
      print('Error loading db cards: $e');
      cardsLoaded.value = true;
      cards.value = [];
    }
  }

  Future<void> _loadRecentCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString("recent_cards");
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      recentCardIds.assignAll(jsonList.map((e) => e.toString()).toList());
    }
  }

  Future<void> _saveRecentCards() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(recentCardIds);
    await prefs.setString("recent_cards", jsonString);
  }

  void addRecentCard(String cardId) {
    // Remove if it already exists.
    recentCardIds.remove(cardId);
    // Insert at the beginning so it's the most recent.
    recentCardIds.insert(0, cardId);
    // Maintain a maximum of 12 cards.
    if (recentCardIds.length > maxRecent) {
      recentCardIds.removeLast();
    }
    _saveRecentCards();
  }
}