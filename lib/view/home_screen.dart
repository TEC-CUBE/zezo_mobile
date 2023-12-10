import 'package:CoachZiad/view_model/trainee_view_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localization/localization.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:CoachZiad/view/postfollowup_view.dart';
import 'package:CoachZiad/view/profile_view.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/home_view_model.dart';
import '../view_model/profile_view_model.dart';
import '../view_model/user_view_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  List<dynamic> traineeData = [];
  int currentPage = 1;
  int totalPages = 1;
  Map<String, dynamic> followeupuserData = {};
  bool isLoading = false; 

  final urlImages = [
    const AssetImage("assets/images/physicale.png"),
    const AssetImage("assets/images/physically.png"),
    const AssetImage("assets/images/targetzone.png")
  ];

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    fetchTraineeData();
    fetchData();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    final response = await Profile.fetchData(context);

    if (response is Map<String, dynamic>) {
      setState(() {
        followeupuserData = response;
      });
    } else {
      
      print('Invalid response format in fetchData()');
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchTraineeData();
    }
  }

  Future<void> fetchTraineeData() async {
    final response = await Trainee.fetchTraineeData(
      currentPage: currentPage,
      isLoading: isLoading,
      traineeData: traineeData,
      setStateCallback: setState,
    );
  }

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
        
            CarouselSlider.builder(
              itemCount: urlImages.length,
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                autoPlay: true,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: false,
                enableInfiniteScroll: true,
            
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
               
                final urlImage = urlImages[index];
                return Image(
                  image: urlImage,
                  fit: BoxFit.cover,
                );
              },
            ),

            SizedBox(height: 10.h),

            InkWell(
              onTap: () {
                final String? created_at =
                    followeupuserData['followup_date'] as String?;
                if (created_at != null) {
                  DateTime? createdAt = DateTime.tryParse(created_at);
                  if (createdAt != null) {
                    DateTime now = DateTime.now();

                    if (now.difference(createdAt) < Duration(hours: 24)) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostFollowup(),
                        ),
                      );
                    } else {
                     
                      Utils.showCenteredSnackBar(
                          context, "لم يحن وقت المتابعة بعد !", Colors.red);
                    }
                  } else {
                   
                    print("Invalid 'created_at' format");
                  }
                } else {
                 
                  Utils.showCenteredSnackBar(
                      context, "لم يحن وقت المتابعة بعد !", Colors.red);
                }
              },
              child: Container(
                height: 50.h,
                width: 320.w,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                        width: 1,
                        color: const Color.fromARGB(255, 6, 159, 182)),
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.0.w, 8.0.h, 12.0.w, 8.0.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ارسال بيانات المتابعة الي المدرب",
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white),
                      ),
                      Icon(Icons.add,
                          color: const Color.fromARGB(255, 6, 159, 182),
                          size: 20.sp),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            Padding(
              padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "نتائج عملائنا",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: traineeData.length,
              itemBuilder: (context, index) {
                final trainee = traineeData[index];
                return trainee['image'] != null
                    ? Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Card(
                          elevation: 10,
                          shape: Border.all(
                              width: 2,
                              color: const Color.fromARGB(255, 6, 159, 182)),
                          child: Image.network(
                            Uri.parse(trainee['image']).toString(),
                            height: 200.h,
                            width: 200.w,
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }
}
