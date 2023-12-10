// workout_model.dart
class Workout {
  final int id;
  final int groupId;
  final int workoutId;
  final String number;
  final String quantity;
  final String actionAuthor;
  final bool status;
  final String reps;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String time;
  final List<Exercise> exercises;

  Workout({
    required this.id,
    required this.groupId,
    required this.workoutId,
    required this.number,
    required this.quantity,
    required this.actionAuthor,
    required this.status,
    required this.reps,
    required this.createdAt,
    required this.updatedAt,
    required this.time,
    required this.exercises,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      groupId: json['group_id'],
      workoutId: json['workout_id'],
      number: json['number'],
      quantity: json['quantity'],
      actionAuthor: json['action_author'],
      status: json['status'] == 'true',
      reps: json['rep'], // Corrected field name
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      time: json['time'],
      exercises: List<Exercise>.from(
        (json['workouts'] as List<dynamic>).map(
          (exerciseJson) => Exercise.fromJson(exerciseJson),
        ),
      ),
    );
  }
}

class Exercise {
  final int id;
  final String name;

  Exercise({required this.id, required this.name});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(id: json['id'], name: json['name']);
  }
}
