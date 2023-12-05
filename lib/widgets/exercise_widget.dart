import 'dart:math';

import 'package:exerciser/models/exercise.dart';
import 'package:exerciser/services/notification_service.dart';
import 'package:flutter/material.dart';

import 'package:exerciser/models/exercises_config.dart';

class ExerciseWidget extends StatefulWidget {
  const ExerciseWidget({
    super.key,
  });

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  final TextEditingController _repeatsController = TextEditingController();

  int _exerciseID = Random().nextInt(exercises.length);
  bool isANumber = true;

  @override
  Widget build(BuildContext context) {
    var exercise = exercises[_exerciseID]!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            exercise.name,
            style: const TextStyle(fontSize: 40),
          ),
          Expanded(child: exercise.getImage()),
          retpeatsText(exercise),
          OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            alignment: MainAxisAlignment.spaceAround,
            spacing: 8,
            children: [
              RecordInputField(
                  repeatsController: _repeatsController, isANumber: isANumber),
              doneButton(exercise),
              nextExerciseButton()
            ],
          )
        ],
      ),
    );
  }

  Text retpeatsText(Exercise exercise) {
    int? maxRepeats = exercise.getMaxRepeats();
    return Text(
      maxRepeats != null
          ? "${(maxRepeats * 0.6).round()}/$maxRepeats"
          : "Test first",
      style: const TextStyle(fontSize: 40),
    );
  }

  TextButton nextExerciseButton() {
    return TextButton(
      onPressed: () {
        NotificationService().displayText("Skippin ehh?");
        setState(() {
          _exerciseID = Random().nextInt(exercises.length);
          _repeatsController.clear();
        });
      },
      child: const Icon(Icons.update),
    );
  }

  TextButton doneButton(Exercise exercise) {
    return TextButton(
      onPressed: () {
        setState(() {
          var inputValue = _repeatsController.text;
          validate(inputValue);
          if (isANumber) {
            exercise.recordRepeats(int.parse(inputValue));
          }
        });
      },
      child: const Icon(Icons.done),
    );
  }

  void validate(String input) {
    if (input.isEmpty || !RegExp("[0-9]+").hasMatch(input)) {
      setState(() {
        isANumber = false;
      });
    } else {
      setState(() {
        isANumber = true;
      });
    }
  }
}

class RecordInputField extends StatelessWidget {
  const RecordInputField({
    super.key,
    required TextEditingController repeatsController,
    required this.isANumber,
  }) : _repeatsController = repeatsController;

  final TextEditingController _repeatsController;
  final bool isANumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: 80,
      child: TextField(
        controller: _repeatsController,
        keyboardType: TextInputType.number,
        maxLength: 3,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorText: isANumber ? null : "Enter a number",
        ),
      ),
    );
  }
}
