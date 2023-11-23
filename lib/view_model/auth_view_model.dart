import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:CoachZiad/model/user_model.dart';
import 'package:CoachZiad/respository/auth_repository.dart';
import 'package:CoachZiad/utils/routes/routes_name.dart';
import 'package:CoachZiad/utils/utils.dart';
import 'package:CoachZiad/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../model/signup_model.dart';
import '../view/bottom_nav_bar.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> loginApi(BuildContext context, dynamic data) async {
    final url = Uri.parse(
        'http://3.223.187.125:8022/api/v1/login'); // Replace with your API endpoint
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final jsonBody = jsonEncode(data);

    try {
      // showDialog(
      //   context: context,
      //   barrierDismissible: false, // Prevent user from closing the dialog
      //   builder: (BuildContext context) {
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // );
      final response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        // Successful response

        final responseData = jsonDecode(response.body);
        final token = responseData['token'];
        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        userPreference.saveUserToken(token);
        // Navigator.pushNamed(context, RoutesName.bottomnavbar);
        // Introduce a 2-second delay before navigating to BottomNavBar
        //await Future.delayed(Duration(seconds: 2));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BottomNavBar()),
            (Route<dynamic> route) => false);
      } else if (response.statusCode == 401) {
        // Unauthorized - Invalid credentials
        _showErrorDialog(context, 'خطأ في بيانات الدخول');
      } else if (response.statusCode == 404) {
        // Not Found - User not found
        _showErrorDialog(context, 'خطأ في بيانات الدخول');
      } else if (response.statusCode == 400) {
        _showErrorDialog(context, 'خطأ في بيانات الدخول');
      } else if (response.statusCode == 500) {
        _showErrorDialog(context, 'خطأ في الشبكة ');
      } else {
        // Handle other error scenarios
        _showErrorDialog(context, 'حدث خطأ ما الرجاء المحاولة مرة اخرى');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error making POST request: $e');
      _showErrorDialog(context, 'حدث خطأ ما الرجاء المحاولة مرة اخرى');
    }
  }

  // Future<void> signUpApi(dynamic data, BuildContext context) async {
  //   setSignUpLoading(true);

  //   _myRepo.signUpApi(data).then((value) {
  //     setSignUpLoading(false);
  //     Utils.flushBarErrorMessage('SignUp Successfully', context);
  //     Navigator.pushNamed(context, RoutesName.home);
  //     if (kDebugMode) {
  //       print(value.toString());
  //     }
  //   }).onError((error, stackTrace) {
  //     setSignUpLoading(false);
  //     Utils.flushBarErrorMessage(error.toString(), context);
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   });
  // }

  Future<void> signUpApi(BuildContext context, dynamic signUpData) async {
    final url = Uri.parse(
        'http://3.223.187.125:8022/api/v1/register'); // Replace with your API endpoint
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final jsonBody = jsonEncode(signUpData);

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        // Successful response
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: const Color.fromARGB(255, 30, 30, 43),
              title: const Icon(Icons.check,
                  color: const Color.fromARGB(255, 6, 159, 182), size: 48.0),
              content: const Text(
                "تم التسجيل بنجاح",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              actions: <Widget>[
                Center(
                  child: Container(
                    width: 80,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor:
                              const Color.fromARGB(255, 6, 159, 182)),
                      child: const Text('تم'),
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                        Navigator.pushNamed(context, RoutesName.login);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        );
      } else if (response.statusCode == 500) {
        _showErrorDialog(context, 'خطأ في الشبكة ');
      } else if (response.statusCode == 422) {
        _showErrorDialog(context, 'المستخدم موجود مسبقا');
      } else {
        // Handle other error scenarios
        _showErrorDialog(context, 'حدث خطأ ما الرجاء المحاولة مرة اخرى');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error making POST request: $e');
      _showErrorDialog(context, 'حدث خطأ ما الرجاء المحاولة مرة اخرى');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 15, 15, 24),
          //title: Text('Error'),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          actions: <Widget>[
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 252, 79, 79),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      // fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
