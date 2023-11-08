import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:zezo/view/workout_details_view.dart';

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
      reps: json['reps'],
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

class GroupWorkoutView extends StatefulWidget {
  final int groupID;
  GroupWorkoutView(this.groupID);

  @override
  _GroupWorkoutViewState createState() => _GroupWorkoutViewState();
}

class _GroupWorkoutViewState extends State<GroupWorkoutView> {
  late List<Workout> workouts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWorkouts(widget.groupID);
  }

  Future<void> fetchWorkouts(int groupID) async {
    try {
      final url = Uri.parse(
          'http://3.223.187.125:8022/api/v1/trainee/followupworkout?filters=group_id:eq:$groupID');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        final parsedWorkouts =
            data.map((item) => Workout.fromJson(item)).toList();

        setState(() {
          workouts = parsedWorkouts;
          isLoading = false;
        });
      } else {
        print('Error response: ${response.statusCode}');
        throw Exception('Failed to load workouts');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load workouts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        title: Text('التمارين'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : workouts.isNotEmpty
              ? ListView.builder(
                  itemCount: workouts.length,
                  itemBuilder: (context, index) {
                    final workout = workouts[index];
                    return Column(
                      children: [
                        SizedBox(height: 15.h),
                        ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(workout.exercises.first.name,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(
                                            255, 255, 250, 250))),
                                SizedBox(height: 10.h),
                                Divider(
                                    color: Color.fromARGB(255, 30, 30, 43),
                                    height: 1.h,
                                    thickness: 1)
                              ],
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                size: 16,
                                color: Color.fromARGB(255, 6, 159, 182)),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      WorkoutDetailsPage(workout.id),
                                ),
                              );
                            }),
                      ],
                    );
                  },
                )
              : Center(
                  child: Text('لا يوجد تمارين لهذا اليوم',
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 250, 250)))),
    );
  }
}
