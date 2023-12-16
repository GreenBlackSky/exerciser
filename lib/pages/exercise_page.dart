import 'package:exerciser/config/config.dart';
import 'package:exerciser/models/exercise.dart';
import 'package:flutter/material.dart';

import 'package:exerciser/widgets/exercise_widget.dart';

import 'search_page.dart';

class ExercisePage extends StatelessWidget {
  const ExercisePage({super.key, required this.currentExercise});
  final Exercise currentExercise;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(title),
        actions: const [SearchButton()],
      ),
      body: ExerciseWidget(currentExercise: currentExercise),
    );
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SearchPage(),
          ),
        );
      },
      icon: const Icon(Icons.search),
    );
  }
}
