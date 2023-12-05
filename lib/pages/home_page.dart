import 'package:flutter/material.dart';

import 'package:exerciser/widgets/exercise_widget.dart';


class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: const ExerciseWidget(),
    );
  }
}