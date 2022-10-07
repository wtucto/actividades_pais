import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform;

class CheckGeolocator {
  Future<List<Position>> check() async {
    late LocationSettings locationSettings;
    if (defaultTargetPlatform == TargetPlatform.android) {
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
    } else {}

    List<Position> aPosition = [];
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return List.empty(); //Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return List
          .empty(); //Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    aPosition.add(
      await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      ),
    );
    return aPosition;

    /** 
     * List<Position> aPosition = await CheckGeolocator().check();
     * aPosition[0].latitude.toString();
     * aPosition[0].longitude.toString();
     */
  }
}
