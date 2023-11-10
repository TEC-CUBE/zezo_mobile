import 'package:flutter/cupertino.dart';
import 'package:CoachZiad/model/user_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  // Future<bool> saveUser(dynamic user) async {
  //   final SharedPreferences sp = await SharedPreferences.getInstance();
  //   final userData = user is Map ? user['data'] as Map<String, dynamic> : null;

  //   if (userData != null && userData.containsKey('token')) {
  //     final token = userData['token'].toString();
  //     sp.setString('token', token);
  //     notifyListeners();
  //     return true;
  //   } else {
  //     // Handle the case where 'user' is not a valid map or does not contain 'token'.
  //     return false;
  //   }
  // }

  String? _token;

  String? _tokenError;

  Future<void> saveUserToken(String token) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString('token', token);
    _token = token;
    notifyListeners();
  }

  Future<bool> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    _token = sp.getString('token');
    return _token != null;
  }

  String? get token => _token;

  String? get tokenError => _tokenError;

  Future<void> remove() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove('token');
    _token = null;
    notifyListeners();
  }

  void savetokenError(String error) {
    _tokenError = error;
    notifyListeners();
  }

  void handleTokenError() {
    _tokenError; // Set the error message
    notifyListeners();
  }

  // Use the token as the user ID
  String? fetchUserId() {
    return _token;
  }
}
