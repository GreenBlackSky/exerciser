import 'package:flutter/material.dart';

import 'package:exerciser/models/muscle.dart';
import 'package:exerciser/models/tag.dart';

import 'muscles.dart';

class Tags {
  static final _muscleTags = {
    Muscles.biceps: Tags.biceps,
    Muscles.pectoralisMajor: Tags.pectoralisMajor,
    Muscles.abdominals: Tags.abdominals,
    Muscles.satorius: Tags.satorius,
    Muscles.abductors: Tags.abductors,
    Muscles.seratosAnterior: Tags.seratosAnterior,
    Muscles.fingerFlexors: Tags.fingerFlexors,
    Muscles.quadrocips: Tags.quadrocips,
    Muscles.tibialisAnterior: Tags.tibialisAnterior,
    Muscles.soleus: Tags.soleus,
    Muscles.latissimusDorsi: Tags.latissimusDorsi,
    Muscles.infraspinatus: Tags.infraspinatus,
    Muscles.triceps: Tags.triceps,
    Muscles.fingerExtensors: Tags.fingerExtensors,
    Muscles.gluteusMaximus: Tags.gluteusMaximus,
    Muscles.hamstrings: Tags.hamstrings,
    Muscles.trapezoids: Tags.trapezoids,
    Muscles.deltoid: Tags.deltoid,
    Muscles.externalOblique: Tags.externalOblique,
    Muscles.brachioradialis: Tags.brachioradialis,
    Muscles.gastrocnemius: Tags.gastrocnemius,
  };

  static Tag getMuscleTag(Muscle muscle) {
    return _muscleTags[muscle]!;
  }

  static Tag strength = Tag("strength", Colors.red);
  static Tag flexability = Tag("flexability", Colors.green);
  static Tag warmup = Tag("warmup", Colors.orange);
  static Tag dance = Tag("dance", Colors.purple);
  static Tag fight = Tag("warmup", Colors.grey);

  static Tag biceps = Tag("biceps", Colors.red);
  static Tag pectoralisMajor = Tag("pectoralisMajor", Colors.red);
  static Tag abdominals = Tag("abdominals", Colors.red);
  static Tag satorius = Tag("satorius", Colors.red);
  static Tag abductors = Tag("abductors", Colors.red);
  static Tag seratosAnterior = Tag("seratosAnterior", Colors.red);
  static Tag fingerFlexors = Tag("fingerFlexors", Colors.red);
  static Tag quadrocips = Tag("quadrocips", Colors.red);
  static Tag tibialisAnterior = Tag("tibialisAnterior", Colors.red);
  static Tag soleus = Tag("soleus", Colors.red);
  static Tag latissimusDorsi = Tag("latissimusDorsi", Colors.red);
  static Tag infraspinatus = Tag("infraspinatus", Colors.red);
  static Tag triceps = Tag("triceps", Colors.red);
  static Tag fingerExtensors = Tag("fingerExtensors", Colors.red);
  static Tag gluteusMaximus = Tag("gluteusMaximus", Colors.red);
  static Tag hamstrings = Tag("hamstrings", Colors.red);
  static Tag trapezoids = Tag("trapezoids", Colors.red);
  static Tag deltoid = Tag("deltoid", Colors.red);
  static Tag externalOblique = Tag("externalOblique", Colors.red);
  static Tag brachioradialis = Tag("brachioradialis", Colors.red);
  static Tag gastrocnemius = Tag("gastrocnemius", Colors.red);
}
