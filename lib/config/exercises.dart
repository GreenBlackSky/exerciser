import 'dart:math';

import 'package:exerciser/models/exercise.dart';
import 'package:exerciser/config/muscles.dart';
import 'package:exerciser/config/tags.dart';
import 'package:exerciser/models/tag.dart';

class Exercises {
  static final _allExercises = [
    pushUps,
    squats,
  ];

  static Exercise getRandomExercise() {
    int exerciseID = Random().nextInt(_allExercises.length);
    return _allExercises[exerciseID];
  }

  static Iterable<Exercise> getByTags(Iterable<Tag> tags) {
    return _allExercises.where((exercise) => exercise.tags.containsAll(tags));
  }

  static var pushUps = Exercise(
    "Push-ups",
    {
      Muscles.pectoralisMajor: 0.5,
      Muscles.triceps: 0.7,
    },
    {Tags.strength, Tags.fight, Tags.dance},
  );
  static var squats = Exercise(
    "Squats",
    {
      Muscles.gluteusMaximus: 1,
    },
    {
      Tags.strength,
    },
  );
}
