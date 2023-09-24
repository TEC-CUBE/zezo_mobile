import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zezo/view/workout_screen.dart';
import 'home_screen.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;
  String? _token;
  @override
  void initState() {
    super.initState();
    // _getToken();
  }

  // Future<void> _getToken() async {
  //   final token = await SharedPreferencesModel.getToken();
  //   setState(() {
  //     _token = token;
  //   });
  // }

  final List<Widget> _pages = [
    HomeScreen(),
    WorkoutScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _token != null ? _pages[_currentIndex] : _pages[_currentIndex],
      // Center(child: CircularProgressIndicator()),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 57, 56, 56),
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
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.dumbbell),
            label: 'التمارين',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.utensils),
            label: 'التغذية',
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
        selectedItemColor: Colors.blue,
        onTap: _onTabTapped,
      ),
      // bottomNavigationBar: Container(
      //   color: const Color.fromARGB(255, 57, 56, 56),
      //   child: Padding(
      //     padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      //     child: GNav(
      //       selectedIndex: _currentIndex,
      //       onTabChange: _onTabTapped,
      //       // gap: 2,
      //       activeColor: Color.fromARGB(255, 0, 106, 255),
      //       backgroundColor: const Color.fromARGB(255, 57, 56, 56),
      //       color: Colors.white,
      //       tabBackgroundColor: Colors.grey.shade800,
      //       iconSize: 16.w,
      //       textSize: 8,
      //       padding: EdgeInsets.fromLTRB(15.w, 10.h, 15.w, 10.h),
      //       tabs: [
      //         GButton(
      //           icon: Icons.home,
      //           text: 'الصفحة الرئيسية',
      //         ),
      //         GButton(
      //           icon: FontAwesomeIcons.dumbbell,
      //           text: 'التمارين',
      //         ),
      //         GButton(
      //           icon: Icons.home,
      //           text: 'التغذية',
      //         ),
      //         GButton(
      //           icon: Icons.home,
      //           text: 'المتابعة',
      //         ),
      //         GButton(
      //           icon: Icons.home,
      //           text: 'الصفحة الشخصية',
      //         ),
      //       ],
      //     ),
      //   ),
      // )
    );
  }
}
