import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:ui' as ui;
import '../view_model/user_view_model.dart';
import 'home_screen.dart';

class PostFollowup extends StatefulWidget {
  @override
  _PostFollowupState createState() => _PostFollowupState();
}

class _PostFollowupState extends State<PostFollowup> {
  final TextEditingController fatController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  List<File> _imgs = []; // Initialize with an empty list for multiple images
  final _formKey = GlobalKey<FormState>();

  Future<void> postFollowup() async {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final token = userViewModel.token;

    // Fetch user data from the 'me' endpoint to get the 'user_id'
    final userDataResponse = await http.get(
      Uri.parse('http://3.223.187.125:8022/api/v1/me'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (userDataResponse.statusCode == 200) {
      final userData = jsonDecode(userDataResponse.body);
      final user_id = userData['id'];

      final url =
          Uri.parse('http://3.223.187.125:8022/api/v1/trainee/followups');

      var request = http.MultipartRequest('POST', url)
        ..fields['user_id'] = user_id
        ..fields['fat'] = fatController.text
        ..fields['weight'] = weightController.text;

      // Add image files to the request
      for (int i = 0; i < _imgs.length; i++) {
        final File imageFile = _imgs[i];
        request.files.add(await http.MultipartFile.fromPath(
          'imgs', // Use 'imgs[]' to allow multiple images
          imageFile.path,
          filename: 'image$i.jpg', // Optional: Set a custom filename
        ));
      }

      request.headers['Authorization'] = 'Bearer $token';

      var response = await request.send();
      if (response.statusCode == 200) {
        // Request was successful
        // Handle the success scenario
        showCenteredSnackBar(context, 'تم اضافة المتابعة بنجاح');
        Navigator.pop(context);
      } else {
        // Handle the error response
        print('POST request failed with status ${response.statusCode}');
      }
    } else {
      // Handle the error when fetching user data
      print(
          'Failed to fetch user data with status ${userDataResponse.statusCode}');
    }
  }

  Future<void> pickAndUploadImage() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imgs.add(File(pickedFile.path));
        showCenteredSnackBar(context, 'تم اضافة الصور بنجاح');
      });
    }
  }

  void showCenteredSnackBar(BuildContext context, String message) {
    final OverlayEntry overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.5,
        left: MediaQuery.of(context).size.width * 0.25,
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: 40.h,
            width: MediaQuery.of(context).size.width * 0.5,
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(overlayEntry);

    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        title: Text(
          'اضافة متابعة جديدة',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios,
              color: Color.fromARGB(255, 255, 250, 250)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.0.w, 20.0.h, 20.0.w, 0.0.h),
          child: Form(
            key: _formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  height: 50.h,
                  width: 320.w,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 232, 232),
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 94, 148, 156),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                          child: TextFormField(
                            controller: fatController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "الدهون",
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),
                Container(
                  height: 50.h,
                  width: 320.w,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 232, 232, 232),
                      border: Border.all(
                        width: 1,
                        color: Color.fromARGB(255, 94, 148, 156),
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Directionality(
                    textDirection: ui.TextDirection.rtl,
                    child: Row(
                      children: [
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.only(left: 15.0.w, right: 15.0.w),
                          child: TextFormField(
                            controller: weightController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "الوزن",
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
                // TextFormField(
                //   controller: weightController,
                //   decoration: InputDecoration(labelText: 'Weight'),
                // ),
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: const Color.fromARGB(255, 6, 159, 182)
                          //Color.fromARGB(255, 30, 99, 196),
                          ),
                      onPressed: pickAndUploadImage,
                      child: Text('اختر صورة',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                // if (_imgs.isNotEmpty)
                //   Column(
                //     children: _imgs.map((imageFile) {
                //       return Image.file(
                //         imageFile,
                //         width: 100,
                //         height: 100,
                //       );
                //     }).toList(),
                //   ),
                SizedBox(height: 30.h),
                Container(
                  height: 45.h,
                  width: 200.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 6, 159, 182)
                        //Color.fromARGB(255, 30, 99, 196),
                        ),
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          _imgs.isNotEmpty) {
                        postFollowup();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            backgroundColor: Colors.red,
                            content:
                                Text('الرجاء ملء جميع الحقول واختيار صورة'),
                          ),
                        );
                      }
                    },
                    child: Text('ارسال',
                        style: TextStyle(fontSize: 20.sp, color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
