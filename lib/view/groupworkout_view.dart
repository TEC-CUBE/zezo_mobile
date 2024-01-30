// group_workout_view.dart
import 'package:CoachZiad/view_model/user_view_model.dart';
import 'package:CoachZiad/view_model/workout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../model/workout_model.dart';
import 'workout_details_view.dart';

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
    _fetchWorkouts();
  }

  Future<void> _fetchWorkouts() async {
     final userPreference = Provider.of<UserViewModel>(context, listen: false);
    final token = await userPreference.getToken(); // Get token from shared preferences
    try {
      final parsedWorkouts = await WorkoutAPI.fetchWorkouts(widget.groupID, token);
      setState(() {
        workouts = parsedWorkouts.cast<Workout>();
        isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        title: Text('التمارين',
            style: TextStyle(color: Color.fromARGB(255, 255, 250, 250))),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 255, 250, 250)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
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
                              Text(
                                  workout.exercises.isNotEmpty
                                      ? workout.exercises[0].name
                                      : 'No Exercise Name',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color:
                                          Color.fromARGB(255, 255, 250, 250))),
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
                          },
                        ),
                      ],
                    );
                  },
                )
              : Center(
                  child: Text('لا يوجد تمارين لهذا اليوم',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 255, 250, 250)))),
    );
  }
}
