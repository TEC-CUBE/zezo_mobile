import 'dart:convert';
import 'package:CoachZiad/model/workout_details_model.dart';
import 'package:http/http.dart' as http;

class WorkoutDetailsApi {
  static Future<List<WorkoutDetailsModel>> fetchWorkoutDetails(
      int workoutId) async {
    final url = Uri.parse(
        "http://3.223.187.125:8022/api/v1/trainee/followupworkout/$workoutId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          return responseData
              .map((json) => WorkoutDetailsModel.fromJson(json))
              .toList();
        } else if (responseData is Map<String, dynamic>) {
          // If the response is a map, handle it accordingly
          final workoutDetailsModel =
              WorkoutDetailsModel.fromJson(responseData);
          return [workoutDetailsModel];
        } else {
          throw Exception("Invalid response format");
        }
      }

      // If responseData is null or not a list or object, throw an exception
      throw Exception(
          "Failed to load workout details. Check your network connection and try again.");
    } catch (e) {
      print("Error fetching workout details: $e");
      throw Exception(
          "Failed to load workout details. Check your network connection and try again.");
    }
  }
}
