import 'package:flutter/material.dart';

final class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: GridView.count(crossAxisCount: 2, children: const [
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
        CustomCard(),
      ]),
    );
  }
}

final class CustomCard extends StatelessWidget {
  const CustomCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.blue,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Image.network(
                width: 100,
                'https://pub.dev/packages/flutter_bloc/versions/8.1.4/gen-res/gen/190x190/logo.webp'),
            const Spacer(),
            const Text(
              'Name',
              style: TextStyle(
                  fontStyle: FontStyle.italic, fontWeight: FontWeight.w900),
            )
          ]),
        ),
      ),
    );
  }
}
