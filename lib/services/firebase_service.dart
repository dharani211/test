// firebase_service.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveWatchlist(String userId, List<String> stocks) async {
    await _firestore.collection('watchlists').doc(userId).set({
      'stocks': stocks,
    });
  }

  Future<List<String>> getWatchlist(String userId) async {
    final doc = await _firestore.collection('watchlists').doc(userId).get();
    return (doc.data()?['stocks'] ?? []).cast<String>();
  }
}
