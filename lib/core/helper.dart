import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Helper {
  static backDropFilter(context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Stack(
        children: [
          Center(
            child: SpinKitPumpingHeart(
              color: Colors.red,
              size: 50.0,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            color: Colors.white.withOpacity(0),
          )
        ],
      ),
    );
  }

  static displaySnakBar(context, String message) {
    var snackBar = SnackBar(
      content: Text(message),
    );

// Find the ScaffoldMessenger in the widget tree
// and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
