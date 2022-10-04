import 'package:actividades_pais/helpers/dependecy_injection.dart';
import 'package:actividades_pais/src/datamodels/database/DatabasePr.dart';
import 'package:actividades_pais/src/pages/Monitor/intro/splash_intro_page.dart';
import 'package:actividades_pais/resource/Internationalization.dart';

import 'package:flutter/material.dart';

import 'package:actividades_pais/src/pages/Home/home.dart';
import 'package:actividades_pais/src/pages/Login/Login.dart';
import 'package:get/route_manager.dart';
import 'package:overlay_support/overlay_support.dart';

void main() {
  DependencyInjection.initialize("DEV");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Registo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
        locale: MyTraslation.locale,
        fallbackLocale: MyTraslation.fallbackLocale,
        translations: MyTraslation(),
      ),
    );
  }
}

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var cantidad = 0;

  mostrarDatos() async {
    await DatabasePr.db.initDB();
    var abc = await DatabasePr.db.getAllConfigPersonal();
    cantidad = abc.length;

    if (cantidad == 0) {
      // providerServicios.requestSqlData();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginPage()));
      //PantallaInicio
    } else {
      /*  Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => Home_Asis()));*/

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Home_Asis()));
    }
  }

  //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No internet Connection:")));

  @override
  void initState() {
    //   _datdb.initDB();
    super.initState();
  }

  Future<int> getToken() async {
    await Future.delayed(const Duration(seconds: 3));
    //.then((value) =>;
    mostrarDatos();
    // var abc = await _datdb.getAllTasks();

    return cantidad;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      getToken();
    });
    return Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Iniciando... ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              CircularProgressIndicator(
                backgroundColor: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Home_Asis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return HomePagePais();
  }
}
