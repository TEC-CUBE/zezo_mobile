class WorkoutDetails {
  final int id;
  final int followupId;
  final int workoutId;
  final String day;
  final String number;
  final String quantity;
  final String createdAt;
  final String updatedAt;
  final String actionAuthor;
  final String status;
  final String reps;
  final List<Map<String, dynamic>> workouts;

  WorkoutDetails({
    required this.id,
    required this.followupId,
    required this.workoutId,
    required this.day,
    required this.number,
    required this.quantity,
    required this.createdAt,
    required this.updatedAt,
    required this.actionAuthor,
    required this.status,
    required this.reps,
    required this.workouts,
  });
}
