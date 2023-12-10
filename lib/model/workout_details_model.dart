class WorkoutDetailsModel {
  final int id;
  final int groupId;
  final int workoutId;
  final String number;
  final String quantity;
  final String actionAuthor;
  final bool status;
  final String time;
  final String rep;
  final String createdAt;
  final String updatedAt;
  final List<Workout> workouts;

  WorkoutDetailsModel({
    required this.id,
    required this.groupId,
    required this.workoutId,
    required this.number,
    required this.quantity,
    required this.actionAuthor,
    required this.status,
    required this.time,
    required this.rep,
    required this.createdAt,
    required this.updatedAt,
    required this.workouts,
  });

  factory WorkoutDetailsModel.fromJson(Map<String, dynamic> json) {
    return WorkoutDetailsModel(
      id: json['id'],
      groupId: json['group_id'],
      workoutId: json['workout_id'],
      number: json['number'],
      quantity: json['quantity'],
      actionAuthor: json['action_author'],
      status: json['status'].toString().toLowerCase() == 'true',
      time: json['time'],
      rep: json['rep'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      workouts: List<Workout>.from(
        json['workouts'].map((workout) => Workout.fromJson(workout)),
      ),
    );
  }
}

class Workout {
  final int id;
  final String name;
  final String image;

  Workout({
    required this.id,
    required this.name,
    required this.image,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}
