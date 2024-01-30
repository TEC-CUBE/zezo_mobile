import 'package:CoachZiad/model/blog_model.dart';
import 'package:CoachZiad/model/trainee_model.dart';
import 'package:CoachZiad/view_model/blog_view_model.dart';
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
  int currentPage2 = 1;
  int totalPages = 1;
  Map<String, dynamic> followeupuserData = {};
  bool isLoading = false;
  bool isLoading2 = false;
  final userPrefernece = UserViewModel();

  List<BlogPost> _blogdata = [];
  late BlogApi _blogApi;
  List<TraineePost> traineeposts = [];
  late Trainee traineeApi;
  final urlImages = [
    const AssetImage("assets/images/physicale.png"),
    const AssetImage("assets/images/physically.png"),
    const AssetImage("assets/images/targetzone.png")
  ];

  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();

  @override
  void initState() {
    _blogApi = BlogApi();
    traineeApi = Trainee();
    fetchTraineeData();
    fetchData();
    fetchblogData();
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

  void _scrollListener2() {
    if (_scrollController2.position.pixels ==
        _scrollController2.position.maxScrollExtent) {
      fetchblogData();
    }
  }

  Future<void> fetchTraineeData() async {
    if (isLoading) {
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      final token =
          await userPreference.getToken(); // Get token from shared preferences
      final List<TraineePost> trainee =
          await traineeApi.fetchTrainee(currentPage, token: token);
      setState(() {
        traineeposts.addAll(trainee);
        currentPage++;
      });
    } catch (e) {
      print('Error fetching trainee data: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchblogData() async {
    if (isLoading2) {
      return;
    }

    try {
      setState(() {
        isLoading2 = true;
      });
      final userPreference = Provider.of<UserViewModel>(context, listen: false);
      final token =
          await userPreference.getToken(); // Get token from shared preferences
      final List<BlogPost> posts =
          await _blogApi.fetchBlogPosts(currentPage2, token: token);
      setState(() {
        _blogdata.addAll(posts);
        currentPage++;
      });
    } catch (e) {
      print('Error fetching blog data: $e');
    } finally {
      setState(() {
        isLoading2 = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            _blogdata.isEmpty
                ? SizedBox.shrink()
                : Column(
                    children: [
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "مقالات و مدونات المدرب",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 150.h,
                        child: ListView.builder(
                          shrinkWrap: true,
                          controller: _scrollController,
                          scrollDirection: Axis.horizontal,
                          itemCount: _blogdata.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                // Navigate to a new page on item click
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => BlogDetailsPage(
                                        blogPost: _blogdata[index]),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.network(
                                      _blogdata[index].image,
                                      width: 100,
                                      height: 100,
                                    ),
                                    Text(
                                      _blogdata[index].name,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
            traineeposts.isEmpty
                ? SizedBox.shrink()
                : Column(
                    children: [
                      SizedBox(height: 5.h),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "نتائج عملائنا",
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: traineeposts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Card(
                              elevation: 10,
                              shape: Border.all(
                                  width: 2,
                                  color:
                                      const Color.fromARGB(255, 6, 159, 182)),
                              child: Image.network(
                                traineeposts[index].image,
                                height: 200.h,
                                width: 200.w,
                                fit: BoxFit.fill,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

class BlogDetailsPage extends StatefulWidget {
  final BlogPost blogPost;

  const BlogDetailsPage({Key? key, required this.blogPost}) : super(key: key);

  @override
  _BlogDetailsPageState createState() => _BlogDetailsPageState();
}

class _BlogDetailsPageState extends State<BlogDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        title: Text(
          'مقالات و مدونات المدرب',
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
        child: Column(
          children: [
            Center(
              child: Image.network(
                widget.blogPost.image,
                width: 200.w,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.blogPost.name,
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.blogPost.contact,
                      style: TextStyle(fontSize: 15.sp, color: Colors.white)),
                ],
              ),
            ),

            // Add other details as needed
          ],
        ),
      ),
    );
  }
}
