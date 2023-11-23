import 'package:carousel_slider/carousel_slider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localization/localization.dart';
import 'package:lottie/lottie.dart';
// import 'package:CoachZiad/data/response/status.dart';
// import 'package:CoachZiad/model/movies_model.dart';
// import 'package:CoachZiad/utils/routes/routes_name.dart';
// import 'package:CoachZiad/utils/utils.dart';
// import 'package:CoachZiad/view/student_screen.dart';
// import 'package:CoachZiad/view_model/home_view_model.dart';
// import 'package:CoachZiad/view_model/user_view_model.dart';
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

  Map<String, dynamic> followeupuserData = {};

  final urlImages = [
    const AssetImage("assets/images/physicale.png"),
    const AssetImage("assets/images/physically.png"),
    const AssetImage("assets/images/targetzone.png")
  ];

  @override
  void initState() {
    // TODO: implement initState
    // homeViewViewModel.fetchMoviesListApi();
    // getConnectivity();

    fetchtraineeData();
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    final response = await Profile.fetchData(context);

    if (response is Map<String, dynamic>) {
      setState(() {
        followeupuserData = response;
      });
    } else {
      // Handle the case where the response is not a Map
      // You can show an error message or perform other actions as needed.
      print('Invalid response format in fetchData()');
    }
  }

  Future<void> fetchtraineeData() async {
    final Uri url =
        Uri.parse('http://3.223.187.125:8022/api/v1/trainee/trainee');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data is Map<String, dynamic> && data.containsKey('data')) {
        setState(() {
          traineeData = data['data'];
        });
      } else {
        // Handle the case where the response doesn't have the expected structure
        // You can show an error message or perform other actions as needed.
        print('Invalid response format in fetchtraineeData()');
      }
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 15, 15, 24),
      //Color.fromARGB(255, 57, 56, 56),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 15, 15, 24),
        // title: Image(
        //   image: AssetImage("assets/images/cuplogo.png"),
        //   width: 100,
        // ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      // drawer: Drawer(
      //   backgroundColor: Color.fromARGB(255, 245, 245, 245),
      //   child: Padding(
      //     padding: const EdgeInsets.only(top: 100),
      //     child: Column(
      //       children: [
      //         ListTile(
      //           leading: Icon(
      //             Icons.home_outlined,
      //             color: Color.fromARGB(255, 152, 33, 243),
      //           ),
      //           title: Text(
      //             "home".i18n(),
      //             style: TextStyle(
      //               color: Color.fromARGB(255, 101, 14, 168),
      //             ),
      //           ),
      //           onTap: () {
      //             Navigator.pushNamed(context, RoutesName.home);
      //           },
      //         ),
      //         Divider(
      //           color: Color.fromARGB(255, 181, 144, 255),
      //           thickness: 0.3,
      //         ),
      //         ListTile(
      //           leading: Icon(
      //             Icons.call,
      //             color: Color.fromARGB(255, 152, 33, 243),
      //           ),
      //           title: Text(
      //             "contact_us".i18n(),
      //             style: TextStyle(
      //               color: Color.fromARGB(255, 101, 14, 168),
      //             ),
      //           ),
      //           onTap: () {
      //             launchUrl(PhoneNumber);
      //           },
      //         ),
      //         ListTile(
      //           title: Text(
      //             "logout".i18n(),
      //             style: TextStyle(
      //               color: Color.fromARGB(255, 152, 33, 243),
      //             ),
      //           ),
      //           leading: Icon(
      //             Icons.logout_outlined,
      //             color: Color.fromARGB(255, 152, 33, 243),
      //           ),
      //           onTap: () {
      //             userPrefernece.remove().then((value) {
      //               Navigator.pushNamed(context, RoutesName.login);
      //             });
      //           },
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Add your text and images here
            // Example:
            CarouselSlider.builder(
              itemCount: urlImages.length,
              //carouselController: _controller,
              options: CarouselOptions(
                height: 200,
                viewportFraction: 1.0,
                autoPlay: true,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 3),
                enlargeCenterPage: false,
                enableInfiniteScroll: true,
                // onPageChanged: (index, reason) {
                //   setState(() {
                //     currentIndex =
                //         index; // Update the index.
                //   });
                // },
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                // final image = workoutDetail['images'][index];
                // return Image.network(image['name']);
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
                //"2023-11-19T00:00:00.000Z";
                if (created_at != null) {
                  DateTime? createdAt = DateTime.tryParse(created_at);
                  if (createdAt != null) {
                    DateTime now = DateTime.now();

                    // Check if the difference between now and createdAt is less than a certain duration
                    if (now.difference(createdAt) < Duration(hours: 24)) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => PostFollowup(),
                        ),
                      );
                    } else {
                      // Disable the onPressed action
                      // This will effectively make the button unresponsive
                      // You can also show a message to indicate why it's disabled
                      // For example, display a snackbar with a message.
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //   SnackBar(
                      //     backgroundColor: Color.fromARGB(255, 30, 30, 43),
                      //     content: Text("لم يحن وقت المتابعة بعد !"),
                      //   ),
                      // );
                      Utils.showCenteredSnackBar(
                          context, "لم يحن وقت المتابعة بعد !", Colors.red);
                    }
                  } else {
                    // Handle the case where 'created_at' is not a valid DateTime string
                    // You can show a message or perform other actions as needed.
                    print("Invalid 'created_at' format");
                  }
                } else {
                  // Handle the case where 'created_at' is null
                  // You can show a message or perform other actions as needed.
                  print("'created_at' is null");
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

            // Display images in a ListView.builder
            ListView.builder(
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling within the ListView.builder
              shrinkWrap: true, // Allow it to take the required height
              itemCount: traineeData.length,
              itemBuilder: (context, index) {
                final trainee = traineeData[index];
                return trainee['image'] != null
                    ? Image.network(
                        Uri.parse(trainee['image']).toString(),
                        height: 200.h,
                        width: 200.w,
                        fit: BoxFit
                            .fill, // You can use different BoxFit as needed
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),

      // Center(
      //   child: Column(
      //     children: [
      //       // Text('kkkkkkkkkkkkkkkkkk'),
      //       // Text('kkkkkkkkkkkkkkkkkk'),
      //       // Text('kkkkkkkkkkkkkkkkkk'),
      //       // Text('kkkkkkkkkkkkkkkkkk'),
      //       // Text('kkkkkkkkkkkkkkkkkk'),

      //     ],
      //   ),
      // )
    );
  }

  // showDialogBox() => showCupertinoDialog<String>(
  //     context: context,
  //     builder: (BuildContext context) => Center(
  //             child: Padding(
  //           padding: const EdgeInsets.only(top: 300.0),
  //           child: SingleChildScrollView(
  //             child: Column(
  //               children: [
  //                 Dialog(
  //                   backgroundColor: const Color.fromARGB(255, 15, 15, 24),
  //                   child: Container(
  //                     height: 180.h,
  //                     width: 180.w,
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         // Expanded(
  //                         //     child: Lottie.asset(
  //                         //         "assets/images/NoIternet.json",
  //                         //         width: 180,
  //                         //         fit: BoxFit.fitWidth)),
  //                         // const SizedBox(
  //                         //   height: 150,
  //                         // ),
  //                         Text(
  //                           "لا يوجد اتصال بالانترنت",
  //                           style: TextStyle(
  //                               fontSize: 18.sp,
  //                               fontWeight: FontWeight.bold,
  //                               color: Colors.white),
  //                         ),

  //                         SizedBox(
  //                           height: 10.h,
  //                         ),
  //                         ElevatedButton(
  //                           child: Text("حاول مرة اخري",
  //                               style: TextStyle(fontSize: 14.sp)),
  //                           style: ElevatedButton.styleFrom(
  //                             primary: const Color.fromARGB(255, 252, 79, 79),
  //                             // side: BorderSide(color: Colors.yellow, width: 5),
  //                             textStyle: const TextStyle(
  //                                 color: Colors.white,
  //                                 fontSize: 25,
  //                                 fontStyle: FontStyle.normal),
  //                             shape: RoundedRectangleBorder(
  //                                 borderRadius: BorderRadius.circular(10)),
  //                           ),
  //                           onPressed: () async {
  //                             Navigator.pop(context, 'Cancel');
  //                             setState(() => isAlertSet = false);
  //                             isDeviceConnected =
  //                                 await InternetConnectionChecker()
  //                                     .hasConnection;
  //                             if (!isDeviceConnected && isAlertSet == false) {
  //                               showDialogBox();
  //                               setState(() => isAlertSet = true);
  //                             }
  //                           },
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ))

  //     );

  /*ChangeNotifierProvider<HomeViewViewModel> a() {
    return ChangeNotifierProvider.value(
      value: homeViewViewModel,
      child: Consumer<HomeViewViewModel>(builder: (context, value, _) {
        switch (value.moviesList.status!) {
          case Status.LOADING:
            return Center(child: CircularProgressIndicator());
          case Status.ERROR:
            return Center(child: Text(value.moviesList.message.toString()));
          case Status.COMPLETED:
            return Column(
              children: [
                SizedBox(height: 20),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: SizedBox(
                        height: 160.0,
                        child: Carousel(
                          images: [
                            ExactAssetImage("assets/images/Sliders.png"),
                            ExactAssetImage("assets/images/Sliderss.png"),
                            //ExactAssetImage("assets/images/Sliders.png")
                          ],
                          dotSize: 6,
                          dotSpacing: 15.0,
                          dotColor: Colors.grey,
                          showIndicator: false,
                          indicatorBgPadding: 5.0,
                          // dotBgColor: primaryColors,
                          borderRadius: true,
                        )),
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Text(
                        "Students List",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                      itemCount: value.moviesList.data!.data!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RoutesName.student);
                          },
                          child: Card(
                            color: Color.fromARGB(255, 255, 255, 255),
                            elevation: 8,
                            margin: EdgeInsets.all(8),
                            child: Container(
                                height: MediaQuery.of(context).size.height / 5,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 20, bottom: 25),
                                        child: Image.asset(
                                          'assets/images/student.png',
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 45, left: 25, right: 25),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    value
                                                        .moviesList
                                                        .data!
                                                        .data![index]
                                                        .studentname
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  ),
                                                ],
                                              ),
                                              Divider(
                                                color: Color.fromARGB(
                                                    255, 75, 74, 74),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    value.moviesList.data!
                                                        .data![index].classname
                                                        .toString(),
                                                    style: TextStyle(),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                              ),
                                            ],
                                          ),
                                        ))
                                    //.....
                                  ],
                                )),
                          ),
                          /*child: Card(
                            
                            
                            child: ListTile(
                              /* leading: Image.network(
                                        
                                  value.moviesList.data!.data![index].studentname.toString(),
                              errorBuilder: (context, error, stack){
                                    return Icon(Icons.error, color: Colors.red,);
                              },
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),*/
                              title: Text(value
                                  .moviesList.data!.data![index].studentname
                                  .toString()),
                              subtitle: Text(value
                                  .moviesList.data!.data![index].classname
                                  .toString()),
                            ),
                          ),*/
                        );
                      }),
                ),
              ],
            );
        }
      }),
    );
  }*/
}
