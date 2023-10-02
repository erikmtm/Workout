import '../models/workout.dart';
import '../models/exercise.dart'; // Assuming you have a model for exercise
import '../Services/BoxManager.dart';

class WorkoutRepository {
  final BoxManager _boxManager = BoxManager();

  Future<void> startNewWorkout() async {
    Workout newWorkout = Workout();
    await saveWorkout(newWorkout);
  }

  Future<void> addExerciseToWorkout(Exercise exercise) async {
    Workout? currentWorkout = await getWorkout();
    if (currentWorkout != null) {
      currentWorkout.exercises.add(exercise);
      await saveWorkout(currentWorkout);
    }
  }

  Future<void> saveWorkout(Workout workout) async {
    _validateWorkout(workout);
    await _boxManager.workoutsBox.put('currentWorkout', workout.serialize());
  }

  Future<Workout?> getWorkout() async {
    var data = _boxManager.workoutsBox.get('currentWorkout');
    if (data != null) {
      return Workout.deserialize(data);
    }
    return null;
  }

  Future<void> deleteWorkout() async {
    await _boxManager.workoutsBox.delete('currentWorkout');
  }
  void _validateWorkout(Workout workout) {
    if (workout.exercises.isEmpty) {
      throw ArgumentError('A workout should have at least one exercise.');
    }
    // the above is an example, you can of course add more validations
  }
}
