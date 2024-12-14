// newsfeed_screen.dart
import 'package:flutter/material.dart';
import '../services/finnhub_api_service.dart';

class NewsfeedScreen extends StatelessWidget {
  const NewsfeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Newsfeed'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future:
            FinnhubAPIService.getLatestNews(), // Fetch news from Finnhub API
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

          final news = snapshot.data ?? [];

          if (news.isEmpty) {
            return const Center(
              child: Text(
                'No news available.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            itemCount: news.length,
            itemBuilder: (context, index) {
              final article = news[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                color: Colors.deepPurple[800],
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16.0),
                  title: Text(
                    article['headline'] ?? 'No Title',
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    article['summary'] ?? 'No Summary',
                    style: const TextStyle(color: Colors.white70),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios,
                      color: Colors.blueAccent),
                  onTap: () {
                    // Open the article's URL in a web browser
                    final url = article['url'];
                    if (url != null) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => NewsDetailScreen(url: url),
                        ),
                      );
                    }
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class NewsDetailScreen extends StatelessWidget {
  final String url;

  const NewsDetailScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
      ),
      body: Center(
        child: Text(
          'News article URL: $url',
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
