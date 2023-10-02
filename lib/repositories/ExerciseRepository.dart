import '../models/exercise.dart';
import '../Services/BoxManager.dart';

class ExerciseRepository {

  final BoxManager _boxManager = BoxManager();

  Future<List<Exercise>> getAllExercises() async {
    return _boxManager.exercisesBox.values.map((jsonString) => Exercise.deserialize(jsonString)).toList();
  }

  Future<Exercise?> getExerciseById(String id) async {
    final jsonString = _boxManager.exercisesBox.get(id);
    if (jsonString != null) {
      return Exercise.deserialize(jsonString);
    }
    return null;
  }

  Future<void> addExercise(Exercise exercise) async {
    _validateExercise(exercise);
    await _boxManager.exercisesBox.put(exercise.id, exercise.serialize());
  }

  Future<void> deleteExercise(String id) async {
    await _boxManager.exercisesBox.delete(id);
  }

  Future<void> updateExercise(Exercise updatedExercise) async {
    await _boxManager.exercisesBox.put(updatedExercise.id, updatedExercise.serialize());
  }

  void _validateExercise(Exercise exercise) {
    if (exercise.repetitions != null && exercise.repetitions! < 0) {
      throw ArgumentError('Repetitions cannot be null or negative');
    }
    // the above is an example, you can of course add more validations
  }
}