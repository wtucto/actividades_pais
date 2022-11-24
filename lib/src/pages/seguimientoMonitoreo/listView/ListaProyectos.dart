import 'package:actividades_pais/src/pages/seguimientoMonitoreo/detalleProyecto.dart';
import 'package:flutter/material.dart';
import 'package:actividades_pais/backend/controller/main_controller.dart';
import 'package:actividades_pais/backend/model/listar_trama_proyecto_model.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ListaProyectos extends StatelessWidget {
  ListaProyectos({
    Key? key,
    required this.context,
    required this.oProyecto,
  }) : super(key: key);

  final BuildContext context;
  final TramaProyectoModel oProyecto;

  final MainController mainController = MainController();

  @override
  Widget build(BuildContext context) {
    // String experienceLevelColor = '4495FF';
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetalleProyecto(datoProyecto: oProyecto),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.all(5),
        color: ((double.parse(oProyecto.avanceFisico.toString()) * 100) == 100
            ? Colors.blue.shade300
            : (double.parse(oProyecto.avanceFisico.toString()) * 100) >= 50
                ? Colors.green.shade300
                : (double.parse(oProyecto.avanceFisico.toString()) * 100) <= 30
                    ? Colors.red.shade300
                    : Colors.yellow.shade200),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), //<-- SEE HERE
        ),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerRight,
                                child: Container(
                                  child: Text(
                                    oProyecto.cui!,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 13, 0, 255),
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                oProyecto.tambo!,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                oProyecto.estado!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 37, 36, 36)),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${oProyecto.departamento!} / ${oProyecto.provincia!} / ${oProyecto.distrito!}",
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 37, 36, 36)),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                oProyecto.fechaTerminoEstimado!,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 37, 36, 36)),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width - 90,
                        lineHeight: 25.0,
                        animation: true,
                        animationDuration: 1000,
                        percent:
                            double.parse(oProyecto.avanceFisico.toString()),
                        center: Text(
                          "${((double.parse(oProyecto.avanceFisico.toString()) * 100).toStringAsFixed(2)).toString()}%",
                          style: const TextStyle(
                              fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                        progressColor: ((double.parse(
                                        oProyecto.avanceFisico.toString()) *
                                    100) ==
                                100
                            ? Colors.blue
                            : (double.parse(oProyecto.avanceFisico.toString()) *
                                        100) >=
                                    50
                                ? Colors.green
                                : (double.parse(oProyecto.avanceFisico
                                                .toString()) *
                                            100) <=
                                        30
                                    ? Colors.red
                                    : Colors.yellow),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
