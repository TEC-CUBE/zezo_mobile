import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:zezo/utils/routes/routes_name.dart';
import 'package:zezo/view_model/user_view_model.dart';

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
    // Add a 3-second delay
    await Future.delayed(const Duration(seconds: 3));
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    await userViewModel.getUser();

    if (userViewModel.token != null) {
      // User is logged in, navigate to the bottom navigation bar screen
      Navigator.pushNamed(context, RoutesName.bottomnavbar);
    } else {
      // User is not logged in, navigate to the login screen
      Navigator.pushNamed(context, RoutesName.login);
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
              height: 200.h,
            ),
            // Image(
            //   image: AssetImage("assets/images/cuplogo.png"),
            //   width: 300,
            // ),
            SizedBox(
              height: 200.h,
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
