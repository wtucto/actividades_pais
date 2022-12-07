import 'package:flutter/material.dart';

class DetalleTambook extends StatefulWidget {
  @override
  _DetalleTambookState createState() => _DetalleTambookState();
}

class _DetalleTambookState extends State<DetalleTambook> {
  StepperType stepperType = StepperType.vertical;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("TAMBO"),
        ),
        // shape: const CustomAppBarShape(multi: 0.05),
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
                                                "¡BIENVENIDO A SOLEDAD!",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  letterSpacing: 0.0,
                                                ),
                                              ),
                                            ),
                                          ),

                                          Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(16.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.green
                                                        .withOpacity(0.5),
                                                    offset:
                                                        const Offset(1.1, 1.1),
                                                    blurRadius: 10.0),
                                              ],
                                            ),
                                            child: const Center(
                                              child: Text(
                                                'OPERATIVO',
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  letterSpacing: 0.0,
                                                  color: Color.fromARGB(
                                                      255, 255, 255, 255),
                                                ),
                                              ),
                                            ),
                                          ),
                                          DefaultTabController(
                                            length: 3, // length of tabs
                                            initialIndex: 0,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  child: const TabBar(
                                                    labelColor: Colors.blue,
                                                    isScrollable: true,
                                                    unselectedLabelColor:
                                                        Colors.black,
                                                    tabs: [
                                                      Tab(text: 'GESTOR'),
                                                      Tab(
                                                          text:
                                                              'INTERVENCIONES'),
                                                      Tab(text: 'UBICACIÓN'),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  height:
                                                      400, //height of TabBarView
                                                  decoration:
                                                      const BoxDecoration(
                                                          border: Border(
                                                              top: BorderSide(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: 0.5))),
                                                  child: TabBarView(
                                                    children: [
                                                      Container(
                                                        child: ListView(
                                                          children: [
                                                            buildCard(),
                                                            const SizedBox(
                                                                height: 10),
                                                            generales(),
                                                            const SizedBox(
                                                                height: 10),
                                                            card3(),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: ListView(
                                                          children: [
                                                            Intecard(),
                                                            const SizedBox(
                                                                height: 10),
                                                            Intecard1(),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: ListView(
                                                          children: [
                                                            Image.asset(
                                                              'assets/Tambook/mapa_tambo.jpg',
                                                              height: 400,
                                                              width: 400,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                          //detalle
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                                //Detalle Proyecto
                                // Padding(
                                //   padding: EdgeInsets.all(20),
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.stretch,
                                //     children: [
                                //       const SizedBox(height: 10),
                                //       buildCard(),
                                //       generales(),
                                //       card3(),
                                //     ],
                                //   ),
                                // ),
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
                      title: Text('ESTADO CIVIL'),
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

// Intervenciones
  Card Intecard() {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_drop_down_circle),
            title: const Text('QALIWARMA'),
            subtitle: Text(
              '10/11/2022',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'TALLER DE CAPACITACION, CONFORMACION DEL CAE Y ENTREGA DE ALIMENTOS, CON LA FINALIDAD DE DOTAR DE PRODUCTOS RICOS EN PROTEINAS, MINERALES Y VITAMINAS LA CUAL PERMITE COMBATIR LA ANEMIA Y LA DCI, REALIZADO POR EL MONITOR DE GESTION LOCAL DEL PN QALIWARMA',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Image.network(
              'https://www.pais.gob.pe/backendsismonitor/public/storage/programaciones-git/temp/TMOgbPC8JekToSulb2QsRUlQNDtYWbnzwCdauuGx.jpg'),
          ElevatedButton(
            child: Text('Descargar Ficha'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Card Intecard1() {
    return Card(
      margin: const EdgeInsets.all(5),
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.arrow_drop_down_circle),
            title: const Text(
                'SERVICIO NACIONAL DE AREAS NATURALES PROTEGIDAS (SERNANP)'),
            subtitle: Text(
              '08/11/2022',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Text(
              'TALLER DE CAPACITACION: EVALUACION DE PECES, ESTANDARIZACION DE ALIMENTOS,COSECHA, COMERCIALIZACION Y ACUERDOS DE COMPROMISO PARA LA CONTINUIDAD DE ACTIVIDADES PARA EL AÑO 2023, EN EL MARCO DE LA EJECUCION DEL PROYECTO “PRODUCCION DE ALEVINOS DE ESPECIES AMAZONICAS',
              style: TextStyle(color: Colors.black.withOpacity(0.6)),
            ),
          ),
          Image.network(
              'https://www.pais.gob.pe/backendsismonitor/public/storage/programaciones-git/temp/E842oA2wFbzX0wb8ZleAjAJ18z4JQAQ6jDapOsXe.jpg'),
          ElevatedButton(
            child: Text('Descargar Ficha'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
