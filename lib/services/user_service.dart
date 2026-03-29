import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

/// Firebase Realtime Database service for user profiles.
///
/// Single profile per UID. No secondary indexes needed because
/// Firebase Auth handles provider linking (phone ↔ Google → same UID).
class UserService {
  final DatabaseReference _dbRef =
      FirebaseDatabase.instance.ref('userProfiles');

  /// Check if a user profile exists
  Future<bool> checkUserExists(String uid) async {
    final snapshot = await _dbRef.child(uid).get();
    return snapshot.exists;
  }

  /// Create consumer profile (called once per user)
  Future<void> createConsumerProfile({
    required User user,
    required String name,
    required String phone,
    String email = '',
    String language = 'English',
  }) async {
    await _dbRef.child(user.uid).set({
      'name': name,
      'phone': phone,
      'email': email.isNotEmpty ? email : (user.email ?? ''),
      'role': 'consumer',
      'language': language,
      'createdAt': ServerValue.timestamp,
    });
  }

  /// Fetch user profile data
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final snapshot = await _dbRef.child(uid).get();
    if (snapshot.exists && snapshot.value != null) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    }
    return null;
  }
}
