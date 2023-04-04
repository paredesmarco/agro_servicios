class SeguimientoCuarentenarioSolicitudSvModelo {
  SeguimientoCuarentenarioSolicitudSvModelo({
    this.id,
    this.idSeguimientoCuarentenario,
    this.identificadorOperador,
    this.razonSocial,
    this.numeroSeguimientosPlanificados,
    this.numeroPlantasIngreso,
    this.idPaisOrigen,
    this.paisOrigen,
    this.idVue,
    this.solicitudProductos,
    this.solicitudAreasCuarentena,
  });
  int? id;
  int? idSeguimientoCuarentenario;
  String? identificadorOperador;
  String? razonSocial;
  int? numeroSeguimientosPlanificados;
  int? numeroPlantasIngreso;
  int? idPaisOrigen;
  String? paisOrigen;
  String? idVue;
  List<SeguimientoCuarentenarioProductoSvModelo>? solicitudProductos;
  List<SeguimientoCuarentenarioAreaCuarentenaSvModelo>?
      solicitudAreasCuarentena;

  factory SeguimientoCuarentenarioSolicitudSvModelo.fromJson(
      Map<String, dynamic> json) {
    return SeguimientoCuarentenarioSolicitudSvModelo(
      id: json["id"],
      idSeguimientoCuarentenario: json["id_seguimiento_cuarentenario"],
      identificadorOperador: json["identificador_operador"],
      razonSocial: json["razon_social"],
      numeroSeguimientosPlanificados: json["numero_seguimientos_planificados"],
      numeroPlantasIngreso: json["numero_plantas_ingreso"],
      idPaisOrigen: json["id_pais_origen"],
      paisOrigen: json["pais_origen"],
      idVue: json["id_vue"],
      solicitudProductos: json["solicitud_productos"] != null
          ? List<SeguimientoCuarentenarioProductoSvModelo>.from(
              json["solicitud_productos"].map(
                  (x) => SeguimientoCuarentenarioProductoSvModelo.fromJson(x)))
          : [],
      solicitudAreasCuarentena: json["areas_cuarentena"] != null
          ? List<SeguimientoCuarentenarioAreaCuarentenaSvModelo>.from(
              json["areas_cuarentena"].map((x) =>
                  SeguimientoCuarentenarioAreaCuarentenaSvModelo.fromJson(x)))
          : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_seguimiento_cuarentenario": idSeguimientoCuarentenario,
        "identificador_operador": identificadorOperador,
        "razon_social": razonSocial,
        "numero_seguimientos_planificados": numeroSeguimientosPlanificados,
        "numero_plantas_ingreso": numeroPlantasIngreso,
        "id_pais_origen": idPaisOrigen,
        "pais_origen": paisOrigen,
        "id_vue": idVue,
        "solicitud_productos":
            List<dynamic>.from(solicitudProductos!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return '''
        id_seguimiento_cuarentenario: $idSeguimientoCuarentenario,
        identificador_operador: $identificadorOperador,
        razon_social: $razonSocial,
        numero_seguimientos_planificados: $numeroSeguimientosPlanificados,
        numero_plantas_ingreso: $numeroPlantasIngreso,
        id_pais_origen: $idPaisOrigen,
        pais_origen: $paisOrigen,
        id_vue: $idVue,
    ''';
  }
}

class SeguimientoCuarentenarioProductoSvModelo {
  SeguimientoCuarentenarioProductoSvModelo({
    this.idProducto,
    this.producto,
    this.peso,
    this.unidad,
    this.subtipo,
    this.idSolicitud,
  });

  int? idProducto;
  String? producto;
  String? peso;
  String? unidad;
  String? subtipo;
  int? idSolicitud;

  factory SeguimientoCuarentenarioProductoSvModelo.fromJson(
          Map<String, dynamic> json) =>
      SeguimientoCuarentenarioProductoSvModelo(
        idProducto: json["id_producto"],
        producto: json["producto"],
        peso: json["peso"].toString(),
        unidad: json["unidad"],
        subtipo: json["subtipo"],
        idSolicitud: json['id_solicitud'],
      );

  Map<String, dynamic> toJson() => {
        "id_producto": idProducto,
        "producto": producto,
        "peso": peso,
        "unidad": unidad,
        "subtipo": subtipo,
        "id_solicitud": idSolicitud,
      };
}

class SeguimientoCuarentenarioAreaCuarentenaSvModelo {
  SeguimientoCuarentenarioAreaCuarentenaSvModelo({
    required this.idGuia,
    this.nombreArea,
    this.tipoArea,
    this.identificadorOperador,
    this.nombreLugar,
    this.codigoArea,
  });
  int idGuia;
  String? nombreArea;
  String? tipoArea;
  String? identificadorOperador;
  String? nombreLugar;
  String? codigoArea;

  factory SeguimientoCuarentenarioAreaCuarentenaSvModelo.fromJson(
          Map<String, dynamic> json) =>
      SeguimientoCuarentenarioAreaCuarentenaSvModelo(
        idGuia: json["id_guia"],
        nombreArea: json["nombre_area"],
        tipoArea: json["tipo_area"],
        identificadorOperador: json["identificador_operador"],
        nombreLugar: json["nombre_lugar"],
        codigoArea: json["codigo_area"],
      );

  Map<String, dynamic> toJson() => {
        "id_guia": idGuia,
        "nombre_area": nombreArea,
        "tipo_area": tipoArea,
        "identificador_operador": identificadorOperador,
        "nombre_lugar": nombreLugar,
        "codigo_area": codigoArea,
      };

  @override
  String toString() {
    return ''' SeguimientoCuarentenarioAreaCuarentenaSvModelo{
        nombre_area: $nombreArea,
        tipo_area: $tipoArea,
        identificador_operador: $identificadorOperador,
        nombre_lugar: $nombreLugar,
        codigo_area: $codigoArea
     }''';
  }
}
