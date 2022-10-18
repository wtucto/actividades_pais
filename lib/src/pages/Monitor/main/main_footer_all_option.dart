import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:actividades_pais/src/pages/Monitor/main/components/fab.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/Monitoring/monitoring_list_page.dart';
import 'package:flutter/material.dart';
import 'components/custom_bottom_bar.dart';

import 'package:actividades_pais/custom_background.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/main_footer_project_list_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/Project/Monitoring/monitoring_detail_new_edit_page.dart';
import 'package:actividades_pais/src/pages/Monitor/main/settings/main_footer_setting_page.dart';
import 'package:actividades_pais/src/pages/Monitor/gallery/gallery_page.dart';

class MainFooterAllOptionPage extends StatefulWidget {
  @override
  _MainFooterAllOptionPageState createState() =>
      _MainFooterAllOptionPageState();
}

class _MainFooterAllOptionPageState extends State<MainFooterAllOptionPage>
    with TickerProviderStateMixin<MainFooterAllOptionPage> {
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
    bottomTabController = TabController(length: 3, vsync: this);
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
            MainFooterProjectPage(),
            MonitorList(),
            MainFooterSettingPage(),
            // GalleryPage(),
          ],
        ),
      ),
      /*drawer: Drawer(
        child: Material(
          textStyle: const TextStyle(color: Colors.white, fontSize: 16),
          child: Container(
            color: const Color(0xFF5B4382),
            padding: const EdgeInsets.all(20),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //----------------------------
                  // Drawer title
                  //----------------------------
                  Row(
                    children: const [
                      Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      Text(
                        ' Settings',
                        style: TextStyle(
                          fontSize: 26,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 40),
                  //----------------------------
                  // Visible Items Control
                  //----------------------------
                  Row(
                    children: [
                      const Icon(
                        Icons.visibility_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      const Text(
                        ' Visible items',
                        style: TextStyle(),
                      ),
                      Expanded(
                        child: Slider(
                          value: 8,
                          min: 2,
                          max: 15,
                          divisions: 15,
                          label: '8',
                          activeColor: Colors.deepPurple[200],
                          inactiveColor: Colors.deepPurple[400],
                          onChanged: (value) {
                            setState(() {
                              //_visibleItems = value.toInt();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                  const Divider(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),*/
      /*floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: ExpandedAnimationFab(
        items: [
          FabItem(
            "Nuevo Monitoreo",
            Icons.add_to_queue,
            onPress: () {
              _controller!.reverse();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MonitoringDetailNewEditPage(
                      datoProyecto: null,
                    );
                  },
                ),
              );
            },
          ),
          /*FabItem(
            "Enviar Monitoreos",
            Icons.cloud_upload_rounded,
            onPress: () {
              _controller!.reverse();
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return MonitoringDetailNewEditPage();
                  },
                ),
              );
            },
          ),*/
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
