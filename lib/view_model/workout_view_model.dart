// workout_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/workout_model.dart';

class WorkoutAPI {
  static Future<List<Workout>> fetchWorkouts(int groupID) async {
    try {
      final url = Uri.parse(
          'http://3.223.187.125:8022/api/v1/trainee/followupworkout?filters=group_id:eq:$groupID');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final parsedWorkouts =
            data.map((item) => Workout.fromJson(item)).toList();
        return parsedWorkouts;
      } else {
        throw Exception('Failed to load workouts');
      }
    } catch (e) {
      throw Exception('Failed to load workouts');
    }
  }
}
