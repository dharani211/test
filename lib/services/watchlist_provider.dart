// watchlist_provider.dart
import 'package:flutter/material.dart';

class WatchlistProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _watchlist = [];

  List<Map<String, dynamic>> get watchlist => _watchlist;

  void addToWatchlist(Map<String, dynamic> stock) {
    _watchlist.add(stock);
    notifyListeners();
  }

  void removeFromWatchlist(Map<String, dynamic> stock) {
    _watchlist.remove(stock);
    notifyListeners();
  }

  bool isInWatchlist(Map<String, dynamic> stock) {
    return _watchlist.contains(stock);
  }
}
