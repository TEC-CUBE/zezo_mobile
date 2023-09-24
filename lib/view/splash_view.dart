import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    await Future.delayed(Duration(seconds: 3));
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
      backgroundColor: const Color.fromARGB(255, 57, 56, 56),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
            ),
            Image(
              image: AssetImage("assets/images/cuplogo.png"),
              width: 300,
            ),
            SizedBox(
              height: 200,
            ),
            SpinKitThreeBounce(
              color: const Color.fromARGB(255, 30, 99, 196),
              size: 50.0,
            )
          ],
        ),
      ),
    );
  }
}
