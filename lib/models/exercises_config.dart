import 'exercise.dart';
import 'muscle_group.dart';

var exercises = {
  0: Exercise(
    "Push-ups",
    {
      MuscleGroup.pectoralisMajor: 0.5,
      MuscleGroup.triceps: 0.7,
    },
  ),
  1: Exercise("Squats", {MuscleGroup.gluteusMaximus: 1}),
};