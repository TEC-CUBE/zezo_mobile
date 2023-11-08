import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WorkoutDetailsPage extends StatefulWidget {
  final int workoutId;

  WorkoutDetailsPage(this.workoutId);

  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  Map<String, dynamic>? workoutData;
  int currentIndex = 0;
  final CarouselController _controller = CarouselController();
  int timeLeft = 0;
  bool isTimerRunning = false;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchWorkoutDetails();
  }

  Future<void> fetchWorkoutDetails() async {
    final int workoutId = widget.workoutId;
    final url = Uri.parse(
        "http://3.223.187.125:8022/api/v1/trainee/followupworkout/$workoutId");

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body) as Map<String, dynamic>;

        if (responseData != null) {
          setState(() {
            workoutData = responseData;
            if (!isTimerRunning) {
              timeLeft = int.parse(workoutData!['time']);
            }
          });
        }
      } else {
        throw Exception("Failed to load workout details");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        title: Text('تفاصيل التمرين'),
      ),
      body: workoutData != null
          ? ListView(
              children: <Widget>[
                if (workoutData!['workouts'] != null)
                  Padding(
                    padding: EdgeInsets.only(top: 14.0.h),
                    child: Column(
                      children: [
                        for (var workoutDetail in workoutData!['workouts'])
                          Column(
                            children: [
                              if (workoutDetail['images'] != null)
                                Column(
                                  children: [
                                    CarouselSlider.builder(
                                      itemCount: workoutDetail['images'].length,
                                      carouselController: _controller,
                                      options: CarouselOptions(
                                        height: 200,
                                        viewportFraction: 1.0,
                                        enlargeCenterPage: false,
                                        enableInfiniteScroll: true,
                                        autoPlay: true,
                                        onPageChanged: (index, reason) {
                                          setState(() {
                                            currentIndex = index;
                                          });
                                        },
                                      ),
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        final image =
                                            workoutDetail['images'][index];
                                        return Image.network(image['name']);
                                      },
                                    ),
                                    SizedBox(height: 10.h),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20.0.w, right: 20.0.w),
                                      child: Divider(
                                          color:
                                              Color.fromARGB(255, 30, 30, 43),
                                          height: 1.h,
                                          thickness: 2),
                                    )
                                  ],
                                ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20.0.w, right: 20.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      workoutDetail['name'],
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 250, 250),
                                          fontSize: 22.sp,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 10.h),
                              // Padding(
                              //   padding: EdgeInsets.only(
                              //       left: 20.0.w, right: 20.0.w),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.start,
                              //     children: [
                              //       Text(
                              //         'التفاصيل',
                              //         style: TextStyle(
                              //             color: Color.fromARGB(
                              //                 255, 255, 250, 250),
                              //             fontSize: 22.sp,
                              //             fontWeight: FontWeight.bold),
                              //       ),
                              //     ],
                              //   ),
                              // ),

                              Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0.h, bottom: 20.0.h),
                                child: SizedBox(
                                  height: workoutData != null
                                      ? workoutData!['quantity'].isEmpty
                                          ? 250
                                              .h // Default height when quantity is empty  workoutData!['quantity'].length
                                          : (workoutData!['quantity'].length *
                                                  40.0.h) +
                                              100.0
                                                  .h // Adjusted height based on quantity
                                      : 250
                                          .h, // Default height when workoutData is null
                                  child: Container(
                                    width: 300.w,
                                    // height: 250.h,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 30, 30, 43),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: SingleChildScrollView(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            12.0, 8.0, 12.0, 8.0),
                                        child: Column(
                                          children: [
                                            // Column(
                                            //   crossAxisAlignment:
                                            //       CrossAxisAlignment.start,
                                            //   children: [
                                            //     Text(
                                            //       workoutData!['quantity']
                                            //           .toString(),
                                            //       style: TextStyle(
                                            //         color: Colors.white,
                                            //         fontSize: 16.sp,
                                            //       ),
                                            //     ),
                                            //     SizedBox(height: 10.h),
                                            //     Divider(
                                            //       color: Color.fromARGB(
                                            //           255, 94, 148, 156),
                                            //       height: 1.h,
                                            //       thickness: 1,
                                            //     ),
                                            //     SizedBox(height: 20.h),
                                            //   ],
                                            // ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.0.w, right: 8.0.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'الجلسات',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  Text(
                                                    'الترديدات',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Column(
                                              // crossAxisAlignment:
                                              //     CrossAxisAlignment.start,

                                              //int.parse(workoutData!['quantity']
                                              children: [
                                                for (int i = 1;
                                                    i <=
                                                        int.parse(workoutData![
                                                            'quantity']);
                                                    i++)
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      left: 8.0.w,
                                                      right: 8.0.w,
                                                      top: 8.0.h,
                                                      bottom: 8.0.h,
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              width: 30.w,
                                                              height: 30.h,
                                                              decoration: BoxDecoration(
                                                                  color: Color
                                                                      .fromARGB(
                                                                          255,
                                                                          44,
                                                                          44,
                                                                          59),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30)),
                                                              child: Center(
                                                                child: Text(
                                                                  i.toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        16.sp,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            // SizedBox(width: 20.w),
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      left: 20.0
                                                                          .w),
                                                              child: Text(
                                                                workoutData![
                                                                    'reps'],
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      16.sp,
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                            left: 8.0.w,
                                                            right: 8.0.w,
                                                            top: 4.0.h,
                                                            // bottom: 4.0.h,
                                                          ),
                                                          child: Divider(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      44,
                                                                      44,
                                                                      59),
                                                              height: 1.h,
                                                              thickness: 1),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                              ],
                                            ),

                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 8.0.w, right: 8.0.w),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    'الراحة',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.sp,
                                                    ),
                                                  ),
                                                  Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      Container(
                                                        height: 40.h,
                                                        width: 40.w,
                                                        child:
                                                            CircularProgressIndicator(
                                                          value: timeLeft == 0
                                                              ? 1.0
                                                              : (1 -
                                                                  (timeLeft /
                                                                      int.parse(
                                                                          workoutData![
                                                                              'time']))),
                                                          valueColor:
                                                              AlwaysStoppedAnimation<
                                                                  Color>(
                                                            const Color
                                                                    .fromARGB(
                                                                255,
                                                                6,
                                                                159,
                                                                182),
                                                          ),
                                                          strokeWidth: 5.0,
                                                        ),
                                                      ),
                                                      timeLeft == 0
                                                          ? Icon(
                                                              Icons.done,
                                                              color: const Color
                                                                      .fromARGB(
                                                                  255,
                                                                  6,
                                                                  159,
                                                                  182),
                                                              size: 30.sp,
                                                            )
                                                          : Text(
                                                              timeLeft
                                                                  .toString(),
                                                              style: TextStyle(
                                                                color: const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    6,
                                                                    159,
                                                                    182),
                                                                fontSize: 16.sp,
                                                              ),
                                                            ),
                                                    ],
                                                  ),
                                                  isTimerRunning
                                                      ? Container()
                                                      : Center(
                                                          child: Container(
                                                            width: 50.w,
                                                            height: 50.h,
                                                            child:
                                                                ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                primary: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        44,
                                                                        44,
                                                                        59),
                                                                shape:
                                                                    const CircleBorder(), // Set the shape to a circle
                                                              ),
                                                              onPressed: () {
                                                                isTimerRunning =
                                                                    true;
                                                                _startTimer(
                                                                    workoutData![
                                                                        'time']);
                                                              },
                                                              child: Text(
                                                                'بدء',
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      12.sp,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(height: 30.h),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
              ],
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void _startTimer(String initialTimeString) {
    int initialTime = int.parse(initialTimeString);
    timeLeft = initialTime;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        isTimerRunning = false;
        // Optionally, you can perform some action when the timer ends.
        // For example, display a message or play a sound.
        // Implement any desired behavior here.
      }
    });
  }
}
