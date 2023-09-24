import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zezo/utils/routes/routes_name.dart';
import 'package:zezo/view/home_screen.dart';
import 'package:zezo/view/login_view.dart';
import 'package:zezo/view/signp_view.dart';
import 'package:zezo/view/splash_view.dart';

import '../../view/bottom_nav_bar.dart';
// import 'package:zezo/utils/routes/routes_name.dart';
// import 'package:zezo/view/home_screen.dart';
// import 'package:zezo/view/login_view.dart';
// import 'package:zezo/view/signp_view.dart';
// import 'package:zezo/view/splash_view.dart';
// import 'package:zezo/view/student_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.splash:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashView());

      case RoutesName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());

      // case RoutesName.student:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const StudentScreen(
      //             student: null,
      //           ));
      case RoutesName.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginView());
      // case RoutesName.signUp:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const SignUpView());
      case RoutesName.gendertype:
        return MaterialPageRoute(
            builder: (BuildContext context) => const genderscreen());
      // case RoutesName.physicalactivity:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const physicallyActivrScreen());
      // case RoutesName.setgoal:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const setgoalscreen());
      // case RoutesName.selectbodytype:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const selectbodytypescreen());
      // case RoutesName.selectbodygoal:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const selectbodygoalscreen());
      // case RoutesName.motivationcheckbox:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) =>
      //           const motivationCheckboxscreen());
      // case RoutesName.profiledetails:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const profiledetailsscreen());
      // case RoutesName.targetzone:
      //   return MaterialPageRoute(
      //       builder: (BuildContext context) => const targetzonescreen());
      case RoutesName.verifyphone:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Verifyphone());
      case RoutesName.bottomnavbar:
        return MaterialPageRoute(
            builder: (BuildContext context) => BottomNavBar());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('No route defined'),
            ),
          );
        });
    }
  }
}
