import 'package:flutter/material.dart';

import 'package:exerciser/services/hive_access.dart';
import 'package:exerciser/models/muscle_group.dart';

class Exercise {
  String name;
  Map<MuscleGroup, double> affectedMuscles;

  Exercise(this.name, this.affectedMuscles);

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
