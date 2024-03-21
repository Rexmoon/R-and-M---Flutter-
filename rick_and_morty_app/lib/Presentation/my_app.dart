import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Favorites/favorite_screen.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/home_screen.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/home_screen_provider.dart';

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          // backgroundColor: Colors.blue
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MultiProvider(providers: [
        ChangeNotifierProvider(create: (context) => HomeScreenProvider()),
      ], child: _HomeTabBarScreen()),
    );
  }
}

final class _HomeTabBarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: [
          _tabButtonItem(icon: Icons.home),
          _tabButtonItem(icon: Icons.star)
        ]),
        tabBuilder: (tabContext, tabIndex) {
          switch (tabIndex) {
            case 0:
              return CupertinoTabView(
                builder: (context) => const HomeScreen(),
              );
            default:
              return CupertinoTabView(
                builder: (context) => const Center(
                  child: FavoriteScreen(),
                ),
              );
          }
        });
  }

  BottomNavigationBarItem _tabButtonItem({required IconData icon}) {
    return BottomNavigationBarItem(
        icon: Icon(
          icon,
          color: Colors.white,
        ),
        activeIcon: Icon(
          icon,
          color: Colors.blue,
        ));
  }
}
