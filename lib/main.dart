import 'package:flutter/material.dart';
import 'pages/profile_page.dart';
import 'services/pref_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefService = await PrefService.init();
  await prefService.increaseOpenCount();

  runApp(MyApp(prefService: prefService));
}

class MyApp extends StatelessWidget {
  final PrefService prefService;

  const MyApp({super.key, required this.prefService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kartu Profil Digital',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProfilePage(prefService: prefService),
    );
  }
}
