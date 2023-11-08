
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/workout_details_model.dart';


class WorkoutApi {
  static Future<WorkoutDetails> fetchWorkoutDetails(int workoutId) async {
    final url = Uri.parse("http://3.223.187.125:8022/api/v1/trainee/followupworkout/$workoutId");

    final response = await http.get(url);

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      return WorkoutDetails(
        id: responseData['id'],
        followupId: responseData['followup_id'],
        workoutId: responseData['workout_id'],
        day: responseData['day'],
        number: responseData['number'],
        quantity: responseData['quantity'],
        createdAt: responseData['created_at'],
        updatedAt: responseData['updated_at'],
        actionAuthor: responseData['action_author'],
        status: responseData['status'],
        reps: responseData['reps'],
        workouts: List<Map<String, dynamic>>.from(responseData['workouts']),
      );
    } else {
      throw Exception("Failed to load workout details");
    }
  }
}
