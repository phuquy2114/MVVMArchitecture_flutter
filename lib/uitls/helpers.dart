import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Helpers {
  /// This function for show loading popup
  static void onLoading(context, [duration]) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              content: Container(
                color: Colors.transparent,
                width: 50.0,
                height: 50.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.transparent,
                      child: SpinKitThreeBounce(
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ],
                ),
              ));
        });
    if (duration != null) {
      Future.delayed(Duration(seconds: duration), () {
        Navigator.pop(context); //pop dialog
      });
    }
  }
}
