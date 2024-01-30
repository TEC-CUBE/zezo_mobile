import 'package:http/http.dart' as http;
import 'dart:convert';
import '../model/meals_model.dart';

class MealsAPI {
  final String apiUrl = "http://3.223.187.125:8022/api/v1/trainee/meals";
  int currentPage = 1;

  Future<List<Meal>> fetchMeals({required String token}) async {
    final response = await http.get(
      Uri.parse("$apiUrl?page=$currentPage"),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)["data"];
      currentPage++;
      return data.map((json) => Meal.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }
}
