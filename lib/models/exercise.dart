import 'package:flutter/material.dart';

import 'package:exerciser/config/tags.dart';
import 'package:exerciser/services/hive_access.dart';
import 'tag.dart';
import 'muscle.dart';

class Exercise {
  String name;
  Map<Muscle, double> affectedMuscles;
  Set<Tag> tags;

  Exercise(this.name, this.affectedMuscles, Set<Tag> tags)
      : tags = tags.toSet() {
    for (Muscle muscle in affectedMuscles.keys) {
      this.tags.add(Tags.getMuscleTag(muscle));
    }
    this.tags.add(Tags.createExerciseTag(name.toLowerCase(), Colors.yellow));
  }

  Widget getImage() {
    var images = <Widget>[];
    images.add(Image.asset("assets/images/both.png"));

    for (var entry in affectedMuscles.entries) {
      var muscleGroup = entry.key;
      var opacity = entry.value;
      images.add(
          Opacity(opacity: opacity, child: Image.asset(muscleGroup.picture)));
    }
    return Stack(children: images);
  }

  int? getMaxRepeats() {
    return access.getMaxRepeats(name);
  }

  void recordRepeats(int repeats) {
    access.recordRepeats(name, repeats);
  }
}
