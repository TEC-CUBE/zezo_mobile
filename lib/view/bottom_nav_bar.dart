import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:CoachZiad/view/generalmeals_view.dart';
import 'package:CoachZiad/view/postfollowup_view.dart';
import 'package:CoachZiad/view/profile_view.dart';
import 'followupMealWorkout_view.dart';
import 'followup_view.dart';
import 'home_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  String? _token;
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void initState() {
    super.initState();
    getConnectivity();
    // _getToken();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // homeViewViewModel.fetchMoviesListApi();
    subscription.cancel();

    super.dispose();
  }
  // Future<void> _getToken() async {
  //   final token = await SharedPreferencesModel.getToken();
  //   setState(() {
  //     _token = token;
  //   });
  // }

  final List<Widget> _pages = [
    HomeScreen(),
    // HomeScreen(),
    MealsScreen(),
    FollowupView(),
    //FollowupMealWorkoutView(),
    ProfilePage(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle the back button press
        // Return true to allow back navigation, or false to prevent it
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _token != null ? _pages[_currentIndex] : _pages[_currentIndex],
        // Center(child: CircularProgressIndicator()),

        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 15, 15, 24),
          type: BottomNavigationBarType.fixed,
          // elevation: 9,
          unselectedItemColor: Colors.white,
          iconSize: 20.sp,
          selectedFontSize: 12.sp,
          unselectedFontSize: 12.sp,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'الرئيسية',
            ),
            // BottomNavigationBarItem(
            //   icon: FaIcon(FontAwesomeIcons.dumbbell),
            //   label: 'التمارين',
            // ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.utensils),
              label: 'الوجبات',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.clipboard),
              label: 'المتابعة',
            ),
            BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.user),
              label: 'الحساب',
            ),
          ],
          currentIndex: _currentIndex,
          selectedItemColor: Color.fromARGB(255, 6, 159, 182),
          onTap: _onTabTapped,
        ),
        
      ),
    );
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 300.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Dialog(
                    backgroundColor: const Color.fromARGB(255, 15, 15, 24),
                    child: Container(
                      height: 180.h,
                      width: 180.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "لا يوجد اتصال بالانترنت",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 10.h,
                          ),
                          ElevatedButton(
                            child: Text("حاول مرة اخري",
                                style: TextStyle(fontSize: 14.sp)),
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromARGB(255, 252, 79, 79),
                              // side: BorderSide(color: Colors.yellow, width: 5),
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontStyle: FontStyle.normal),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            onPressed: () async {
                              Navigator.pop(context, 'Cancel');
                              setState(() => isAlertSet = false);
                              isDeviceConnected =
                                  await InternetConnectionChecker()
                                      .hasConnection;
                              if (!isDeviceConnected && isAlertSet == false) {
                                showDialogBox();
                                setState(() => isAlertSet = true);
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )));
}
