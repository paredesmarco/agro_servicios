class SeguimientoCuarentenarioLaboratorioSvModelo {
  SeguimientoCuarentenarioLaboratorioSvModelo({
    this.id,
    this.idPadre,
    this.idTablet,
    this.actividadOrigen,
    this.analisis,
    this.aplicacionProductoQuimico,
    this.codigoMuestra,
    this.conservacion,
    this.tipoMuestra,
    this.descripcionSintomas,
    this.faseFenologica,
    this.nombreProducto,
    this.prediagnostico,
  });

  int? id;
  int? idPadre;
  int? idTablet;
  String? actividadOrigen;
  String? analisis;
  String? aplicacionProductoQuimico;
  String? codigoMuestra;
  String? conservacion;
  String? tipoMuestra;
  String? descripcionSintomas;
  String? faseFenologica;
  String? nombreProducto;
  String? prediagnostico;

  factory SeguimientoCuarentenarioLaboratorioSvModelo.fromJson(
          Map<String, dynamic> json) =>
      SeguimientoCuarentenarioLaboratorioSvModelo(
        id: json["id"],
        idPadre: json["id_padre"],
        idTablet: json["id_tablet"],
        actividadOrigen: json["actividad_origen"],
        analisis: json["analisis"],
        aplicacionProductoQuimico: json["aplicacion_producto_quimico"],
        codigoMuestra: json["codigo_muestra"],
        conservacion: json["conservacion"],
        tipoMuestra: json["tipo_muestra"],
        descripcionSintomas: json["descripcion_sintomas"],
        faseFenologica: json["fase_fenologica"],
        nombreProducto: json["nombre_producto"],
        prediagnostico: json["prediagnostico"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_padre": idPadre,
        "id_tablet": idTablet,
        "actividad_origen": actividadOrigen,
        "analisis": analisis,
        "aplicacion_producto_quimico": aplicacionProductoQuimico,
        "codigo_muestra": codigoMuestra,
        "conservacion": conservacion,
        "tipo_muestra": tipoMuestra,
        "descripcion_sintomas": descripcionSintomas,
        "fase_fenologica": faseFenologica,
        "nombre_producto": nombreProducto,
        "prediagnostico": prediagnostico,
      };

  @override
  String toString() {
    return ''' SeguimientoCuarentenarioLaboratorioSvModelo{
        id: $id,
        id_padre: $idPadre,
        id_tablet: $idTablet,
        actividad_origen: $actividadOrigen,
        analisis: $analisis,
        aplicacion_producto_quimico: $aplicacionProductoQuimico,
        codigo_muestra: $codigoMuestra,
        conservacion: $conservacion,
        tipo_muestra: $tipoMuestra,
        descripcion_sintomas: $descripcionSintomas,
        fase_fenologica: $faseFenologica,
        nombre_producto: $nombreProducto,
        prediagnostico: $prediagnostico,
        }
    ''';
  }
}
