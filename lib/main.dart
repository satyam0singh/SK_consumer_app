import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'services/auth_service.dart';
import 'screens/login_screen/index.dart';
import 'screens/home_screen/index.dart';
import 'screens/cart/index.dart';
import 'screens/checkout/index.dart';
import 'screens/profile/index.dart';
import 'screens/orders/index.dart';
import 'screens/subscriptions/index.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AuthService.initializeGoogle();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartKrishi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1B8A6E)),
        useMaterial3: true,
      ),
      home: const AuthGate(),
      routes: {
        '/home': (context) => const HomeScreenPage(),
        '/subscriptions': (context) => const SubscriptionsPage(),
        '/cart': (context) => const CartPage(),
        '/checkout': (context) => const CheckoutPage(),
        '/profile': (context) => const ProfilePage(),
        '/orders': (context) => const OrderHistoryPage(),
        '/login': (context) => const LoginScreen(),
      },
    );
  }
}

/// Auth gate — checks if user is already logged in
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Already authenticated → go to home
      return const HomeScreenPage();
    }
    // Not authenticated → show onboarding
    return const OnboardingScreen();
  }
}
