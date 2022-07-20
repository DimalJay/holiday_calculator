import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:holyday_calculator/constraints/theme/dark_theme.dart';
import 'package:holyday_calculator/constraints/theme/light_theme.dart';
import 'package:holyday_calculator/pages/home/home.dart';
import 'package:holyday_calculator/pages/settings/setings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomeScreen(),
        "/settings": (context) => const SettingsPage(),
      },
    );
  }
}
