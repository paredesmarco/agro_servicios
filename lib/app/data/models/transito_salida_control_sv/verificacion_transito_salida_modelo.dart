class VerificacionTransitoSalidaModelo {
  VerificacionTransitoSalidaModelo({
    this.idIngreso,
    this.estadoPrecinto,
    this.tipoVerificacion,
    this.fechaSalida,
    this.usuarioSalida,
    this.usuarioIdSalida,
    this.tabletId,
    this.baseVersion,
  });

  int? idIngreso;
  String? estadoPrecinto;
  String? tipoVerificacion;
  String? fechaSalida;
  String? usuarioSalida;
  String? usuarioIdSalida;
  String? tabletId;
  String? baseVersion;

  factory VerificacionTransitoSalidaModelo.fromJson(
          Map<String, dynamic> json) =>
      VerificacionTransitoSalidaModelo(
        idIngreso: json["id_ingreso"],
        estadoPrecinto: json["estado_precinto"],
        tipoVerificacion: json["tipo_verificacion"],
        fechaSalida: json["fecha_salida"],
        usuarioSalida: json["usuario_salida"],
        usuarioIdSalida: json["usuario_id_salida"],
        tabletId: json["tablet_id_salida"],
        baseVersion: json["tablet_version_base_salida"],
      );

  Map<String, dynamic> toJson() => {
        "id_ingreso": idIngreso,
        "estado_precinto": estadoPrecinto,
        "tipo_verificacion": tipoVerificacion,
        "fecha_salida": fechaSalida,
        "usuario_salida": usuarioSalida,
        "usuario_id_salida": usuarioIdSalida,
        "tablet_id_salida": tabletId,
        "tablet_version_base_salida": baseVersion,
      };
}
