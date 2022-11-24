import 'package:actividades_pais/src/pages/Tambook/category_list_view.dart';
import 'package:actividades_pais/src/pages/Tambook/course_info_screen.dart';
import 'package:actividades_pais/src/pages/Tambook/design_course_app_theme.dart';
import 'package:flutter/material.dart';

class HomeTambook extends StatefulWidget {
  const HomeTambook({super.key});

  @override
  State<HomeTambook> createState() => _HomeTambookState();
}

class _HomeTambookState extends State<HomeTambook> {
  List<Widget> listViews = <Widget>[];
  CategoryType categoryType = CategoryType.ui;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: DesignCourseAppTheme.nearlyWhite,
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text("TAMBOOK"),
          ),
          shape: const CustomAppBarShape(multi: 0.05),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                iconSize: 30,
                onPressed: () {},
                icon: const Icon(
                  Icons.book,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            getAppBarUI(),
            Expanded(
              child: ListView(
                primary: false,
                children: [
                  getSearchBarUI(),
                  getCategoryUI(),
                  // const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CourseInfoScreen(),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/Tambook/mapa-removebg-preview.png',
                      // height: 200,
                      // width: 200,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CourseInfoScreen(),
                        ),
                      );
                    },
                    child: getPopularCourseUI(),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Container(
            //       height: MediaQuery.of(context).size.height,
            //       child: Column(
            //         children: [
            //           const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
            //           // getSearchBarUI(),
            //           // getCategoryUI(),
            //           Flexible(
            //             child: getPopularCourseUI(),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget getCategoryUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryListView(
          callBack: () {
            moveTo();
          },
        ),
      ],
    );
  }

  Widget getPopularCourseUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Últimas Intervenciones',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22,
              letterSpacing: 0.27,
              color: DesignCourseAppTheme.darkerText,
            ),
          ),
          const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
          Card(
            margin: const EdgeInsets.all(10),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'DIRECCION REGIONAL DE AGRICULTURA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.27,
                      color: DesignCourseAppTheme.darkerText,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    'VI Feria Agromercado 2022, con la finalidad de comercializar los productos agropecuarios y derivados propios de la zona a precios razonables y cumpliendo los protocolos de bioseguridad directamente a los consumidores finales, evento realizado por la Agencia Agraria Melgar, dirigido a las asociaciones de productores y población del distrito de Ayaviri.',
                    textAlign: TextAlign.justify,
                  ),
                ),
                Image.asset('assets/design_course/puno.jpeg'),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(5),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'FISE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.27,
                      color: DesignCourseAppTheme.darkerText,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    'VI Feria Agromercado 2022, con la finalidad de comercializar los productos agropecuarios y derivados propios de la zona a precios razonables y cumpliendo los protocolos de bioseguridad directamente a los consumidores finales, evento realizado por la Agencia Agraria Melgar, dirigido a las asociaciones de productores y población del distrito de Ayaviri.',
                    textAlign: TextAlign.justify,
                  ),
                ),
                Image.asset('assets/design_course/segundo.jpg'),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(5),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'SUB PREFECTURA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.27,
                      color: DesignCourseAppTheme.darkerText,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    'VI Feria Agromercado 2022, con la finalidad de comercializar los productos agropecuarios y derivados propios de la zona a precios razonables y cumpliendo los protocolos de bioseguridad directamente a los consumidores finales, evento realizado por la Agencia Agraria Melgar, dirigido a las asociaciones de productores y población del distrito de Ayaviri.',
                    textAlign: TextAlign.justify,
                  ),
                ),
                Image.asset('assets/design_course/tercero.jpeg'),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.all(5),
            elevation: 1,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    'CENTRO DE SALUD (ESPECIALIDAD)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      letterSpacing: 0.27,
                      color: DesignCourseAppTheme.darkerText,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    'VI Feria Agromercado 2022, con la finalidad de comercializar los productos agropecuarios y derivados propios de la zona a precios razonables y cumpliendo los protocolos de bioseguridad directamente a los consumidores finales, evento realizado por la Agencia Agraria Melgar, dirigido a las asociaciones de productores y población del distrito de Ayaviri.',
                    textAlign: TextAlign.justify,
                  ),
                ),
                Image.asset('assets/design_course/cuarto.jpg'),
              ],
            ),
          ),
          // Flexible(
          //   child: PopularCourseListView(
          //     callBack: () {
          //       moveTo();
          //     },
          //   ),
          // )
        ],
      ),
    );
  }

  void moveTo() {
    Navigator.push<dynamic>(
      context,
      MaterialPageRoute<dynamic>(
        builder: (BuildContext context) => CourseInfoScreen(),
      ),
    );
  }

  Widget getButtonUI(CategoryType categoryTypeData, bool isSelected) {
    String txt = '';
    if (CategoryType.ui == categoryTypeData) {
      txt = 'Inicio';
    } else if (CategoryType.coding == categoryTypeData) {
      txt = 'Sectoriales';
    } else if (CategoryType.basic == categoryTypeData) {
      txt = 'Departamento';
    }
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: isSelected
                ? DesignCourseAppTheme.nearlyBlue
                : DesignCourseAppTheme.nearlyWhite,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            border: Border.all(color: DesignCourseAppTheme.nearlyBlue)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            splashColor: Colors.white24,
            borderRadius: const BorderRadius.all(Radius.circular(24.0)),
            onTap: () {
              setState(() {
                categoryType = categoryTypeData;
              });
            },
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 12, bottom: 12, left: 18, right: 18),
              child: Center(
                child: Text(
                  txt,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    letterSpacing: 0.27,
                    color: isSelected
                        ? DesignCourseAppTheme.nearlyWhite
                        : DesignCourseAppTheme.nearlyBlue,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 64,
            child: Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor('#F8FAFB'),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(13.0),
                    bottomLeft: Radius.circular(13.0),
                    topLeft: Radius.circular(13.0),
                    topRight: Radius.circular(13.0),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Buscar por Tambo',
                            hintText: 'Buscar por Tambo',
                            suffixIcon: Icon(Icons.search),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.blue,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                width: 2.0,
                              ),
                            ),
                            helperStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: Colors.black,
                            ),
                          ),
                          onEditingComplete: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Expanded(
            child: SizedBox(),
          )
        ],
      ),
    );
  }

  Widget getAppBarUI() {
    return Container(
      // color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/Monitor/logo.png',
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ),
            Container(
              width: 60,
              height: 60,
              child: Image.asset('assets/Tambook/MicrosoftTeams-image.png'),
            )
          ],
        ),
      ),
    );
  }
}

enum CategoryType {
  ui,
  coding,
  basic,
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}

class CustomAppBarShape extends ContinuousRectangleBorder {
  final double multi;
  const CustomAppBarShape({this.multi = 0.5});
  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    double height = rect.height;
    double width = rect.width;
    var path = Path();
    path.lineTo(0, height + width * multi);
    path.arcToPoint(
      Offset(width * multi, height),
      radius: Radius.circular(width * multi),
    );
    path.lineTo(width * (1 - multi), height);
    path.arcToPoint(
      Offset(width, height + width * multi),
      radius: Radius.circular(width * multi),
    );
    path.lineTo(width, 0);
    path.close();

    return path;
  }
}
