// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/watchlist_provider.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/stock_details_screen.dart';
import 'screens/watchlist_screen.dart';
import 'screens/newsfeed_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const StocklyApp());
}

class StocklyApp extends StatelessWidget {
  const StocklyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WatchlistProvider()),
      ],
      child: MaterialApp(
        title: 'Stockly',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.purple,
          scaffoldBackgroundColor: Colors.deepPurple[900],
          appBarTheme: const AppBarTheme(color: Colors.deepPurple),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginSignupScreen(),
          '/home': (context) => const HomeScreen(),
          '/details': (context) => const StockDetailsScreen(),
          '/watchlist': (context) => const WatchlistScreen(),
          '/newsfeed': (context) => const NewsfeedScreen(),
        },
      ),
    );
  }
}
