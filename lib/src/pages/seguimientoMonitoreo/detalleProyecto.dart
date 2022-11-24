import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:get/get.dart';

class DetalleProyecto extends StatefulWidget {
  const DetalleProyecto({super.key, required this.datoProyecto});
  final TramaProyectoModel datoProyecto;
  @override
  State<DetalleProyecto> createState() => _DetalleProyectoState();
}

class _DetalleProyectoState extends State<DetalleProyecto>
    with TickerProviderStateMixin {
  late TramaProyectoModel _oProject;

  late final _numSnip;
  late final _cui;
  late final _latitud;
  late final _longitud;
  late final _departamento;
  late final _provincia;
  late final _distrito;
  late final _tambo;
  late final _centroPoblado;
  late final _estado;
  late final _subEstado;
  late final _estadoSaneamiento;
  late final _modalidad;
  late final _fechaInicio;
  late final _fechaTerminoEstimado;
  late final _inversion;
  late final _costoEjecutado;
  late final _costoEstimadoFinal;
  late final _avanceFisico;
  late final _residente;
  late final _supervisor;
  late final _crp;
  late final _codResidente;
  late final _codSupervisor;
  late final _codCrp;
  final double infoHeight = 364.0;
  AnimationController? animationController;
  Animation<double>? animation;
  double opacity1 = 0.0;
  double opacity2 = 0.0;
  double opacity3 = 0.0;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: animationController!,
        curve: Interval(0, 1.0, curve: Curves.fastOutSlowIn)));
    setData();
    _oProject = widget.datoProyecto;
    _numSnip = TextEditingController(text: _oProject.numSnip);
    _cui = TextEditingController(text: _oProject.cui);
    _latitud = TextEditingController(text: _oProject.latitud);
    _longitud = TextEditingController(text: _oProject.longitud);
    _departamento = TextEditingController(text: _oProject.departamento);
    _provincia = TextEditingController(text: _oProject.provincia);
    _distrito = TextEditingController(text: _oProject.distrito);
    _tambo = TextEditingController(text: _oProject.tambo);
    _centroPoblado = TextEditingController(text: _oProject.centroPoblado);
    _estado = TextEditingController(text: _oProject.estado);
    _subEstado = TextEditingController(text: _oProject.subEstado);
    _estadoSaneamiento =
        TextEditingController(text: _oProject.estadoSaneamiento);
    _modalidad = TextEditingController(text: _oProject.modalidad);
    _fechaInicio = TextEditingController(text: _oProject.fechaInicio);
    _fechaTerminoEstimado =
        TextEditingController(text: _oProject.fechaTerminoEstimado);
    _inversion = TextEditingController(text: _oProject.inversion);
    _costoEjecutado = TextEditingController(text: _oProject.costoEjecutado);
    _costoEstimadoFinal =
        TextEditingController(text: _oProject.costoEstimadoFinal);
    _avanceFisico =
        TextEditingController(text: (_oProject.avanceFisico).toString());
    _residente = TextEditingController(text: _oProject.residente);
    _supervisor = TextEditingController(text: _oProject.supervisor);
    _crp = TextEditingController(text: _oProject.crp);
    _codResidente = TextEditingController(text: _oProject.codResidente);
    _codSupervisor = TextEditingController(text: _oProject.codSupervisor);
    _codCrp = TextEditingController(text: _oProject.codCrp);
    super.initState();
  }

  Future<void> setData() async {
    animationController?.forward();
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity1 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity2 = 1.0;
    });
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    setState(() {
      opacity3 = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double tempHeight = MediaQuery.of(context).size.height -
        (MediaQuery.of(context).size.width / 1.2) +
        24.0;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.datoProyecto.tambo!),
        ),
        shape: const CustomAppBarShape(multi: 0.05),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              iconSize: 30,
              onPressed: () {},
              icon: const Icon(
                Icons.monitor,
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
                                CarouselSlider(
                                  items: [
                                    Container(
                                      margin: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://www.pais.gob.pe/backendsismonitor/public/storage/programaciones-git/temp/4Lfp9n78LrRQqc8rOQ246sWlRa2I5pCjtAEDBA9r.JPG"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://portal.andina.pe/EDPfotografia3/Thumbnail/2016/06/27/000363320W.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        image: const DecorationImage(
                                          image: NetworkImage(
                                              "https://www.pais.gob.pe/backendsismonitor/public/storage/programaciones-git/temp/Gfp7ZihgLWrYbc9BqY0cnDGC2zXdhpftyaXQUX0D.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                                  options: CarouselOptions(
                                    // height: 380.0,
                                    enlargeCenterPage: true,
                                    autoPlay: true,
                                    aspectRatio: 16 / 9,
                                    autoPlayCurve: Curves.fastOutSlowIn,
                                    enableInfiniteScroll: true,
                                    autoPlayAnimationDuration:
                                        const Duration(milliseconds: 1000),
                                    viewportFraction: 0.8,
                                  ),
                                ),
                                // AspectRatio(
                                //   aspectRatio: 1.2,
                                //   child: Image.network(
                                //     '',
                                //     fit: BoxFit.fill,
                                //   ),
                                // ),
                                //Detalle imagen
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
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                              color: Color(0xFF00B6F0),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(16.0),
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Color(0xFF00B6F0)
                                                        .withOpacity(0.5),
                                                    offset:
                                                        const Offset(1.1, 1.1),
                                                    blurRadius: 10.0),
                                              ],
                                            ),
                                            child: Center(
                                              child: Text(
                                                widget.datoProyecto.estado!,
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 18,
                                                  letterSpacing: 0.0,
                                                  color: Color(0xFFFFFFFF),
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),

                                          Text(
                                            widget.datoProyecto.tambo!,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 22,
                                              letterSpacing: 0.27,
                                              color: Color(0xFF17262A),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Container(
                                            child: Text(
                                              "${widget.datoProyecto.departamento!} / ${widget.datoProyecto.provincia!} / ${widget.datoProyecto.distrito!}",
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: Color.fromARGB(
                                                    255, 13, 0, 255),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Container(
                                            child: Text(
                                              widget.datoProyecto.cui!,
                                              textAlign: TextAlign.left,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: Color.fromARGB(
                                                    255, 13, 0, 255),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 15),
                                          Container(
                                            child: ScaleTransition(
                                              alignment: Alignment.center,
                                              scale: CurvedAnimation(
                                                  parent: animationController!,
                                                  curve: Curves.fastOutSlowIn),
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(1.0),
                                                  child:
                                                      CircularPercentIndicator(
                                                    radius: 40.0,
                                                    lineWidth: 15.0,
                                                    percent: double.parse(widget
                                                        .datoProyecto
                                                        .avanceFisico
                                                        .toString()),
                                                    center: Text(
                                                      "${((double.parse(widget.datoProyecto.avanceFisico.toString()) * 100).toStringAsFixed(2)).toString()}%",
                                                      style: const TextStyle(
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    progressColor: ((double.parse(widget
                                                                    .datoProyecto
                                                                    .avanceFisico
                                                                    .toString()) *
                                                                100) ==
                                                            100
                                                        ? Colors.blue
                                                        : (double.parse(widget
                                                                        .datoProyecto
                                                                        .avanceFisico
                                                                        .toString()) *
                                                                    100) >=
                                                                50
                                                            ? Colors.green
                                                            : (double.parse(widget
                                                                            .datoProyecto
                                                                            .avanceFisico
                                                                            .toString()) *
                                                                        100) <=
                                                                    30
                                                                ? Colors.red
                                                                : Colors
                                                                    .yellow),
                                                  ),
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
                                      Text(
                                        'FldProyect002'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _numSnip,

                                        ///CÓDIGO DE SNIP
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect011'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _subEstado,

                                        ///SUB ESTADO DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect012'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _estadoSaneamiento,

                                        ///ESTADO DE SANEAMIENTO DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect013'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _modalidad,

                                        ///MODALIDAD DE CONTRATACIÓN DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect014'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _fechaInicio,

                                        ///FECHA DE INICIO DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect015'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _fechaTerminoEstimado,

                                        ///FECHA DE TÉRMINO ESTIMADO DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect016'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _inversion,

                                        ///MONTO DE INVERSIÓN DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect017'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _costoEjecutado,

                                        ///COSTO EJECUTADO ACUMULADO DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect018'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _costoEstimadoFinal,

                                        ///COSTO ESTIMADO FINAL DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect020'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _residente,

                                        ///NOMBRE DEL RESIDENTE
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect021'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _supervisor,

                                        ///NOMBRE DEL SUPERVISOR
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect022'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _crp,

                                        ///NOMBRE DEL COORDINADOR REGIONAL DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect023'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _codResidente,

                                        ///CÓDIGO DEL RESIDENTE
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect024'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _codSupervisor,

                                        ///CÓDIGO DEL SUPERVISOR
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect025'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _codCrp,

                                        ///CÓDIGO DEL COORDINADOR REGIONAL DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect003'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _latitud,

                                        ///LATITUD DE LA UBICACIÓN DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'FldProyect004'.tr,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextFormField(
                                        controller: _longitud,

                                        ///LONGITUD DE LA UBICACIÓN DEL PROYECTO
                                        validator: (v) =>
                                            v!.isEmpty ? 'Required'.tr : null,
                                        enabled: false,
                                      ),
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
}

class MyListTitle extends StatelessWidget {
  const MyListTitle({
    Key? key,
    required this.widget,
    required this.label,
    required this.valor,
  }) : super(key: key);

  final DetalleProyecto widget;
  final String label;
  final String valor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.check, size: 50),
      title: Text(
        label,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Text(
        valor,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
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
