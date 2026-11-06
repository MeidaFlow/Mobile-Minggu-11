import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  PrefService._(this._prefs);

  final SharedPreferences _prefs;

  // Key untuk menyimpan jumlah aplikasi dibuka
  static const _kOpenCount = 'open_count';
  static const _kDarkMode = 'is_dark_mode';

  // Mengambil data penyimpanan
  static Future<PrefService> init() async {
    final prefs = await SharedPreferences.getInstance();
    return PrefService._(prefs);
  }

  // Mengambil jumlah aplikasi dibuka
  int get openCount => _prefs.getInt(_kOpenCount) ?? 0;

  // Menambahkan jumlah aplikasi dibuka
  Future<void> increaseOpenCount() =>
      _prefs.setInt(_kOpenCount, openCount + 1);

  // Mengambil pengaturan tema
  bool get isDarkMode => _prefs.getBool(_kDarkMode) ?? false;

  // Menyimpan pengaturan tema
  Future<void> setDarkMode(bool value) =>
    _prefs.setBool(_kDarkMode, value);
}
