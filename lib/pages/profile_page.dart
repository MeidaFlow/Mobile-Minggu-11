
import 'package:flutter/material.dart';
import '../models/profile_data.dart';
import '../services/pref_service.dart';

class ProfilePage extends StatelessWidget {
  final PrefService prefService;
  final bool isDarkMode;
  final ValueChanged<bool> onThemeChanged;

  ProfilePage({
    super.key,
    required this.prefService,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  final ProfileData profile = ProfileData(
    name: 'Meida',
    role: 'Mahasiswa Teknik Informatika',
    bio: 'Halo.',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil Digital'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
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
            const SizedBox(height: 10),
            Text(
              '${prefService.openCount} kali',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text('Kartu ini sudah dibuka'),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text('Mode Gelap'),
              subtitle: Text(
                isDarkMode ? 'Dark Mode Aktif' : 'Light Mode Aktif',
              ),
              value: isDarkMode,
              onChanged: onThemeChanged,
              secondary: const Icon(Icons.dark_mode),
            ),
          ],
        ),
      ),
    );
  }
}
