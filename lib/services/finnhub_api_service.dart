// finnhub_api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class FinnhubAPIService {
  static const String _apiKey = 'ctbm2dhr01qvslqusgv0ctbm2dhr01qvslqusgvg';
  static const String _baseUrl = 'https://finnhub.io/api/v1';

  // Method to fetch latest stock data
  static Future<List<Map<String, dynamic>>> getStocksData() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/stock/symbol?exchange=US&token=$_apiKey'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.take(15).map((stock) {
          // Simulated stock data structure for demonstration
          return {
            'name': stock['displaySymbol'],
            'price': (100 + stock['symbol'].length * 3)
                .toDouble(), // Simulated price
            'change': (stock['symbol'].length % 5 - 2)
                .toDouble(), // Simulated change percentage
            'chart': List.generate(
              7,
              (i) => [
                i.toDouble(),
                100 + i * (stock['symbol'].length % 3)
              ], // Simulated chart points
            ),
          };
        }).toList();
      } else {
        throw Exception('Failed to fetch stock data');
      }
    } catch (e) {
      throw Exception('Error fetching stocks: $e');
    }
  }

  // Method to fetch latest financial news
  static Future<List<Map<String, dynamic>>> getLatestNews() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/news?category=general&token=$_apiKey'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((newsItem) {
          return {
            'headline': newsItem['headline'],
            'summary': newsItem['summary'],
            'url': newsItem['url'],
          };
        }).toList();
      } else {
        throw Exception('Failed to fetch latest news');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }
}
