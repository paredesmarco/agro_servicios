class RegistrosTransitoIngresoModelo {
  RegistrosTransitoIngresoModelo({
    this.idIngreso,
    this.nombreRazonSocial,
    this.rucCi,
    this.paisOrigen,
    this.paisProcedencia,
    this.paisDestino,
    this.puntoIngreso,
    this.puntoSalida,
    this.placaVehiculo,
    this.dda,
    this.precintosticker,
    this.fechaIngreso,
    this.formularioingresotransitoproductolist,
  });

  int? idIngreso;
  String? nombreRazonSocial;
  String? rucCi;
  String? paisOrigen;
  String? paisProcedencia;
  String? paisDestino;
  String? puntoIngreso;
  String? puntoSalida;
  String? placaVehiculo;
  String? dda;
  String? precintosticker;
  DateTime? fechaIngreso;
  List<IngresoTransitoProducto>? formularioingresotransitoproductolist;

  factory RegistrosTransitoIngresoModelo.fromJson(Map<String, dynamic> json) {
    // print(json["formularioingresotransitoproductolist"]);
    return RegistrosTransitoIngresoModelo(
      idIngreso: json["id_ingreso"],
      nombreRazonSocial: json["nombre_razon_social"],
      rucCi: json["ruc_ci"],
      paisOrigen: json["pais_origen"],
      paisProcedencia: json["pais_procedencia"],
      paisDestino: json["pais_destino"],
      puntoIngreso: json["punto_ingreso"],
      puntoSalida: json["punto_salida"],
      placaVehiculo: json["placa_vehiculo"],
      dda: json["dda"],
      precintosticker: json["precintosticker"],
      fechaIngreso: DateTime.parse(json["fecha_ingreso"]),
      formularioingresotransitoproductolist:
          json["formularioingresotransitoproductolist"] != null
              ? List<IngresoTransitoProducto>.from(
                  json["formularioingresotransitoproductolist"]
                      .map((x) => IngresoTransitoProducto.fromJson(x)))
              : [],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_ingreso": idIngreso,
        "nombre_razon_social": nombreRazonSocial,
        "ruc_ci": rucCi,
        "pais_origen": paisOrigen,
        "pais_procedencia": paisProcedencia,
        "pais_destino": paisDestino,
        "punto_ingreso": puntoIngreso,
        "punto_salida": puntoSalida,
        "placa_vehiculo": placaVehiculo,
        "dda": dda,
        "precintosticker": precintosticker,
        "fecha_ingreso": fechaIngreso?.toIso8601String(),
        "formularioingresotransitoproductolist": List<dynamic>.from(
            formularioingresotransitoproductolist!.map((x) => x.toJson())),
      };
}

class IngresoTransitoProducto {
  IngresoTransitoProducto({
    this.idProducto,
    this.partidaArancelaria,
    this.producto,
    this.cantidad,
    this.tipoEnvase,
    this.idPadre,
  });

  int? idProducto;
  String? partidaArancelaria;
  String? producto;
  double? cantidad;
  String? tipoEnvase;
  int? idPadre;

  factory IngresoTransitoProducto.fromJson(Map<String, dynamic> json) =>
      IngresoTransitoProducto(
        idProducto: json["id_producto"],
        partidaArancelaria: json["partida_arancelaria"],
        producto: json["producto"],
        cantidad: double.parse(json["cantidad"].toString()),
        tipoEnvase: json["tipo_envase"],
        idPadre: json["id_padre"],
      );

  Map<String, dynamic> toJson() => {
        "id_producto": idProducto,
        "partida_arancelaria": partidaArancelaria,
        "producto": producto,
        "cantidad": cantidad,
        "tipo_envase": tipoEnvase,
        "formulario_ingreso_transito_id_ingreso": idPadre
      };
}
