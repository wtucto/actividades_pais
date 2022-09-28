
class ConsultarTambosPiasxUnidadTerritorial {
  Null? codResultado;
  Null? msgResultado;
  int? total;
  List<RspoTambosPiasxUnidadTerritorial>? response;
  Null? idPerfil;

  ConsultarTambosPiasxUnidadTerritorial(
      {this.codResultado,
        this.msgResultado,
        this.total,
        this.response,
        this.idPerfil});

  ConsultarTambosPiasxUnidadTerritorial.fromJson(Map<String, dynamic> json) {
    codResultado = json['codResultado'];
    msgResultado = json['msgResultado'];
    total = json['total'];
    if (json['response'] != null) {
      response = <RspoTambosPiasxUnidadTerritorial>[];
      json['response'].forEach((v) {
        response!.add(new RspoTambosPiasxUnidadTerritorial.fromJson(v));
      });
    }
    idPerfil = json['idPerfil'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codResultado'] = this.codResultado;
    data['msgResultado'] = this.msgResultado;
    data['total'] = this.total;
    if (this.response != null) {
      data['response'] = this.response!.map((v) => v.toJson()).toList();
    }
    data['idPerfil'] = this.idPerfil;
    return data;
  }
}

class RspoTambosPiasxUnidadTerritorial {
  int? idPlataforma;
  int? snip;
  String? ubigeoCcpp;
  String? ubigeoTambo;
  String? nombreDepartamento;
  String? nombreProvincia;
  String? nombreDistrito;
  String? nombreCcpp;
  String? nombreTambo;
  String? clasificacionPais;
  String? poblacionCcpp;
  String? viviendasCcpp;
  String? fuenteCcpp;
  String? prestaServicio;
  String? ambitoInfluencia;
  String? resolucionDirectorial;
  String? xCcpp;
  String? yCcpp;
  double? altitudCcpp;
  String? regionNatural;
  String? rangoRegionNatural;
  String? ubigeoCcppAnterior;
  String? ubigeoDistritoAnterior;
  String? provinciaAnterior;
  String? distritoAnterior;
  String? codCapita;
  String? capital;
  String? codCategoria;
  String? categoria;
  String? codArea;
  String? area;
  String? poblacionAnterior;
  String? viviendasAnterior;
  String? hogaresAnteriores;
  String? ubigeoCreadoUps;
  String? estadoAvanceAnterior;
  String? grupo504;
  String? grupo510;
  int? idDepartamento;
  String? unidadTerritorialDescripcion;
  String? modalidad;

  RspoTambosPiasxUnidadTerritorial(
      {this.idPlataforma,
        this.snip,
        this.ubigeoCcpp,
        this.ubigeoTambo,
        this.nombreDepartamento,
        this.nombreProvincia,
        this.nombreDistrito,
        this.nombreCcpp,
        this.nombreTambo,
        this.clasificacionPais,
        this.poblacionCcpp,
        this.viviendasCcpp,
        this.fuenteCcpp,
        this.prestaServicio,
        this.ambitoInfluencia,
        this.resolucionDirectorial,
        this.xCcpp,
        this.yCcpp,
        this.altitudCcpp,
        this.regionNatural,
        this.rangoRegionNatural,
        this.ubigeoCcppAnterior,
        this.ubigeoDistritoAnterior,
        this.provinciaAnterior,
        this.distritoAnterior,
        this.codCapita,
        this.capital,
        this.codCategoria,
        this.categoria,
        this.codArea,
        this.area,
        this.poblacionAnterior,
        this.viviendasAnterior,
        this.hogaresAnteriores,
        this.ubigeoCreadoUps,
        this.estadoAvanceAnterior,
        this.grupo504,
        this.grupo510,
        this.idDepartamento,
        this.unidadTerritorialDescripcion,
        this.modalidad,
      });

  RspoTambosPiasxUnidadTerritorial.fromJson(Map<String, dynamic> json) {
    idPlataforma = json['idPlataforma'];
    snip = json['snip'];
    ubigeoCcpp = json['ubigeoCcpp'];
    ubigeoTambo = json['ubigeoTambo'];
    nombreDepartamento = json['nombreDepartamento'];
    nombreProvincia = json['nombreProvincia'];
    nombreDistrito = json['nombreDistrito'];
    nombreCcpp = json['nombreCcpp'];
    nombreTambo = json['nombreTambo'];
    clasificacionPais = json['clasificacionPais'];
    poblacionCcpp = json['poblacionCcpp'];
    viviendasCcpp = json['viviendasCcpp'];
    fuenteCcpp = json['fuenteCcpp'];
    prestaServicio = json['prestaServicio'];
    ambitoInfluencia = json['ambitoInfluencia'];
    resolucionDirectorial = json['resolucionDirectorial'];
    xCcpp = json['xCcpp'];
    yCcpp = json['yCcpp'];
    altitudCcpp = json['altitudCcpp'];
    regionNatural = json['regionNatural'];
    rangoRegionNatural = json['rangoRegionNatural'];
    ubigeoCcppAnterior = json['ubigeoCcppAnterior'];
    ubigeoDistritoAnterior = json['ubigeoDistritoAnterior'];
    provinciaAnterior = json['provinciaAnterior'];
    distritoAnterior = json['distritoAnterior'];
    codCapita = json['codCapita'];
    capital = json['capital'];
    codCategoria = json['codCategoria'];
    categoria = json['categoria'];
    codArea = json['codArea'];
    area = json['area'];
    poblacionAnterior = json['poblacionAnterior'];
    viviendasAnterior = json['viviendasAnterior'];
    hogaresAnteriores = json['hogaresAnteriores'];
    ubigeoCreadoUps = json['ubigeoCreadoUps'];
    estadoAvanceAnterior = json['estadoAvanceAnterior'];
    grupo504 = json['grupo504'];
    grupo510 = json['grupo510'];
    idDepartamento = json['idDepartamento'];
    unidadTerritorialDescripcion = json['unidadTerritorialDescripcion'];
    modalidad = json['modalidad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idPlataforma'] = this.idPlataforma;
    data['snip'] = this.snip;
    data['ubigeoCcpp'] = this.ubigeoCcpp;
    data['ubigeoTambo'] = this.ubigeoTambo;
    data['nombreDepartamento'] = this.nombreDepartamento;
    data['nombreProvincia'] = this.nombreProvincia;
    data['nombreDistrito'] = this.nombreDistrito;
    data['nombreCcpp'] = this.nombreCcpp;
    data['nombreTambo'] = this.nombreTambo;
    data['clasificacionPais'] = this.clasificacionPais;
    data['poblacionCcpp'] = this.poblacionCcpp;
    data['viviendasCcpp'] = this.viviendasCcpp;
    data['fuenteCcpp'] = this.fuenteCcpp;
    data['prestaServicio'] = this.prestaServicio;
    data['ambitoInfluencia'] = this.ambitoInfluencia;
    data['resolucionDirectorial'] = this.resolucionDirectorial;
    data['xCcpp'] = this.xCcpp;
    data['yCcpp'] = this.yCcpp;
    data['altitudCcpp'] = this.altitudCcpp;
    data['regionNatural'] = this.regionNatural;
    data['rangoRegionNatural'] = this.rangoRegionNatural;
    data['ubigeoCcppAnterior'] = this.ubigeoCcppAnterior;
    data['ubigeoDistritoAnterior'] = this.ubigeoDistritoAnterior;
    data['provinciaAnterior'] = this.provinciaAnterior;
    data['distritoAnterior'] = this.distritoAnterior;
    data['codCapita'] = this.codCapita;
    data['capital'] = this.capital;
    data['codCategoria'] = this.codCategoria;
    data['categoria'] = this.categoria;
    data['codArea'] = this.codArea;
    data['area'] = this.area;
    data['poblacionAnterior'] = this.poblacionAnterior;
    data['viviendasAnterior'] = this.viviendasAnterior;
    data['hogaresAnteriores'] = this.hogaresAnteriores;
    data['ubigeoCreadoUps'] = this.ubigeoCreadoUps;
    data['estadoAvanceAnterior'] = this.estadoAvanceAnterior;
    data['grupo504'] = this.grupo504;
    data['grupo510'] = this.grupo510;
    data['idDepartamento'] = this.idDepartamento;
    data['unidadTerritorialDescripcion'] = this.unidadTerritorialDescripcion;
    data['modalidad'] = this.modalidad;
    return data;
  }
}