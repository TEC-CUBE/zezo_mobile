import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:CoachZiad/utils/routes/routes_name.dart';
import 'package:CoachZiad/view_model/user_view_model.dart';

import '../view_model/profile_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    checkUserLoggedIn();
  }

  Future<void> checkUserLoggedIn() async {
    await Future.delayed(const Duration(seconds: 3));
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    await userViewModel.getUser();

    final response = await Profile.fetchData(context);
    if (response.containsKey('error')) {
      final errorMessage = response['error'];
      // Handle the error, e.g., show a message or navigate to the login screen
      if (errorMessage == 'jwt expired') {
        // JWT token has expired, navigate to the login screen to reauthenticate
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text(errorMessage),
        //   ),
        // );
        Navigator.pushNamed(context, RoutesName.login);
      }
    } else {
      // Data is available, process it
      if (userViewModel.token != null) {
        // User is logged in, navigate to the bottom navigation bar screen
        Navigator.pushNamed(context, RoutesName.bottomnavbar);
      } else {
        // User is not logged in, navigate to the login screen
        Navigator.pushNamed(context, RoutesName.login);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 15, 24),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Image(
              image: AssetImage("assets/images/zezo_logo3.png"),
              height: 200.h,
              width: 200.w,
              //width: 300,
            ),
            SizedBox(
              height: 50.h,
            ),
            SpinKitThreeBounce(
              color: const Color.fromARGB(255, 6, 159, 182),
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
