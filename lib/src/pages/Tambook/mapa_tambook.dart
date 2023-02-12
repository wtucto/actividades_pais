import 'package:actividades_pais/util/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapTambook extends StatefulWidget {
  const MapTambook({super.key});

  @override
  State<MapTambook> createState() => _MapTambookState();
}

class _MapTambookState extends State<MapTambook>
    with TickerProviderStateMixin<MapTambook> {
  Animation<double>? _animation;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final List<LatLng> _mapPoints = [
      LatLng(-5.46956247418, -78.4377694873),
      LatLng(-10.2993301033, -77.1508496114),
      LatLng(-14.3910996075, -72.8284609821)
    ];

    return Scaffold(
      backgroundColor: color_10o15,
      body: Stack(
        children: <Widget>[
          FlutterMap(
            options: MapOptions(
              center: LatLng(-8.840959270481326, -74.82263875411157),
              zoom: 5.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: ['a', 'b', 'c'],
                //tileProvider: const CachedNetworkTileProvider(),
              ),
              MarkerLayerOptions(
                markers: [
                  for (var point in _mapPoints) ...[
                    Marker(
                      width: 30.0,
                      height: 30.0,
                      point: point,
                      builder: (ctx) => Container(
                        child: Icon(
                          Icons.location_on,
                          size: 30,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ]
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
