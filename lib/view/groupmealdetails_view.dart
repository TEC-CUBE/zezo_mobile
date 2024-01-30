import 'package:CoachZiad/view_model/groupmealsdetails_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:CoachZiad/view/workout_details_view.dart';
import 'package:provider/provider.dart';
import '../model/groupmealdetails_model.dart';
import '../view_model/groupmeals_view_model.dart';
import '../view_model/groupworkout_view_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../view_model/user_view_model.dart';

class GroupMealDetails extends StatefulWidget {
  final int followupId;
  final String day;

  GroupMealDetails({required this.followupId, required this.day});

  @override
  _GroupMealDetailsState createState() => _GroupMealDetailsState();
}

class _GroupMealDetailsState extends State<GroupMealDetails> {
  List<MealDetail> mealDetails = []; // Create a list to store meal details
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    //fetchData();
    fetchmealdetailsgroup();
  }

  void fetchmealdetailsgroup() async {
    final detailsMealsGroub = MealDeatailsGroups(widget.followupId, widget.day);
     final userPreference = Provider.of<UserViewModel>(context, listen: false);
    final token = await userPreference.getToken(); // Get token from shared preferences
    final deatails = await detailsMealsGroub.fetchGroupsMealDeatails(token: token);
    setState(() {
      mealDetails = deatails;
      isLoading = false;
    });
  }

  void _showMealDetails(MealDetail meal) {
    List<String> imageUrls = meal.meals.map((mealItem) {
      return mealItem.image;
    }).toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height: 500.h,
          color: const Color.fromARGB(255, 15, 15, 24),
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300.w,
                  height: 200.h,
                  color: Colors.transparent,
                  child: ListView(
                    physics:
                        NeverScrollableScrollPhysics(), // Prevent scrolling
                    children: imageUrls.map((imageUrl) {
                      return imageUrl.isNotEmpty
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/meal.png',
                              fit: BoxFit.cover,
                            );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 16.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: meal.meals.map((mealItem) {
                    return Text(mealItem.name,
                        style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white));
                  }).toList(),
                ),
                // Rest of your code for displaying meal details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: meal.meals.map((mealItem) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 6, 159, 182)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                                "الكمية:  ${mealItem.weight.toString() ?? 'N/A'}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: meal.meals.map((mealItem) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 6, 159, 182)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                                "الدهون:  ${mealItem.fat.toString() ?? 'N/A'}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
                SizedBox(height: 14.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: meal.meals.map((mealItem) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 6, 159, 182)),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(
                            "السعرات الحرارية:  ${mealItem.calories.toString() ?? 'N/A'}",
                            style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: meal.meals.map((mealItem) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 6, 159, 182)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                                "الكربوهيدرات:  ${mealItem.carb.toString() ?? 'N/A'}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        );
                      }).toList(),
                    ),
                    Row(
                      children: meal.meals.map((mealItem) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                                width: 1,
                                color: const Color.fromARGB(255, 6, 159, 182)),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                                "البروتين:  ${mealItem.protein.toString() ?? 'N/A'}",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        title: Text("الوجبات",
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
      body: mealDetails.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: mealDetails.length,
              itemBuilder: (context, index) {
                final mealDetail = mealDetails[index];
                List<String> imageUrls = mealDetail.meals.map((mealItem) {
                  return mealItem.image;
                }).toList();

                return GestureDetector(
                  onTap: () {
                    _showMealDetails(mealDetail);
                  },
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: 50.h,
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: mealDetail.meals.map((mealItem) {
                          return Text(
                            mealItem.name,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          );
                        }).toList(),
                      ),
                      subtitle: Divider(
                          color: Color.fromARGB(255, 30, 30, 43),
                          height: 1.h,
                          thickness: 1),
                     
                      leading: Container(
                        width: 100.w,
                        height: 100.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            final imageUrl = imageUrls[index];
                            return Container(
                                child: imageUrl.isNotEmpty
                                    ? Image.network(
                                        imageUrl,
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.asset(
                                        'assets/images/meal.png',
                                        width: 100.0,
                                        height: 100.0,
                                        fit: BoxFit.cover,
                                      ));
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
