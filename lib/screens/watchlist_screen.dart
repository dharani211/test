// watchlist_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/watchlist_provider.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final watchlistProvider = Provider.of<WatchlistProvider>(context);
    final watchlist = watchlistProvider.watchlist;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist'),
      ),
      body: watchlist.isEmpty
          ? const Center(
              child: Text(
                'Your watchlist is empty.',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: watchlist.length,
              itemBuilder: (context, index) {
                final stock = watchlist[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  color: Colors.deepPurple[800],
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      stock['name'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'Price: \$${stock['price']}',
                      style: const TextStyle(color: Colors.white70),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        watchlistProvider.removeFromWatchlist(stock);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${stock['name']} removed from watchlist'),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
    );
  }
}
