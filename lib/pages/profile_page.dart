import 'package:flutter/material.dart';
import '../models/profile_data.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileData profile = ProfileData(
    name: 'Meida',
    role: 'Mahasiswa Teknik Informatika',
    bio: 'Saya sedang belajar membuat aplikasi mobile menggunakan Flutter.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil Digital'),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(20),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircleAvatar(
                  radius: 45,
                  child: Icon(Icons.person, size: 50),
                ),
                const SizedBox(height: 16),
                Text(
                  profile.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(profile.role),
                const SizedBox(height: 12),
                Text(
                  profile.bio,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}