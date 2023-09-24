import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zezo/model/user_model.dart';
import 'package:zezo/respository/auth_repository.dart';
import 'package:zezo/utils/routes/routes_name.dart';
import 'package:zezo/utils/utils.dart';
import 'package:zezo/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../model/signup_model.dart';

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
        'http://zezo.teccube.ly/login'); // Replace with your API endpoint
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final jsonBody = jsonEncode(data);

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        // Successful response
        print('POST request successful');
        print(response.body);
        final responseData = jsonDecode(response.body);
        final token = responseData['tokens']
            ['access_token']; // Correctly access the token
        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        userPreference.saveUserToken(token);
        Navigator.pushNamed(context as BuildContext, RoutesName.bottomnavbar);
      } else {
        // Handle the error response
        print('POST request failed with status ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      // Handle any exceptions
      print('Error making POST request: $e');
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

  Future<void> signUpApi(SignUpData signUpData) async {
    final url = Uri.parse(
        'http://zezo.teccube.ly/mobile/user/init'); // Replace with your API endpoint
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final jsonBody = jsonEncode(signUpData.toJson());

    try {
      final response = await http.post(
        url,
        headers: headers,
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        // Successful response
        print('POST request successful');
        print(response.body);
      } else {
        // Handle the error response
        print('POST request failed with status ${response.statusCode}');
        print(response.body);
      }
    } catch (e) {
      // Handle any exceptions
      print('Error making POST request: $e');
    }
  }
}
