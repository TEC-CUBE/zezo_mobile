import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import '../utils/routes/routes_name.dart';
import '../view_model/user_view_model.dart';
import '../view_model/profile_view_model.dart';
import 'login_view.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userData = {};
  final Uri _urlWhatsapp = Uri.parse("https://wa.me/218917863522");

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await Profile.fetchData(context);
    setState(() {
      userData = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        title: const Text('الملف الشخصي'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10.h),
            ListTile(
              title: Text(userData['name'] ?? '',
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: const Color.fromARGB(255, 255, 250, 250))),
              leading: const CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 25.0,
                backgroundImage: AssetImage(
                    'assets/images/profile.png'), // Replace with your image path
              ),
            ),
            SizedBox(height: 15.h),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('تواصل معنا',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color.fromARGB(255, 255, 250, 250))),
                  SizedBox(height: 10.h),
                  Divider(
                      color: const Color.fromARGB(255, 30, 30, 43),
                      height: 1.h,
                      thickness: 1)
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Color.fromARGB(255, 6, 159, 182)),
              onTap: () {
                launch(_urlWhatsapp.toString());
              },
            ),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الشركة المنفذة',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color.fromARGB(255, 255, 250, 250))),
                  SizedBox(height: 10.h),
                  Divider(
                      color: const Color.fromARGB(255, 30, 30, 43),
                      height: 1.h,
                      thickness: 1)
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Color.fromARGB(255, 6, 159, 182)),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutPage(),
                  ),
                );
              },
            ),
            ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('تسجيل الخروج',
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color.fromARGB(255, 255, 250, 250))),
                  SizedBox(height: 10.h),
                  Divider(
                      color: const Color.fromARGB(255, 30, 30, 43),
                      height: 1.h,
                      thickness: 1)
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios,
                  size: 16, color: Color.fromARGB(255, 6, 159, 182)),
              onTap: () {
                userPrefernece.remove().then((value) async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginView()),
                      (Route<dynamic> route) => false);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        title: const Text('الشركة المنفذة'),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Center(
              child: Container(
                width: 200.w,
                height: 200.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Text('NetCube',
                style: TextStyle(
                    fontSize: 30.sp,
                    color: const Color.fromARGB(255, 255, 250, 250))),
          ])),
    );
  }
}
