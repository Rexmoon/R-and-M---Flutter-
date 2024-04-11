import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_favorites_repository.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Favorites/favorite_screen_provider.dart';

final class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoriteRepository = context.read<CharacterFavoriteRepository>();

    return ChangeNotifierProvider(
      create: (context) =>
          FavoriteScreenProvider(favoritesrepository: favoriteRepository),
      child: const _FavoriteScaffold(),
    );
  }
}

final class _FavoriteScaffold extends StatelessWidget {
  const _FavoriteScaffold();

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = context.watch<FavoriteScreenProvider>();

    favoriteProvider.loadData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: GridView.builder(
        // shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: favoriteProvider.favorites.length,
        itemBuilder: (context, index) {
          if (favoriteProvider.favorites.isEmpty) {
            return const Center(child: Text('No favorites yet'));
          } else {
            return CustomCard(favorite: favoriteProvider.favorites[index]);
          }
        },
      ),
    );
  }
}

final class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.favorite});

  final CharacterModel favorite;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        // transform: Matrix4.rotationX(),
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            const Icon(
              Icons.device_unknown,
              size: 150,
            ),
            const Spacer(),
            Text(
              favorite.name,
              style: const TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w900),
              overflow: TextOverflow.ellipsis,
            )
          ]),
        ),
      ),
    );
  }
}
