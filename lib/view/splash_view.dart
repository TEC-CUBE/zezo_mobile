import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:CoachZiad/utils/routes/routes_name.dart';
import 'package:CoachZiad/view_model/user_view_model.dart';
import '../utils/utils.dart';
import '../view_model/profile_view_model.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  bool _loading = true;
  late Timer _snackbarTimer;

  @override
  void initState() {
    super.initState();
    _checkUserLoggedIn();
    _startSnackbarTimer();
  }

  void _startSnackbarTimer() {
    _snackbarTimer = Timer.periodic(Duration(seconds: 5), (timer) {
      _checkInternet().then((isConnected) {
        if (isConnected) {
          timer.cancel(); // Stop the timer when connected
        } else {
          _showSnackBar('لا يوجد اتصال بالانترنت !');
        }
      });
    });
  }

  Future<void> _checkUserLoggedIn() async {
    await Future.delayed(const Duration(seconds: 3));
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    await userViewModel.getUser();

    try {
      final response = await Profile.fetchData(context);

      if (response.containsKey('error')) {
        final errorMessage = response['error'];
        if (await _checkInternet()) {
          if (errorMessage == 'jwt expired') {
            _navigateToRoute(RoutesName.login);
          } else if (errorMessage == '400') {
            // Handle other error cases or show a snackbar
            _navigateToRoute(RoutesName.login);
            // print("Error: $errorMessage");
          } else {
            _navigateToRoute(RoutesName.login);
          }
        } else {
          _showSnackBar('لا يوجد اتصال بالانترنت !');
        }
      } else {
        if (userViewModel.token != null) {
          _navigateToRoute(RoutesName.bottomnavbar);
        } else {
          _navigateToRoute(RoutesName.login);
        }
      }
    } catch (error) {
      print("Error: $error");
      _showSnackBar(
          'An error occurred. Please check your internet connection!');
    }

    setState(() {
      _loading = false;
    });
  }

  Future<bool> _checkInternet() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      return connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi;
    } catch (error) {
      print("Error checking internet connection: $error");
      _showSnackBar(
          'An error occurred. Please check your internet connection!');
      return false;
    }
  }

  void _showSnackBar(String message) {
    Utils.snackBar(message, context);
  }

  void _navigateToRoute(String routeName) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Navigator.pushReplacementNamed(context, routeName);
    });
  }

  @override
  void dispose() {
    _snackbarTimer.cancel(); // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 15, 24),
      body: Center(
        child: _loading
            ? _buildLoadingIndicator()
            : _buildLoadingIndicator(), // You can replace this with your main content
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 100.h,
        ),
        Image(
          image: AssetImage("assets/images/zezo_logo3.png"),
          height: 200.h,
          width: 200.w,
        ),
        SizedBox(
          height: 50.h,
        ),
        SpinKitThreeBounce(
          color: const Color.fromARGB(255, 6, 159, 182),
          size: 50.0,
        )
      ],
    );
  }
}
