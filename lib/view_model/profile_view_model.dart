import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../view_model/user_view_model.dart';

class Profile {
  static Future fetchData(BuildContext context) async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final token = userViewModel.token;
    final response = await http.get(
      Uri.parse('http://3.223.187.125:8022/api/v1/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data; // Return the entire response data as a JSON object
    } else {
      return {
        print('Error response: ${response.statusCode}')
      }; // Handle error case
    }
  }
}
