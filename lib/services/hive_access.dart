import 'package:hive_flutter/hive_flutter.dart';

class HiveAccess{
  int? getMaxRepeats(String exerciseName) {
    return Hive.box("exercises").get(exerciseName);
  }

  void recordRepeats(String exerciseName, int repeats) {
    Hive.box("exercises").put(exerciseName, repeats);
  }
}

var access = HiveAccess();