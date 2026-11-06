import 'package:flutter/material.dart';
import '../models/profile_data.dart';
import '../helpers/db_helper.dart'; // pastikan path helper SQLite kamu sesuai
import '../services/pref_service.dart';

class ProfilePage extends StatefulWidget {
  final PrefService prefService;
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const ProfilePage({
    super.key,
    required this.prefService,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _bioController = TextEditingController();

  final DatabaseHelper _dbHelper = DatabaseHelper();
  int? _currentId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  // Read data dari SQLite saat layar dibuka
  Future<void> _loadProfileData() async {
    final profile = await _dbHelper.getProfile();
    if (profile != null) {
      setState(() {
        _currentId = profile.id;
        _nameController.text = profile.name;
        _roleController.text = profile.role;
        _bioController.text = profile.bio;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  // Save / Update data ke SQLite
  Future<void> _saveProfileData() async {
    final profile = ProfileData(
      id: _currentId,
      name: _nameController.text,
      role: _roleController.text,
      bio: _bioController.text,
    );

    if (_currentId == null) {
      await _dbHelper.insertProfile(profile);
    } else {
      await _dbHelper.updateProfile(profile);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil berhasil disimpan ke SQLite!')),
      );
    }
    _loadProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kartu Profil Digital'),
        actions: [
          // Switch Dark Mode dari PrefService
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              widget.onThemeChanged(!widget.isDarkMode);
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  // Menampilkan info open count dari SharedPreferences
                  Text(
                    'Aplikasi dibuka: ${widget.prefService.openCount} kali',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Nama',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _roleController,
                    decoration: const InputDecoration(
                      labelText: 'Role / Jabatan',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _bioController,
                    decoration: const InputDecoration(
                      labelText: 'Bio',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _saveProfileData,
                    icon: const Icon(Icons.save),
                    label: const Text('Simpan Ke SQLite'),
                  ),
                ],
              ),
            ),
    );
  }
}