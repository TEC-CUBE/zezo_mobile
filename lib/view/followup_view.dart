import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../view_model/user_view_model.dart';
import 'followupMealWorkout_view.dart';

class FollowupView extends StatefulWidget {
  @override
  _FollowupViewState createState() => _FollowupViewState();
}

class _FollowupViewState extends State<FollowupView> {
  List<dynamic> followups = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);

    if (userViewModel.token != null) {
      final token = userViewModel.token;

      final url =
          Uri.parse("http://3.223.187.125:8022/api/v1/trainee/followups");

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

          setState(() {
            followups = followupData;
          });
        } else {
          throw Exception("Failed to load followups");
        }
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        title: const Text("المتابعة"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: followups.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: followups.length,
              itemBuilder: (context, index) {
                final followup = followups[index];
                int weekNumber = index + 1; // Week numbers start at 1
                String weekText = "الأسبوع $weekNumber";

                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FollowupMealWorkoutView(
                            followup['id']), // Pass the followup data
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      SizedBox(height: 15.h),
                      ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(weekText,
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 255, 250, 250))),
                            SizedBox(height: 10.h),
                            Divider(
                                color: Color.fromARGB(255, 30, 30, 43),
                                height: 1.h,
                                thickness: 1)
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Color.fromARGB(255, 6, 159, 182)),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
