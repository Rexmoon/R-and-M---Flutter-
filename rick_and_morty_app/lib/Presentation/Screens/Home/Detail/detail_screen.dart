import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/Domain/Models/character.dart';

final class DetailScreen extends StatelessWidget {
  final Character character;

  const DetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

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
          child: Column(children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: character.status.color, width: 10)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                    fit: BoxFit.fill,
                    height: screenSize.height * 0.5,
                    character.image),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    character.name,
                    maxLines: 1,
                    style: const TextStyle(
                        fontFamily: 'Times New Roman', fontSize: 32),
                  ),
                  Text(character.origin.name)
                ],
              ),
            )
          ]),
        ));
  }
}
