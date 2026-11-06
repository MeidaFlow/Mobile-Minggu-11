import 'dart:convert';

class ProfileData {
  final int? id;
  final String name;
  final String role;
  final String bio;

  ProfileData({
    this.id,
    required this.name,
    required this.role,
    required this.bio,
  });

  // Mengubah data profil menjadi Map untuk SQLite
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'name': name,
      'role': role,
      'bio': bio,
    };
  }

  // Mengubah Map SQLite menjadi objek ProfileData
  factory ProfileData.fromMap(Map<String, dynamic> map) {
    return ProfileData(
      id: map['id'] as int?,
      name: map['name'] ?? '',
      role: map['role'] ?? '',
      bio: map['bio'] ?? '',
    );
  }

  String toJson() => jsonEncode(toMap());

  factory ProfileData.fromJson(String source) {
    return ProfileData.fromMap(
      jsonDecode(source) as Map<String, dynamic>,
    );
  }
}