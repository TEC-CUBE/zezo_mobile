import 'package:CoachZiad/view_model/user_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:CoachZiad/view/groupworkout_view.dart';
import 'package:CoachZiad/view/workout_details_view.dart';
import 'package:provider/provider.dart';

import '../model/groub_meals_model.dart';
import '../model/group_workout_model.dart';
import '../view_model/groupmeals_view_model.dart';
import '../view_model/groupworkout_view_model.dart';
import 'groupmealdetails_view.dart';

class FollowupMealWorkoutView extends StatefulWidget {
  final followup; // This should contain the data for the selected followup

  FollowupMealWorkoutView(this.followup);
  @override
  _FollowupMealWorkoutViewState createState() =>
      _FollowupMealWorkoutViewState();
}

class _FollowupMealWorkoutViewState extends State<FollowupMealWorkoutView>
    with SingleTickerProviderStateMixin {
  List<GroupWorkout> detailsData = [];
  List<GroupMeals> mealGroups = [];
  // List<Workout> workouts = [];
  int _currentIndex = 0;
  late TabController _tabController;
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    fetchworkoutgroup();
    fetchmealgroup();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchworkoutgroup() async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    final token = await userPreference.getToken(); // Get token from shared preferences
    try {
      final workoutData = await fetchgroubWorkoutData(widget.followup, token: token,);
      setState(() {
        detailsData = workoutData;
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching workout data: $e");
    }
  }

  void fetchmealgroup() async {
     final userPreference = Provider.of<UserViewModel>(context, listen: false);
    final token = await userPreference.getToken(); // Get token from shared preferences
    final mealGroupsPage = MealGroups(widget.followup);
    final groups = await mealGroupsPage.fetchMealGroups(token: token,);

    setState(() {
      mealGroups = groups;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('الوجبات والتمارين',
              style: TextStyle(color: Color.fromARGB(255, 255, 250, 250))),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,
                color: Color.fromARGB(255, 255, 250, 250)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          bottom: TabBar(
            controller: _tabController, // Use the TabController here
            indicatorColor: const Color.fromARGB(255, 6, 159, 182),
            labelStyle: TextStyle(
                fontSize: 15.sp,
                color: const Color.fromARGB(255, 255, 250, 250)),
            unselectedLabelColor: const Color.fromARGB(255, 255, 250, 250),
            dividerColor: Colors.transparent,
            tabs: <Widget>[
              const Tab(
                text: 'الوجبات',
              ),
              const Tab(text: 'التمارين'),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                controller: _tabController, // Use the TabController here
                children: <Widget>[
                  mealGroups.isEmpty
                      ? Center(
                          child: Text("لم نقم بإضافة أي وجبة بعد",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp)),
                        )
                      : ListView.builder(
                          itemCount: mealGroups.length,
                          itemBuilder: (context, index) {
                            final mealGroup = mealGroups[index];

                            return GestureDetector(
                              onTap: () {
                                //Navigate to MealDetailsPage and pass relevant data
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => GroupMealDetails(
                                      followupId: widget.followup,
                                      day: mealGroup.day,
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text("يوم ${mealGroup.day}",
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: const Color.fromARGB(
                                            255, 255, 250, 250))),
                              ),
                            );
                          },
                        ),
                  detailsData.isEmpty
                      ? Center(
                          child: Text("لم نقم بإضافة أي  تمرين بعد",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 20.sp)),
                        )
                      : ListView.builder(
                          itemCount: detailsData.length,
                          itemBuilder: (context, index) {
                            final groupworkout = detailsData[index];
                            return ListTile(
                              title: Text(groupworkout.day.toString(),
                                  style: TextStyle(
                                      fontSize: 20.sp,
                                      color: const Color.fromARGB(
                                          255, 255, 250, 250))),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(groupworkout.action,
                                      style: TextStyle(
                                          fontSize: 14.sp,
                                          color: const Color.fromARGB(
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
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => GroupWorkoutView(
                                      groupworkout.id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ],
              ),
      ),
    );
  }
}
