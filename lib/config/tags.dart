import 'package:flutter/material.dart';

import 'package:exerciser/models/muscle.dart';
import 'package:exerciser/models/tag.dart';

class Tags {
  static final Map<Muscle, Tag> _muscleTags = {};
  static final Set<Tag> _exerciseTags = {};
  static final _categoryTags = {
    Tags.strength,
    Tags.flexability,
    Tags.warmup,
    Tags.dance,
    Tags.fight,
  };

  static Tag createMuscleTag(Muscle muscle) {
    var tag = Tag(muscle.name.toLowerCase(), Colors.red);
    _muscleTags[muscle] = tag;
    return tag;
  }

  static Tag getMuscleTag(Muscle muscle) {
    return _muscleTags[muscle]!;
  }

  static Set<Tag> getAllTags() {
    var ret = _categoryTags.toSet();
    ret.addAll(_muscleTags.values);
    ret.addAll(_exerciseTags);
    return ret;
  }

  static Tag createExerciseTag(String name, Color color) {
    var tag = Tag(name, color);
    _exerciseTags.add(tag);
    return tag;
  }

  // Categories
  static Tag strength = Tag("strength", Colors.red.shade300);
  static Tag flexability = Tag("flexability", Colors.green);
  static Tag warmup = Tag("warmup", Colors.lightGreen);
  static Tag dance = Tag("dance", Colors.purple);
  static Tag fight = Tag("fight", Colors.red.shade700);
}
