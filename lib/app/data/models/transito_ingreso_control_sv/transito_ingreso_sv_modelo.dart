class TransitoIngresoSvModelo {
  TransitoIngresoSvModelo({
    this.id,
    this.nombreRazonSocial,
    this.rucCi,
    this.idPaisOrigen,
    this.paisOrigen,
    this.idPaisProcedencia,
    this.paisProcedencia,
    this.idPaisDestino,
    this.paisDestino,
    this.idPuntoIngreso,
    this.puntoIngreso,
    this.idPuntoSalida,
    this.puntoSalida,
    this.placaVehiculo,
    this.dda,
    this.precintoSticker,
    this.usuarioIngreso,
    this.usuarioIdIngreso,
    this.fechaIngreso,
    this.idTablet,
    this.tabletVersionBaseIngreso,
  });

  int? id;
  String? nombreRazonSocial;
  String? rucCi;
  String? idPaisOrigen;
  String? paisOrigen;
  String? idPaisProcedencia;
  String? paisProcedencia;
  String? idPaisDestino;
  String? paisDestino;
  String? idPuntoIngreso;
  String? puntoIngreso;
  String? idPuntoSalida;
  String? puntoSalida;
  String? placaVehiculo;
  String? dda;
  String? precintoSticker;
  String? usuarioIngreso;
  String? usuarioIdIngreso;
  String? fechaIngreso;
  int? idTablet;
  String? tabletVersionBaseIngreso;

  factory TransitoIngresoSvModelo.fromJson(Map<String, dynamic> json) =>
      TransitoIngresoSvModelo(
        id: json["id"],
        nombreRazonSocial: json["nombre_razon_social"],
        rucCi: json["ruc_ci"],
        idPaisOrigen: json["id_pais_origen"],
        paisOrigen: json["pais_origen"],
        idPaisProcedencia: json["id_pais_procedencia"],
        paisProcedencia: json["pais_procedencia"],
        idPaisDestino: json["id_pais_destino"],
        paisDestino: json["pais_destino"],
        idPuntoIngreso: json["id_punto_ingreso"],
        puntoIngreso: json["punto_ingreso"],
        idPuntoSalida: json["id_punto_salida"],
        puntoSalida: json["punto_salida"],
        placaVehiculo: json["placa_vehiculo"],
        dda: json["dda"],
        precintoSticker: json["precinto_sticker"],
        usuarioIngreso: json["usuario_ingreso"],
        usuarioIdIngreso: json["usuario_id_ingreso"],
        fechaIngreso: json["fecha_ingreso"],
        idTablet: json["id_tablet"],
        tabletVersionBaseIngreso: json["tablet_version_base_ingreso"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_razon_social": nombreRazonSocial,
        "ruc_ci": rucCi,
        "id_pais_origen": idPaisOrigen,
        "pais_origen": paisOrigen,
        "id_pais_procedencia": idPaisProcedencia,
        "pais_procedencia": paisProcedencia,
        "id_pais_destino": idPaisDestino,
        "pais_destino": paisDestino,
        "id_punto_ingreso": idPuntoIngreso,
        "punto_ingreso": puntoIngreso,
        "id_punto_salida": idPuntoSalida,
        "punto_salida": puntoSalida,
        "placa_vehiculo": placaVehiculo,
        "dda": dda,
        "precinto_sticker": precintoSticker,
        "usuario_ingreso": usuarioIngreso,
        "usuario_id_ingreso": usuarioIdIngreso,
        "fecha_ingreso": fechaIngreso,
        "id_tablet": idTablet,
        "tablet_version_base_ingreso": tabletVersionBaseIngreso,
      };

  @override
  String toString() {
    return '''
     "id": id,
        nombre_razon_social: $nombreRazonSocial,
        ruc_ci: $rucCi,
        id_pais_origen: $idPaisOrigen,
        pais_origen: $paisOrigen,
        id_pais_procedencia: $idPaisProcedencia,
        pais_procedencia: $paisProcedencia,
        id_pais_destino: $idPaisDestino,
        pais_destino: $paisDestino,
        id_punto_ingreso: $idPuntoIngreso,
        punto_ingreso: $puntoIngreso,
        id_punto_salida: $idPuntoSalida,
        punto_salida: $puntoSalida,
        placa_vehiculo: $placaVehiculo,
        dda: $dda,
        precinto_sticker: $precintoSticker,
        usuario_ingreso: $usuarioIngreso,
        usuario_id_ingreso: $usuarioIdIngreso,
        fecha_ingreso: $fechaIngreso
        id_tablet: $idTablet,
        tablet_version_base_ingreso: $tabletVersionBaseIngreso,
        ''';
  }
}
