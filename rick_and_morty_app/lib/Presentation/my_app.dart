import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_api_rest_repository.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_favorites_repository.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Favorites/favorite_screen.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/Home/home_screen.dart';
import 'package:rick_and_morty_app/Services/character_api_rest_services.dart';
import 'package:rick_and_morty_app/Services/character_favorites_services.dart';

final class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final characterAPIRestService = CharacterAPIRestServices();
    final characterFavoritesService = CharacterFavoritesServices();
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
        Provider(
            create: (context) => CharacterAPIRestRepository(
                apiRestService: characterAPIRestService)),
        Provider(
            create: (context) => CharacterFavoriteRepository(
                services: characterFavoritesService))
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
