/// User model for Firebase Realtime Database
class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String email;
  final String role;
  final String language;
  final int createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    this.email = '',
    this.role = 'consumer',
    this.language = 'English',
    required this.createdAt,
  });

  /// Create from Firebase RTDB JSON
  factory UserModel.fromJson(String uid, Map<dynamic, dynamic> json) {
    return UserModel(
      uid: uid,
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? 'consumer',
      language: json['language'] ?? 'English',
      createdAt: json['createdAt'] ?? 0,
    );
  }

  /// Convert to JSON for Firebase RTDB write
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
      'role': role,
      'language': language,
      'createdAt': createdAt,
    };
  }
}
