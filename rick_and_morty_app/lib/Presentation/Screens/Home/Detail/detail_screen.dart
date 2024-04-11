import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_api_rest_repository.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_favorites_repository.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/Detail/detail_screen_provider.dart';

final class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final apiRestRepository = context.read<CharacterAPIRestRepository>();
    final favoritesRepository = context.read<CharacterFavoriteRepository>();

    return ChangeNotifierProvider(
        create: (context) => DetailScreenProvider(
            characterAPIRestRepository: apiRestRepository,
            characterFavoriteRepository: favoritesRepository),
        child: _DetailScreenScaffold(id: id));
  }
}

final class _DetailScreenScaffold extends StatelessWidget {
  const _DetailScreenScaffold({required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final detailProvider = context.watch<DetailScreenProvider>();

    if (detailProvider.character == null) detailProvider.loadData(id: id);

    return Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          leading: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                    colors: [Colors.blue, Colors.green],
                    begin: Alignment.center,
                    end: Alignment.bottomRight)),
            child: IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  detailProvider.saveAsFavorite();
                },
                icon: Icon(detailProvider.isFavorite
                    ? Icons.favorite
                    : Icons.favorite_border))
          ],
          title: const Text('Detail Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: detailProvider.character != null
              ? Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: detailProvider.character!.status.color,
                            width: 10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          fit: BoxFit.fill,
                          height: screenSize.height * 0.5,
                          detailProvider.character!.image),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          detailProvider.character!.name,
                          maxLines: 1,
                          style: const TextStyle(
                              fontFamily: 'Times New Roman', fontSize: 32),
                        ),
                        Text(detailProvider.character!.origin.name)
                      ],
                    ),
                  )
                ])
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ));
  }
}
