import 'dart:convert';
import 'workout.dart';

class User {
  final String name;
  final String email;
  final List<Workout> workouts;
  final DateTime lastLoginDate; //for dashboard
  final int totalCompletedWorkouts; //for dashboard

  User({
    required this.name,
    required this.email,
    this.workouts = const [],
    required this.lastLoginDate,
    this.totalCompletedWorkouts = 0,
  });

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        workouts = (json['workouts'] as List)
            .map((workout) => Workout.fromJson(workout as Map<String, dynamic>))
            .toList(),
        lastLoginDate = DateTime.parse(json['lastLoginDate']),
        totalCompletedWorkouts = json['totalCompletedWorkouts'];

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'workouts': workouts.map((workout) => workout.toJson()).toList(),
    'lastLoginDate': lastLoginDate.toIso8601String(),
    'totalCompletedWorkouts': totalCompletedWorkouts,
  };

  String toJsonString() => jsonEncode(toJson());

  Workout? get latestWorkout => workouts.isNotEmpty ? workouts.last : null;
}