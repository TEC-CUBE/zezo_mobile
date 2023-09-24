import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:zezo/model/user_model.dart';
import 'package:zezo/utils/routes/routes_name.dart';
import 'package:zezo/view_model/user_view_model.dart';

class SplashServices {
  Future<bool> getUserDate() => UserViewModel().getUser();

  void checkAuthentication(BuildContext context) async {
    getUserDate().then((value) async {
      // print(value.token.toString());
      if (value == 'null' || value == ' ') {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      } else {
        await Future.delayed(Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.bottomnavbar);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error.toString());
      }
    });
  }
}
