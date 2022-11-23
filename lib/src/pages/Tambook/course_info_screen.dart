import 'package:flutter/material.dart';
import 'design_course_app_theme.dart';

class CourseInfoScreen extends StatefulWidget {
  @override
  _CourseInfoScreenState createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  int _currentStep = 0;
  StepperType stepperType = StepperType.vertical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("TAMBO"),
        ),
        shape: const CustomAppBarShape(multi: 0.05),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(
                Icons.home,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AspectRatio(
                                  aspectRatio: 1.2,
                                  child: Image.asset(
                                    'assets/design_course/fondo2.jpg',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                //DETALLE
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFFFFFF),
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(1.0),
                                        topRight: Radius.circular(1.0)),
                                    boxShadow: [
                                      BoxShadow(
                                          color: const Color(0xFF3A5160)
                                              .withOpacity(0.2),
                                          offset: const Offset(1.1, 1.1),
                                          blurRadius: 10.0),
                                    ],
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 15),
                                          Container(
                                            padding: const EdgeInsets.all(5),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(16.0),
                                              ),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "¡BIENVENIDO SOLEDAD!",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  letterSpacing: 0.0,
                                                ),
                                              ),
                                            ),
                                          ),

                                          //detalle
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                //Detalle Proyecto
                                Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const SizedBox(height: 10),
                                      buildCard(),
                                      generales(),
                                      card3(),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                      // child:
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Card buildCard() {
    var heading = 'NUESTRO GESTOR';
    var subheading = 'JULIO CESAR TAMINCHE LLAMO';
    var cardImage = NetworkImage(
        'https://www.pais.gob.pe/sismonitor/FILES/usuarios/6234/perfil/thumbnail/6234_200x200.jpg');

    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                heading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                subheading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
            Container(
              height: 200.0,
              child: Ink.image(
                image: cardImage,
                fit: BoxFit.fitHeight,
              ),
            ),
            Container(
              // padding: EdgeInsets.all(5.0),
              alignment: Alignment.centerLeft,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    ListTile(
                      title: Text('CARRERA'),
                      subtitle: Text('Ingeniería AgroindustrialL'),
                    ),
                    ListTile(
                      title: Text('GRADO'),
                      subtitle: Text('Colegiatura'),
                    ),
                    ListTile(
                      title: Text('SEXO'),
                      subtitle: Text('Masculino'),
                    ),
                    ListTile(
                      title: Text('STADO CIVIL'),
                      subtitle: Text('Soltero'),
                    ),
                    ListTile(
                      title: Text('FECHA DE NACIMIENTO'),
                      subtitle: Text('11-04-1988'),
                    ),
                    ListTile(
                      title: Text('EMAIL'),
                      subtitle: Text('jtaminche@pais.gob.pe'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Card generales() {
    var heading = 'DATOS GENERALES';
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                heading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
            Container(
              alignment: Alignment.centerLeft,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    ListTile(
                      title: Text('ATENCIONES'),
                      subtitle: Text('10.957'),
                    ),
                    ListTile(
                      title: Text('INTERVENCIONES'),
                      subtitle: Text('741'),
                    ),
                    ListTile(
                      title: Text('BENEFICIARIOS'),
                      subtitle: Text('2,184'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  Card card3() {
    var heading = 'JEFE DE UNIDAD TERRITORIAL';
    var subheading = "JOSE GREGORIO ARICA NECIOSUP";
    return Card(
        elevation: 4.0,
        child: Column(
          children: [
            ListTile(
              title: Text(
                heading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              subtitle: Text(
                subheading,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const Divider(color: Color.fromRGBO(61, 61, 61, 1)),
            Container(
              alignment: Alignment.centerLeft,
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    ListTile(
                      title: Text('TÉLEFONO'),
                      subtitle: Text('978997614'),
                    ),
                    ListTile(
                      title: Text('EMAIL'),
                      subtitle: Text('jarica@pais.gob.pe'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
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
