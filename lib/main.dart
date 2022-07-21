import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:holyday_calculator/constraints/theme/dark_theme.dart';
import 'package:holyday_calculator/constraints/theme/light_theme.dart';
import 'package:holyday_calculator/domain/providers/preference_provider.dart';
import 'package:holyday_calculator/pages/home/home.dart';
import 'package:holyday_calculator/pages/settings/setings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  final prefs = await SharedPreferences.getInstance();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<PreferencesProvider>(
      create: (context) => PreferencesProvider(prefs),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefProvider = Provider.of<PreferencesProvider>(context);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: prefProvider.darkMode ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/settings": (context) => const SettingsPage(),
      },
    );
  }
}
