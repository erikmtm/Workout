import 'dart:convert';

class Exercise {
  final String id;
  final String type;
  final Duration duration;
  final int? sets;
  final int? repetitions;
  final String description;
  final String? weight;

  Exercise({
    required this.id,
    required this.type,
    required this.duration,
    this.sets,
    this.repetitions,
    required this.description,
    this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'duration': duration.inSeconds,
      'sets': sets,
      'repetitions': repetitions,
      'description': description,
      'weight': weight,
    };
  }

  static Exercise fromJson(Map<String, dynamic> jsonData) {
    return Exercise(
      id: jsonData['id'],
      type: jsonData['type'],
      duration: Duration(seconds: jsonData['duration']),
      sets: jsonData['sets'],
      repetitions: jsonData['repetitions'],
      description: jsonData['description'],
      weight: jsonData['weight'],
    );
  }

  String serialize() {
    return jsonEncode(this.toJson());
  }

  static Exercise deserialize(String jsonString) {
    return Exercise.fromJson(jsonDecode(jsonString));
  }
}