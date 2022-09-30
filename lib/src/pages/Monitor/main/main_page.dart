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

  @override
  void initState() {
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
            ProjectNewPage(),
            ProfilePage(),
            GalleryPage(),
          ],
        ),
      ),
    );
  }
}
