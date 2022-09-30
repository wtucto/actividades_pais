import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BusyIndicator {
  static show(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return WillPopScope(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white.withOpacity(0.9),
            child: Center(
              child: CircularProgressIndicator(),
            ), // Center
          ),
          onWillPop: () async => false,
        ); // Container
      },
    );
  }

  static hide(BuildContext context) {
    Navigator.pop(context);
  }
}

/**
 * SAMPLE USE:
 * BusyIndicator.show(context);
 * BusyIndicator.hide(context);
 */
