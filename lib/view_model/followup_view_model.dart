import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

import '../view_model/user_view_model.dart';

class FollowupApi {
  static Future<List<dynamic>> fetchFollowups(String token) async {
    final url = Uri.parse("http://3.223.187.125:8022/api/v1/trainee/followups");

    try {
      final response = await http.get(
        url,
        headers: {
          "Authorization": "Bearer $token",
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final followupData = responseData['data'];
        return followupData;
      } else {
        throw Exception("Failed to load followups");
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
