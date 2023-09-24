import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:localization/localization.dart';
import 'package:lottie/lottie.dart';
// import 'package:zezo/data/response/status.dart';
// import 'package:zezo/model/movies_model.dart';
// import 'package:zezo/utils/routes/routes_name.dart';
// import 'package:zezo/utils/utils.dart';
// import 'package:zezo/view/student_screen.dart';
// import 'package:zezo/view_model/home_view_model.dart';
// import 'package:zezo/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/routes/routes_name.dart';
import '../view_model/home_view_model.dart';
import '../view_model/user_view_model.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  _WorkoutScreenState createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  HomeViewViewModel homeViewViewModel = HomeViewViewModel();
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    // TODO: implement initState
    // homeViewViewModel.fetchMoviesListApi();
    getConnectivity();

    super.initState();
  }

  getConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isDeviceConnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    // TODO: implement dispose
    // homeViewViewModel.fetchMoviesListApi();
    subscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userPrefernece = Provider.of<UserViewModel>(context);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 57, 56, 56),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 57, 56, 56),
          // title: Image(
          //   image: AssetImage("assets/images/cuplogo.png"),
          //   width: 100,
          // ),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              Text('WorkoutScreen'),
              Text('WorkoutScreen'),
              Text('WorkoutScreen'),
              Text('WorkoutScreen'),
              Text('WorkoutScreen'),
            ],
          ),
        )

        /* ChangeNotifierProvider<HomeViewViewModel>.value(
        value: homeViewViewModel,
        child: Consumer<HomeViewViewModel>(
          builder: (context, value, _) {
            switch (value.moviesList.status!) {
              case Status.LOADING:
                return Center(child: CircularProgressIndicator());
              case Status.ERROR:
                return Text(value.moviesList.message.toString());
              case Status.COMPLETED:
                return Column(
                  children: [
                    SizedBox(height: 20),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, left: 15),
                        child: SizedBox(
                            height: 160.0,
                            child: Image.asset('assets/images/Sliders.png')),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, top: 15, bottom: 15),
                      child: Row(
                        children: [
                          Text(
                            "studentslist".i18n(),
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: value.moviesList.data!.data!.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                //Navigator.pushNamed(  context, RoutesName.student);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => StudentScreen(
                                          student: value.moviesList.data!
                                              .data![index].studentid),
                                    ));
                              },
                              child: Card(
                                color: Color.fromARGB(255, 255, 255, 255),
                                elevation: 8,
                                margin: EdgeInsets.all(8),
                                child: Container(
                                    height:
                                        MediaQuery.of(context).size.height / 5,
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
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 22),
                                                      ),
                                                    ],
                                                  ),
                                                  Divider(
                                                    color: Color.fromARGB(
                                                        255, 75, 74, 74),
                                                    thickness: 1,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        value
                                                            .moviesList
                                                            .data!
                                                            .data![index]
                                                            .classname
                                                            .toString(),
                                                        style: TextStyle(
                                                            fontSize: 15),
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
            return Container();
          },
        ),
      ),*/
        );
  }

  showDialogBox() => showCupertinoDialog<String>(
      context: context,
      builder: (BuildContext context) => Center(
              child: Padding(
            padding: const EdgeInsets.only(top: 300.0),
            child: Column(
              children: [
                Dialog(
                  backgroundColor: Color.fromARGB(255, 255, 255, 255),
                  child: Container(
                    height: 300,
                    width: 330,
                    child: Column(
                      children: [
                        Expanded(
                            child: Lottie.asset("assets/images/NoIternet.json",
                                width: 180, fit: BoxFit.fitWidth)),
                        SizedBox(
                          height: 150,
                        ),
                        Expanded(
                          child: Text(
                            "Network Error",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            child: Text("try again"),
                            style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 252, 79, 79),
                              // side: BorderSide(color: Colors.yellow, width: 5),
                              textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontStyle: FontStyle.normal),
                              shape: BeveledRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                            ),
                            onPressed: () async {
                              Navigator.pop(context, 'Cancel');
                              setState(() => isAlertSet = false);
                              isDeviceConnected =
                                  await InternetConnectionChecker()
                                      .hasConnection;
                              if (!isDeviceConnected && isAlertSet == false) {
                                showDialogBox();
                                setState(() => isAlertSet = true);
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )));
}
