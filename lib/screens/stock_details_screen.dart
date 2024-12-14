// stock_details_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/finnhub_api_service.dart';
import '../services/watchlist_provider.dart';

class StockDetailsScreen extends StatelessWidget {
  const StockDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Details'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: FinnhubAPIService
            .getStocksData(), // Fetch stock data from Finnhub API
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          final stocks = snapshot.data ?? [];
          if (stocks.isEmpty) {
            return const Center(
              child: Text(
                'No stocks available.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: stocks.length,
            itemBuilder: (context, index) {
              final stock = stocks[index];
              final isIncreasing =
                  stock['change'] > 0; // Determine price change
              final watchlistProvider = Provider.of<WatchlistProvider>(context);
              final isInWatchlist = watchlistProvider.isInWatchlist(stock);

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
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
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price: \$${stock['price']}',
                            style: const TextStyle(color: Colors.white70),
                          ),
                          Text(
                            '${stock['change']}%',
                            style: TextStyle(
                              color: isIncreasing ? Colors.green : Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Simple graphical representation using colored bars
                      Stack(
                        children: [
                          Container(
                            height: 10,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor:
                                (stock['change'].abs() / 100).clamp(0.0, 1.0),
                            child: Container(
                              height: 10,
                              decoration: BoxDecoration(
                                color: isIncreasing ? Colors.green : Colors.red,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      isInWatchlist ? Icons.favorite : Icons.favorite_border,
                      color: isInWatchlist ? Colors.red : Colors.white,
                    ),
                    onPressed: () {
                      if (isInWatchlist) {
                        watchlistProvider.removeFromWatchlist(stock);
                      } else {
                        watchlistProvider.addToWatchlist(stock);
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
