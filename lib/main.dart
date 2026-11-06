
import 'package:flutter/material.dart';
import 'pages/profile_page.dart';
import 'services/pref_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefService = await PrefService.init();
  await prefService.increaseOpenCount();

  runApp(MyApp(prefService: prefService));
}

class MyApp extends StatefulWidget {
  final PrefService prefService;

  const MyApp({super.key, required this.prefService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.prefService.isDarkMode
        ? ThemeMode.dark
        : ThemeMode.light;
  }

  Future<void> _changeTheme(bool isDark) async {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });

    await widget.prefService.setDarkMode(isDark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartu Profil Digital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      themeMode: _themeMode,
      home: ProfilePage(
        prefService: widget.prefService,
        isDarkMode: _themeMode == ThemeMode.dark,
        onThemeChanged: _changeTheme,
      ),
    );
  }
}
