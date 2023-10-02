import 'dart:convert';

import '../utilities/TrainingSessionState.dart';
import 'exercise.dart';

class Workout {
  TrainingSessionState state;
  List<Exercise> exercises;

  Workout()
      : state = TrainingSessionState.notStarted,
        exercises = [];

  void startTrainingSession() {
    state = TrainingSessionState.started;
  }

  void resumeTrainingSession() {
    if (state == TrainingSessionState.paused) {
      state = TrainingSessionState.resumed;
    }
  }

  void pauseTrainingSession() {
    if (state == TrainingSessionState.started || state == TrainingSessionState.resumed) {
      state = TrainingSessionState.paused;
    }
  }

  void addExercise(Exercise exercise) {
    exercises.add(exercise);
  }

  void finishTrainingSession() {
    state = TrainingSessionState.finished;
  }

  Map<String, dynamic> toJson() {
    return {
      'state': state.index,
      'exercises': exercises.map((exercise) => exercise.toJson()).toList()
    };
  }

  static Workout fromJson(Map<String, dynamic> json) {
    return Workout()
      ..state = TrainingSessionState.values[json['state']]
      ..exercises = (json['exercises'] as List)
          .map((item) => Exercise.fromJson(item))
          .toList();
  }
  String serialize() {
    return jsonEncode(this.toJson());
  }

  static Workout deserialize(String jsonString) {
    return Workout.fromJson(jsonDecode(jsonString) as Map<String, dynamic>);
  }

}