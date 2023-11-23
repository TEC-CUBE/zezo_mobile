import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  static double averageRating(List<int> rating) {
    var avgRating = 0;
    for (int i = 0; i < rating.length; i++) {
      avgRating = avgRating + rating[i];
    }
    return double.parse((avgRating / rating.length).toStringAsFixed(1));
  }

  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  // static void flushBarErrorMessage(String message, BuildContext context){

  //   showFlushbar(context: context,
  //       flushbar: Flushbar(
  //         forwardAnimationCurve:Curves.decelerate,
  //         margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //         padding: EdgeInsets.all(15),
  //         message: message,
  //         duration: Duration(seconds: 3),
  //         borderRadius: BorderRadius.circular(8),
  //         flushbarPosition: FlushbarPosition.TOP,
  //         backgroundColor: Colors.red,
  //         reverseAnimationCurve: Curves.easeInOut,
  //         positionOffset: 20,
  //         icon: Icon(Icons.error , size: 28 , color: Colors.white,),
  //       )..show(context),

  //   );

  // }

  static snackBar(String message, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(backgroundColor: Colors.red, content: Text(message)));
  }

  static showCenteredSnackBar(
      BuildContext context, String message, Color color) {
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
              color: color,
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
}
