import 'package:actividades_pais/src/pages/Monitor/main/components/fab.dart';
import 'package:actividades_pais/src/pages/Monitor/main/monitoring/monitor_list.dart';
import 'package:flutter/material.dart';
import 'components/custom_bottom_bar.dart';

import 'package:actividades_pais/custom_background.dart';
import 'package:actividades_pais/src/pages/Monitor/main/monitoring/project_list_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/monitoring/project_new_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/footer_option_.dart';
import 'package:actividades_pais/src/pages/Monitor/gallery/gallery_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with TickerProviderStateMixin<MainPage> {
  late TabController bottomTabController;

  Animation<double>? _animation;
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );
    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _controller!);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
    bottomTabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomBar(controller: bottomTabController),
      body: CustomPaint(
        painter: MainBackground(),
        child: TabBarView(
          controller: bottomTabController,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            ProjectPage(),
            // ProjectNewPage(),
            MonitorList(),
            ProfilePage(),
            GalleryPage(),
          ],
        ),
      ),
      /*floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "Option 1",
            Icons.folder,
            onPress: () {
              _controller!.reverse();
            },
          ),
          FabItem(
            "Option 2",
            Icons.settings,
            onPress: () {
              _controller!.reverse();
            },
          ),
        ],
        animation: _animation!,
        onPress: () {
          if (_controller!.isCompleted) {
            _controller!.reverse();
          } else {
            _controller!.forward();
          }
        },
      ),*/
    );
  }
}
