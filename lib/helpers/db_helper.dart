import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/profile_data.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'profile_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE profile(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            role TEXT,
            bio TEXT
          )
        ''');
      },
    );
  }

  // Menyimpan data profil baru
  Future<int> insertProfile(ProfileData profile) async {
    final db = await database;
    return await db.insert(
      'profile',
      profile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Mengambil data profil terbaru
  Future<ProfileData?> getProfile() async {
    final db = await database;
    final List> maps = await db.query(
      'profile',
      orderBy: 'id DESC',
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return ProfileData.fromMap(maps.first);
    }
    return null;
  }

  // Memperbarui data profil
  Future<int> updateProfile(ProfileData profile) async {
    final db = await database;
    return await db.update(
      'profile',
      profile.toMap(),
      where: 'id = ?',
      whereArgs: [profile.id],
    );
  }
}