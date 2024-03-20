import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/home_screen_provider.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/home_screen.dart';

void main() {
  runApp(const MyApp());
}

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(brightness: Brightness.dark),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
        // ChangeNotifierProvider(create: (context) => HomeViewModel()),
        // ChangeNotifierProvider(create: (context) => HomeViewModel()),
        // ChangeNotifierProvider(create: (context) => HomeViewModel()),
      ], child: const HomeScreen()),
    );
  }
}
