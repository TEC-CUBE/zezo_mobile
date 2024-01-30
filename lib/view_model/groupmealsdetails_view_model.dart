import 'package:CoachZiad/model/groupmealdetails_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/groub_meals_model.dart';

class MealDeatailsGroups {
  final followupId; // Update the data type to int
  final day;

  MealDeatailsGroups(this.followupId, this.day);

  Future<List<MealDetail>> fetchGroupsMealDeatails({String? token}) async {
    final url = Uri.parse(
        "http://3.223.187.125:8022/api/v1/trainee/followupmeals?filters=followup_id:eq:${followupId},day:eq:${day}");

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      //print(response.body);

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData.containsKey('data')) {
          final mealGroupData = responseData['data'] as List<dynamic>;
          return mealGroupData
              .map((data) => MealDetail.fromJson(data))
              .toList();
        } else {
          throw Exception("Data field not found in the response");
        }
      } else {
        throw Exception("Failed to load meal groups: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Failed to fetch meal groups: $e");
    }
  }
}
