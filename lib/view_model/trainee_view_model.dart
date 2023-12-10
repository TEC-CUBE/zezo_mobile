import 'dart:convert';
import 'package:http/http.dart' as http;


class Trainee {
   static Future<Map<String, dynamic>> fetchTraineeData({
    required int currentPage,
    required bool isLoading,
    required List<dynamic> traineeData,
    required Function setStateCallback,
  }) async {
    // Avoid fetching data if already loading
    if (isLoading) {
      return {};
    }

    // Set loading flag to true
    setStateCallback(() {
      isLoading = true;
    });

    // Fetch data from the API
    final Uri url = Uri.parse('http://3.223.187.125:8022/api/v1/trainee/trainee?page=$currentPage');
    final response = await http.get(url);

    // Process the response
    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      if (data is Map<String, dynamic> && data.containsKey('data')) {
        setStateCallback(() {
          traineeData.addAll(data['data']);
          final meta = data['meta'];
          currentPage = meta['current_page'];
          isLoading = false; // Reset loading flag
        });
      } else {
        print('Invalid response format in fetchTraineeData()');
      }
    } else {
      throw Exception('Failed to load data');
    }

    return {};
  }
}
