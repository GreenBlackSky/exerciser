import 'package:flutter/material.dart';

import 'package:exerciser/widgets/exercise_widget.dart';

import 'search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
        actions: [SearchButton(title: title)],
      ),
      body: const ExerciseWidget(),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SearchPage(title: title),
          ),
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}
