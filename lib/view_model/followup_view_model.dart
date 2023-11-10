import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:CoachZiad/model/followup_model.dart';

Future<String?> getUserToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('token');
}

Future<List<Followup>> fetchData() async {
  final String? userToken = await getUserToken();

  if (userToken != null) {
    final url = Uri.parse('http://zezo.teccube.ly/followups');
    final headers = {
      'Authorization': 'Bearer $userToken', // Include the authorization header
    };

    try {
      final response = await http.get(
        url,
        headers: headers,
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        List<Followup> tempList = [];

        for (var item in jsonResponse) {
          tempList.add(Followup.fromJson(item));
        }

        // Sort the list by the "created" field in ascending order (oldest to newest)
        tempList.sort((a, b) {
          if (a.created == null || b.created == null) {
            return 0;
          }
          return a.created!.compareTo(b.created!);
        });

        return tempList;
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (e) {
      // Handle any exceptions
      print('Error making GET request: $e');
      throw e;
    }
  } else {
    // Handle the case where the user is not logged in
    throw Exception('User is not logged in');
  }
}
