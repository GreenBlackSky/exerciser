import 'package:exerciser/config/tags.dart';

class Muscle {
  String name;
  String picture;

  Muscle(this.name, String picture) : picture = "assets/images/$picture" {
    Tags.createMuscleTag(this);
  }
}
