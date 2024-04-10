import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';
import 'package:rick_and_morty_app/Domain/Repositories/character_api_rest_repository.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/Detail/detail_screen.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/Home/home_screen_provider.dart';

final class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final characterRepository = context.read<CharacterAPIRestRepository>();

    return ChangeNotifierProvider(
        create: (context) =>
            HomeScreenProvider(repository: characterRepository),
        child: const _HomeScreenScaffold());
  }
}

final class _HomeScreenScaffold extends StatelessWidget {
  const _HomeScreenScaffold();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<HomeScreenProvider>();

    if (provider.characters.isEmpty) {
      provider.loadData();
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text('Rick And Morty'),
        ),
        body: provider.characters.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : NotificationListener<ScrollEndNotification>(
                onNotification: (notification) {
                  if (notification.metrics.extentAfter == 0 &&
                      provider.canLoadMore()) {
                    provider.loadData(enablePagination: true);
                  }
                  return true;
                },
                child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: provider.characters.length,
                    itemBuilder: ((context, index) {
                      if (index < provider.characters.length - 1) {
                        return _ListTile(character: provider.characters[index]);
                      } else if (provider.canLoadMore()) {
                        return const Center(child: CircularProgressIndicator());
                      } else {
                        return const Text('');
                      }
                    })),
              ));
  }
}

final class _ListTile extends StatelessWidget {
  final CharacterModel character;

  const _ListTile({required this.character});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      subtitleTextStyle: TextStyle(color: character.status.color),
      subtitle: Text(character.status.name),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.network(
          character.image,
        ),
      ),
      title: Text(character.name),
      onTap: () => {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailScreen(
                  id: character.id,
                )))
      },
    );
  }
}
