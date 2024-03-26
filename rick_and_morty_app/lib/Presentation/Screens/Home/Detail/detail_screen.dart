import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/rick_and_morty_repository.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/Detail/detail_screen_provider.dart';

final class DetailScreen extends StatelessWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<CharacterAPIRestRepository>();

    return ChangeNotifierProvider(
        create: (context) =>
            DetailScreenProvider(characterAPIRestRepository: repository),
        child: _DetailScreenScaffold(
          id: id,
        ));
  }
}

final class _DetailScreenScaffold extends StatelessWidget {
  final int id;

  const _DetailScreenScaffold({required this.id});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final provider = context.watch<DetailScreenProvider>();

    provider.loadData(id: id);

    return Scaffold(
        appBar: AppBar(
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
          title: const Text('Detail Screen'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: provider.character != null
              ? Column(children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: provider.character!.status.color,
                            width: 10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                          fit: BoxFit.fill,
                          height: screenSize.height * 0.5,
                          provider.character!.image),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          provider.character!.name,
                          maxLines: 1,
                          style: const TextStyle(
                              fontFamily: 'Times New Roman', fontSize: 32),
                        ),
                        Text(provider.character!.origin.name)
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
