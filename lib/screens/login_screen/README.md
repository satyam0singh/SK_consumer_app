# SmartKrishi Login Screen Module

This module contains all the authentication and onboarding screens for the SmartKrishi consumer app.

## 📁 Folder Structure

```
lib/
└── screens/
    └── login_screen/
        ├── index.dart                      # Main exports file
        ├── onboarding_screen.dart          # Onboarding carousel
        ├── login_screen.dart               # Mobile number input screen
        ├── otp_verification_screen.dart    # OTP verification screen
        └── profile_setup_screen.dart       # User profile creation screen
```

## 📱 Screens Overview

### 1. **Onboarding Screen** (`onboarding_screen.dart`)
- 3-page carousel showing app features
- Showcases:
  - Buy fresh produce directly from farmers
  - See how your food is grown
  - Track food from farm to doorstep
- Language toggle (EN/हिंदी)
- Skip button to go directly to login
- Page indicators and smooth navigation
- **Navigation**: Skip/Get Started → LoginScreen

### 2. **Login Screen** (`login_screen.dart`)
- Welcome screen with SmartKrishi branding
- Mobile number input field
- Dark mode toggle
- Continue with Google option
- Terms and Privacy Policy links
- Form validation
- **Navigation**: Continue → OTPVerificationScreen

### 3. **OTP Verification Screen** (`otp_verification_screen.dart`)
- 6-digit OTP input fields
- Masked phone number display
- Resend OTP functionality
- Auto-focus to next field on digit entry
- Submit on last digit entry
- Terms and Privacy Policy links
- **Navigation**: Verify → ProfileSetupScreen

### 4. **Profile Setup Screen** (`profile_setup_screen.dart`)
- User profile photo upload
- Full name input
- Email address input
- Preferred language selection (English, हिंदी, Nepali, More)
- Start Shopping button
- Multi-step indicator at bottom
- **Navigation**: Start Shopping → Home (TODO)

## 🎨 Design System

### Primary Color
- **Teal**: `#1B8A6E` (Color(0xFF1B8A6E))

### Typography
- **Headlines**: Bold, 24-28px
- **Body Text**: Regular, 14-16px
- **Forms**: Rounded corners (12px border radius)

### Components
- Text fields with prefix icons
- Elevated buttons (teal background)
- Outlined buttons (border style)
- Page indicators (active/inactive dots)

## 🔄 User Flow

```
OnboardingScreen
    ↓ (Skip/Get Started)
LoginScreen
    ↓ (Enter phone & Continue)
OTPVerificationScreen
    ↓ (Enter OTP & Verify)
ProfileSetupScreen
    ↓ (Complete Profile)
HomeScreen [TODO]
```

## ⚙️ Features Implemented

✅ **Onboarding Carousel**
- Multiple pages with smooth transitions
- Language selection
- Page indicators

✅ **Mobile Login**
- Phone number validation
- Google login option (UI ready)

✅ **OTP Verification**
- 6-digit input with auto-focus
- Resend OTP functionality
- Character validation

✅ **Profile Setup**
- Photo upload (UI ready)
- Multi-language support
- Form validation

## 📝 TODO Items

- [ ] Implement API integration for phone verification
- [ ] Implement Google authentication
- [ ] Implement image picker for profile photo
- [ ] Implement OTP resend API
- [ ] Create home screen navigation
- [ ] Add error handling and API responses
- [ ] Add loading states
- [ ] Implement local storage for user data
- [ ] Add analytics for user tracking

## 🚀 Usage

### Import all screens
```dart
import 'screens/login_screen/index.dart';
```

### Use individual screen
```dart
// In main.dart
home: const OnboardingScreen(),

// Navigate between screens
Navigator.of(context).push(
  MaterialPageRoute(
    builder: (context) => const LoginScreen(),
  ),
);
```

## 🔧 Dependencies

- `flutter/material.dart` - Flutter Material design
- No external packages required (uses Flutter built-in components)

## 📌 Notes

- All screens follow Material 3 design principles
- Responsive design for different screen sizes
- Color scheme uses teal (#1B8A6E) as primary color
- App supports dark mode UI toggle on login screen
- Forms validate input before navigation

## 👥 Contributing

When adding new screens to this module:
1. Create a new `.dart` file in `lib/screens/login_screen/`
2. Export it in `index.dart`
3. Update this README with screen details
4. Follow the established naming conventions and design patterns
