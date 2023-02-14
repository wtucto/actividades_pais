import 'package:actividades_pais/src/datamodels/Clases/Tambos/TamboServicioIntervencionesGeneral.dart';
import 'package:actividades_pais/src/datamodels/Provider/ProviderTambok.dart';
import 'package:actividades_pais/src/pages/Intervenciones/Listas/Listas.dart';
import 'package:actividades_pais/src/pages/Intervenciones/util/utils.dart';
import 'package:actividades_pais/src/pages/Tambook/historialTambo/fichaIntervencion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class intervencionesHistoria extends StatelessWidget {
  const intervencionesHistoria({Key? key}) : super(key: key);

  get isLoading => null;

  @override
  Widget build(BuildContext context) {
    Listas listas = Listas();
    final controller = ScrollController();
    return Scaffold(
      body: FutureBuilder<List<TamboServicioIntervencionesGeneral>>(
        future: ProviderTambok().listaTamboServicioIntervencionesGeneral(1, 10),
        builder: (BuildContext context,
            AsyncSnapshot<List<TamboServicioIntervencionesGeneral>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.hasData == false) {
              return const Center(
                child: Text("¡No existen registros"),
              );
            } else {
              final listaPersonalAux = snapshot.data;
              if (listaPersonalAux!.length == 0) {
                return const Center(
                  child: Text(
                    'No hay informacion',
                    style: TextStyle(fontSize: 19),
                  ),
                );
              } else {
                return Column(
                  children: [
                    Expanded(
                        child: Container(
                      child: RefreshIndicator(
                          onRefresh: resetlista,
                          child: ListView.builder(
                            controller: controller,
                            itemCount: listaPersonalAux.length,
                            itemBuilder: (context, i) =>
                                listas.cardHistrialTambosInter(
                              listaPersonalAux[i],
                              () async {
                                print("aquu");
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            FichaIntervencion(listaPersonalAux[i].idProgramacion!)));
                                /* await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetalleEquipoInformatico(
                                              listaPersonalAux[i]),
                                    ));*/
                              },
                            ),
                          )),
                    )),
                    if (isLoading == true)
                      new Center(
                        child: const CircularProgressIndicator(),
                      )
                  ],
                );
              }
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Widget buildSwipeActionRigth() => Container(
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text("Eliminar", style: TextStyle(color: Colors.red[600])),
          Icon(
            Icons.delete,
            color: Colors.red[600],
            size: 32,
          )
        ],
      ));

  Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: Colors.transparent,
      child: Row(
        children: [
          Text(
            "Editar",
            style: TextStyle(color: Colors.green[600]),
          ),
          Icon(
            Icons.edit,
            color: Colors.green[600],
            size: 32,
          )
        ],
      ));

  Future resetlista() async {
    /*   seleccionarMarca = "Seleccionar Marca";
    seleccionarModelo = "Seleccionar Modelo";
    seleccionarUbicacion = "Seleccionar Ubicacion";
    pageIndex = 1;
    filtroParqueInformatico.codigoPatrimonial = '';
    filtroParqueInformatico.denominacion = '';
    filtroParqueInformatico.idMarca = '';
    filtroParqueInformatico.idModelo = '';
    filtroParqueInformatico.idUbicacion = '';
    filtroParqueInformatico.responsableactual = '';
    filtroParqueInformatico.pageSize = 10;
    filtroParqueInformatico.pageIndex = pageIndex;
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      ProviderSeguimientoParqueInformatico()
          .listaParqueInformatico(filtroParqueInformatico);
    });*/
  }
}
