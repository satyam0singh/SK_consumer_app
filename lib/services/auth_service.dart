import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../data/repositories/user_repository.dart';

/// Unified authentication service.
///
/// Consolidates phone OTP, Google sign-in, and provider linking
/// so that ONE user always maps to ONE Firebase UID.
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final UserRepository _userRepo = UserRepository();

  User? get currentUser => _auth.currentUser;

  // ─── Initialization ───────────────────────────────────────

  static Future<void> initializeGoogle() async {
    try {
      await GoogleSignIn.instance.initialize();
    } catch (e) {
      debugPrint('Google Sign-In init error: $e');
    }
  }

  // ─── Phone OTP ────────────────────────────────────────────

  /// Send OTP to [phoneNumber] (E.164 format: +91XXXXXXXXXX)
  Future<void> sendOTP({
    required String phoneNumber,
    required void Function(String verificationId, int? resendToken) onCodeSent,
    required void Function(PhoneAuthCredential credential) onAutoVerified,
    required void Function(String errorMessage) onError,
    int? forceResendingToken,
  }) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        forceResendingToken: forceResendingToken,
        verificationCompleted: onAutoVerified,
        verificationFailed: (FirebaseAuthException e) {
          onError(_mapPhoneError(e));
        },
        codeSent: onCodeSent,
        codeAutoRetrievalTimeout: (_) {},
      );
    } catch (e) {
      onError('Something went wrong. Please try again.');
    }
  }

  /// Sign in with phone credential (login flow)
  Future<User?> signInWithPhoneCredential(PhoneAuthCredential cred) async {
    final result = await _auth.signInWithCredential(cred);
    return result.user;
  }

  /// Create a phone credential from verificationId + smsCode
  PhoneAuthCredential createPhoneCredential({
    required String verificationId,
    required String smsCode,
  }) {
    return PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
  }

  /// Sign in with phone OTP (login flow)
  Future<User?> signInWithPhone({
    required String verificationId,
    required String smsCode,
  }) async {
    final cred = createPhoneCredential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    return signInWithPhoneCredential(cred);
  }

  // ─── Google ───────────────────────────────────────────────

  /// Sign in with Google (login flow)
  Future<User?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;

      final cred = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      final result = await _auth.signInWithCredential(cred);
      return result.user;
    } on GoogleSignInException {
      return null; // User cancelled
    } catch (e) {
      throw AuthException('Google sign-in failed. Please try again.');
    }
  }

  // ─── Provider Linking ─────────────────────────────────────

  /// Link a phone credential to the currently signed-in user.
  ///
  /// Use case: Google user verifies their phone in ProfileSetup.
  /// After this, both Phone + Google point to the SAME UID.
  ///
  /// If the phone is already associated with a different Firebase account
  /// (`credential-already-in-use`), we sign into that existing account
  /// instead — preventing duplicates.
  ///
  /// Returns the final [User] (either the linked current user,
  /// or the existing account that owns the phone).
  Future<User?> linkPhoneToCurrentUser({
    required String verificationId,
    required String smsCode,
  }) async {
    final cred = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    try {
      final result = await _auth.currentUser!.linkWithCredential(cred);
      return result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'credential-already-in-use') {
        // Phone already belongs to another account.
        // Sign in with that account instead (the one that has the phone).
        final result = await _auth.signInWithCredential(cred);
        return result.user;
      }
      rethrow;
    }
  }

  // ─── Post-Login Routing ───────────────────────────────────

  /// Check if user has a profile via API.
  /// Returns true if profile exists (→ go Home), false if new (→ ProfileSetup).
  Future<bool> checkProfileExists(User user) async {
    return _userRepo.profileExists();
  }

  // ─── Sign Out ─────────────────────────────────────────────

  Future<void> signOut() async {
    try { await GoogleSignIn.instance.signOut(); } catch (_) {}
    await _auth.signOut();
  }

  // ─── Error Mapping ────────────────────────────────────────

  String _mapPhoneError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-phone-number':
        return 'Invalid phone number. Please check and try again.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait before trying again.';
      case 'quota-exceeded':
        return 'SMS quota exceeded. Please try later.';
      case 'network-request-failed':
        return 'Network error. Check your connection.';
      default:
        return e.message ?? 'Verification failed. Please try again.';
    }
  }
}

/// Custom exception for auth errors
class AuthException implements Exception {
  final String message;
  AuthException(this.message);

  @override
  String toString() => message;
}
