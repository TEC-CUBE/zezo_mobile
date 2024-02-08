import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static Future<String> deleteAcount(String? token) async {
    try {
      final response = await http.delete(
        Uri.parse('http://3.223.187.125:8022/api/v1/users/delete'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return response.statusCode.toString();
      } else {
        final responseData = json.decode(response.body);
        final errorMessage = responseData['message'];
        print(errorMessage);
        return response.statusCode.toString();
      }
    } catch (e) {
      return 'An error occurred';
    }
  }
}
