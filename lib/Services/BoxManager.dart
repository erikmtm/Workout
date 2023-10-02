import 'dart:io';

import 'package:hive/hive.dart';

class BoxManager {
  static const String exercisesBoxName = 'workoutsBox';
  static const String workoutsBoxName = 'workoutsBox';
  static const String userBoxName = 'userBox';

  static final BoxManager _instance = BoxManager._internal();

  late final Box<String> exercisesBox;
  late final Box<String> workoutsBox;
  late final Box<String> userBox;

  factory BoxManager() {
    return _instance;
  }

  BoxManager._internal() {
    Directory directory = Directory.current;
    Hive.init(directory.path);

    _openBox(exercisesBoxName).then((box) => exercisesBox = box);
    _openBox(workoutsBoxName).then((box) => workoutsBox = box);
    _openBox(userBoxName).then((box) => userBox = box);
  }

  Future<Box<String>> _openBox(String boxName) async {
    return await Hive.openBox<String>(boxName);
  }
}