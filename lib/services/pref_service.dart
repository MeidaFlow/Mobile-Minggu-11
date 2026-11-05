import 'package:shared_preferences/shared_preferences.dart';

class PrefService {
  PrefService._(this._prefs);

  final SharedPreferences _prefs;

  // Key untuk menyimpan jumlah aplikasi dibuka
  static const _kOpenCount = 'open_count';

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
}
