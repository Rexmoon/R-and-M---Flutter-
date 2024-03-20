import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/Presentation/Screens/Home/home_screen_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeScreenProvider>();

    viewModel.loadData();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Rick And Morty'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: ListView.separated(
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: viewModel.characters.length,
            itemBuilder: ((context, index) {
              final character = viewModel.characters[index];
              final size = MediaQuery.of(context).size;
              return ListTile(
                title: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(36),
                      child: Image.network(
                        character.image,
                        width: size.width * 0.2,
                        height: size.height * 0.2,
                      ),
                    ),
                    Column(
                      children: [
                        Text('Index: ${character.name}'),
                        Text('Index: ${character.gender}'),
                        Text('Index: ${character.origin}'),
                        Text('Index: ${character.species}')
                      ],
                    ),
                  ],
                ),
                onTap: () => {},
              );
            })));
  }
}
