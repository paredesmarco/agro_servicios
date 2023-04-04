class InspeccionProductosImportadosModelo {
  InspeccionProductosImportadosModelo({
    this.id,
    this.pfi,
    this.dda,
    this.pregunta01,
    this.pregunta02,
    this.pregunta03,
    this.pregunta04,
    this.pregunta05,
    this.pregunta06,
    this.pregunta07,
    this.pregunta08,
    this.pregunta09,
    this.pregunta10,
    this.pregunta11,
    this.categoriaRiesgo,
    this.seguimientoCuarentenario,
    this.provincia,
    this.pesoIngreso,
    this.envioMuestra,
    this.observaciones,
    this.dictamenFinal,
    this.numeroEmbalajesEnvio,
    this.numeroEmbalajesInspeccionados,
    this.usuario,
    this.usuarioId,
    this.fechaCreacion,
  });

  int? id;
  String? pfi;
  String? dda;
  String? pregunta01;
  String? pregunta02;
  String? pregunta03;
  String? pregunta04;
  String? pregunta05;
  String? pregunta06;
  String? pregunta07;
  String? pregunta08;
  int? pregunta09;
  int? pregunta10;
  String? pregunta11;
  String? categoriaRiesgo;
  String? seguimientoCuarentenario;
  String? provincia;
  String? pesoIngreso;
  String? envioMuestra;
  String? observaciones;
  String? dictamenFinal;
  int? numeroEmbalajesEnvio;
  int? numeroEmbalajesInspeccionados;
  String? usuario;
  String? usuarioId;
  String? fechaCreacion;
  int? idTablet;
  String? tabletId;
  String? tabletVersion;

  factory InspeccionProductosImportadosModelo.fromJson(
          Map<String, dynamic> json) =>
      InspeccionProductosImportadosModelo(
        id: json["id"],
        pfi: json["pfi"],
        dda: json["dda"],
        pregunta01: json["pregunta01"],
        pregunta02: json["pregunta02"],
        pregunta03: json["pregunta03"],
        pregunta04: json["pregunta04"],
        pregunta05: json["pregunta05"],
        pregunta06: json["pregunta06"],
        pregunta07: json["pregunta07"],
        pregunta08: json["pregunta08"],
        pregunta09: json["pregunta09"],
        pregunta10: json["pregunta10"],
        pregunta11: json["pregunta11"],
        categoriaRiesgo: json["categoria_riesgo"],
        seguimientoCuarentenario: json["seguimiento_cuarentenario"],
        provincia: json["provincia"],
        pesoIngreso: json["peso_ingreso"],
        envioMuestra: json["envio_muestra"],
        observaciones: json["observaciones"],
        dictamenFinal: json["dictamen_final"],
        numeroEmbalajesEnvio: json["numero_embalajes_envio"],
        numeroEmbalajesInspeccionados: json["numero_embalajes_inspeccionados"],
        usuario: json["usuario"],
        usuarioId: json["usuario_id"],
        fechaCreacion: json["fecha_creacion"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pfi": pfi,
        "dda": dda,
        "pregunta01": pregunta01,
        "pregunta02": pregunta02,
        "pregunta03": pregunta03,
        "pregunta04": pregunta04,
        "pregunta05": pregunta05,
        "pregunta06": pregunta06,
        "pregunta07": pregunta07,
        "pregunta08": pregunta08,
        "pregunta09": pregunta09,
        "pregunta10": pregunta10,
        "pregunta11": pregunta11,
        "categoria_riesgo": categoriaRiesgo,
        "seguimiento_cuarentenario": seguimientoCuarentenario,
        "provincia": provincia,
        "peso_ingreso": pesoIngreso,
        "envio_muestra": envioMuestra,
        "observaciones": observaciones,
        "dictamen_final": dictamenFinal,
        "numero_embalajes_envio": numeroEmbalajesEnvio,
        "numero_embalajes_inspeccionados": numeroEmbalajesInspeccionados,
        "usuario": usuario,
        "usuario_id": usuarioId,
        "fecha_creacion": fechaCreacion,
        "id_tablet": idTablet,
        "tablet_id": tabletId,
        "tablet_version": tabletVersion,
      };

  Map<String, dynamic> toMap() => {
        "id": id,
        "pfi": pfi,
        "dda": dda,
        "pregunta01": pregunta01,
        "pregunta02": pregunta02,
        "pregunta03": pregunta03,
        "pregunta04": pregunta04,
        "pregunta05": pregunta05,
        "pregunta06": pregunta06,
        "pregunta07": pregunta07,
        "pregunta08": pregunta08,
        "pregunta09": pregunta09,
        "pregunta10": pregunta10,
        "pregunta11": pregunta11,
        "categoria_riesgo": categoriaRiesgo,
        "seguimiento_cuarentenario": seguimientoCuarentenario,
        "provincia": provincia,
        "peso_ingreso": pesoIngreso,
        "envio_muestra": envioMuestra,
        "observaciones": observaciones,
        "dictamen_final": dictamenFinal,
        "numero_embalajes_envio": numeroEmbalajesEnvio,
        "numero_embalajes_inspeccionados": numeroEmbalajesInspeccionados,
        "usuario": usuario,
        "usuario_id": usuarioId,
        // "fecha_creacion": fechaCreacion,
        // "id_tablet": idTablet,
        // "tablet_id": tabletId,
        // "tablet_version": tabletVersion,
      };

  @override
  String toString() {
    return '''{
        id: $id,
        pfi: $pfi,
        dda: $dda,
        pregunta01: $pregunta01,
        pregunta02: $pregunta02,
        pregunta03: $pregunta03,
        pregunta04: $pregunta04,
        pregunta05: $pregunta05,
        pregunta06: $pregunta06,
        pregunta07: $pregunta07,
        pregunta08: $pregunta08,
        pregunta09: $pregunta09,
        pregunta10: $pregunta10,
        pregunta11: $pregunta11,
        categoria_riesgo: $categoriaRiesgo,
        seguimiento_cuarentenario: $seguimientoCuarentenario,
        provincia: $provincia,
        peso_ingreso: $pesoIngreso,
        envio_muestra: $envioMuestra,
        observaciones: $observaciones,
        dictamen_final: $dictamenFinal,
        numero_embalajes_envio: $numeroEmbalajesEnvio,
        numero_embalajes_inspeccionados: $numeroEmbalajesInspeccionados,
        usuario: $usuario,
        usuario_id: $usuarioId,
        fecha_creacion: $fechaCreacion,
        id_tablet: $idTablet,
        tablet_id: $tabletId,
        tablet_version: $tabletVersion,
    }
     ''';
  }
}
