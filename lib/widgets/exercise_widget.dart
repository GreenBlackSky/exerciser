// import 'package:exerciser/services/notification_service.dart';
import 'package:flutter/material.dart';

import 'package:exerciser/models/tag.dart';
// import 'package:exerciser/config/exercises.dart';
import 'package:exerciser/models/exercise.dart';

class ExerciseWidget extends StatefulWidget {
  const ExerciseWidget({
    super.key, required this.currentExercise,
  });

  final Exercise currentExercise;

  @override
  State<ExerciseWidget> createState() => _ExerciseWidgetState();
}

class _ExerciseWidgetState extends State<ExerciseWidget> {
  final TextEditingController _repeatsController = TextEditingController();

  bool _isANumber = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            widget.currentExercise.name,
            style: const TextStyle(fontSize: 40),
          ),
          Expanded(child: widget.currentExercise.getImage()),
          repeatsText(),
          getTagsWidget(),
          getBottomBar()
        ],
      ),
    );
  }

  Text repeatsText() {
    int? maxRepeats = widget.currentExercise.getMaxRepeats();
    return Text(
      maxRepeats != null
          ? "${(maxRepeats * 0.6).round()}/$maxRepeats"
          : "Test first",
      style: const TextStyle(fontSize: 40),
    );
  }

  Widget getTagsWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(
        runSpacing: 2.0,
        children: widget.currentExercise.tags.map(getTagWidget).toList(),
      ),
    );
  }

  Widget getTagWidget(Tag tag) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        color: tag.color,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: InkWell(
        child:
            Text('#${tag.name}', style: const TextStyle(color: Colors.white)),
        onTap: () {},
      ),
    );
  }

  Widget getBottomBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // nextExerciseButton(),
          getRepsInputField(),
          doneButton(),
        ],
      ),
    );
  }

  // TextButton nextExerciseButton() {
  //   return TextButton(
  //     onPressed: () {
  //       setState(() {
  //         _currentExercise = Exercises.getRandomExercise();
  //         _repeatsController.clear();
  //       });
  //     },
  //     child: const Icon(Icons.update),
  //   );
  // }

  SizedBox getRepsInputField() {
    return SizedBox(
      width: 100,
      height: 80,
      child: TextField(
        controller: _repeatsController,
        keyboardType: TextInputType.number,
        maxLength: 3,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          errorText: _isANumber ? null : "Enter a number",
        ),
      ),
    );
  }

  TextButton doneButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          var inputValue = _repeatsController.text;
          validate(inputValue);
          if (_isANumber) {
            widget.currentExercise.recordRepeats(int.parse(inputValue));
          }
        });
      },
      child: const Icon(Icons.done),
    );
  }

  void validate(String input) {
    if (input.isEmpty || !RegExp("[0-9]+").hasMatch(input)) {
      setState(() {
        _isANumber = false;
      });
    } else {
      setState(() {
        _isANumber = true;
      });
    }
  }
}