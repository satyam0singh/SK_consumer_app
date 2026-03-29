import '../../core/network/api_client.dart';

/// Repository for user profile operations — replaces direct UserService DB access.
class UserRepository {
  final ApiClient _api = ApiClient();

  /// Check if profile exists for current user
  Future<bool> profileExists() async {
    final data = await _api.get('getProfile');
    return data['exists'] == true;
  }

  /// Get user profile data
  Future<Map<String, dynamic>?> getProfile() async {
    final data = await _api.get('getProfile');
    if (data['exists'] == true && data['profile'] != null) {
      return Map<String, dynamic>.from(data['profile']);
    }
    return null;
  }

  /// Create consumer profile
  Future<void> createProfile({
    required String name,
    required String phone,
    String email = '',
    String language = 'English',
  }) async {
    await _api.post('createProfile', {
      'name': name,
      'phone': phone,
      'email': email,
      'language': language,
    });
  }
}
