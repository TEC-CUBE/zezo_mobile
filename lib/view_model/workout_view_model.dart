// import 'package:http/http.dart' as http;
// import 'dart:convert';

// import '../model/group_workout_model.dart';

// Future<List<GroupWorkout>> fetchWorkoutData(followup) async {
//   print('objectkkkkkkkkkkkkkkkkkkkkkk');
//   print(followup);
//   final response = await http.get(Uri.parse(
//       'http://3.223.187.125:8022/api/v1/trainee/group?filters=followup_id:eq:$followup'));
//   if (response.statusCode == 200) {
//     final responseData = json.decode(response.body);
//     final data = responseData['data'];

//     final List<GroupWorkout> workouts = data
//         .map<GroupWorkout>((item) => GroupWorkout.fromJson(item))
//         .toList(); // Ensure the result is a List<Workout>

//     return workouts;
//   } else {
//     throw Exception('Failed to load workout data');
//   }
// }


