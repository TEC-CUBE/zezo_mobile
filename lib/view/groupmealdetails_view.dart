import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zezo/view/workout_details_view.dart';
import '../model/groupmealdetails_model.dart';
import '../view_model/groupmeals_view_model.dart';
import '../view_model/groupworkout_view_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GroupMealDetails extends StatefulWidget {
  final int followupId;
  final String day;

  GroupMealDetails({required this.followupId, required this.day});

  @override
  _GroupMealDetailsState createState() => _GroupMealDetailsState();
}

class _GroupMealDetailsState extends State<GroupMealDetails> {
  List<MealDetail> mealDetails = []; // Create a list to store meal details

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final url = Uri.parse(
        "http://3.223.187.125:8022/api/v1/trainee/followupmeals?filters=followup_id:eq:${widget.followupId},day:eq:${widget.day}");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        print(
            ' iiiiiiiiiiiiiiiiiifffffffffffffffffnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');
        print(widget.followupId);
        print(widget.day);
        final responseData = json.decode(response.body);

        if (responseData.containsKey('data')) {
          final mealDetailsData = responseData['data'] as List<dynamic>;
          setState(() {
            mealDetails = mealDetailsData
                .map((data) => MealDetail.fromJson(data))
                .toList();
          });
          print(mealDetails);
        } else {
          throw Exception("Data field not found in the response");
        }
      } else {
        throw Exception("Failed to load meal details: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch meal details: $e");
    }
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
        title: Text("Meal Details"),
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
                      // subtitle: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: mealDetail.meals.map((mealItem) {
                      //     return Text("Meal Name: ${mealItem.name}");
                      //   }).toList(),
                      // ),

                      leading: Container(
                        width: 100.w,
                        height: 100.h,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: imageUrls.length,
                          itemBuilder: (context, index) {
                            print(imageUrls);
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
                      // You can display other meal details here
                    ),
                  ),
                );
              },
            ),
    );
  }
}
