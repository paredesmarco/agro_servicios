class OrdenTrabajoLaboratorioModelo {
  OrdenTrabajoLaboratorioModelo(
      {this.idTablet,
      this.actividadOrigen,
      this.analisis,
      this.codigoMuestra,
      this.conservacion,
      this.tipoMuestra,
      this.descripcionSintomas,
      this.faseFenologica,
      this.nombreProducto,
      this.pesoMuestra,
      this.prediagnostico,
      this.tipoCliente,
      this.aplicacionProductoQuimico,
      this.codigoTrampa,
      this.idPadre});

  int? idTablet;
  String? actividadOrigen;
  String? analisis;
  String? codigoMuestra;
  String? conservacion;
  String? tipoMuestra;
  String? descripcionSintomas;
  String? faseFenologica;
  String? nombreProducto;
  int? pesoMuestra;
  String? prediagnostico;
  String? tipoCliente;
  String? aplicacionProductoQuimico;
  String? codigoTrampa;
  int? idPadre;

  factory OrdenTrabajoLaboratorioModelo.fromJson(Map<String, dynamic> json) =>
      OrdenTrabajoLaboratorioModelo(
          idTablet: json["id_tablet"],
          actividadOrigen: json["actividad_origen"],
          analisis: json["analisis"],
          codigoMuestra: json["codigo_muestra"],
          conservacion: json["conservacion"],
          tipoMuestra: json["tipo_muestra"],
          descripcionSintomas: json["descripcion_sintomas"],
          faseFenologica: json["fase_fenologica"],
          nombreProducto: json["nombre_producto"],
          pesoMuestra: json["peso_muestra"],
          prediagnostico: json["prediagnostico"],
          tipoCliente: json["tipo_cliente"],
          aplicacionProductoQuimico: json["aplicacion_producto_quimico"],
          codigoTrampa: json["codigo_trampa"],
          idPadre: json["id_padre"]);

  Map<String, dynamic> toJson() => {
        "id_tablet": idTablet,
        "actividad_origen": actividadOrigen,
        "analisis": analisis,
        "codigo_muestra": codigoMuestra,
        "conservacion": conservacion,
        "tipo_muestra": tipoMuestra,
        "descripcion_sintomas": descripcionSintomas,
        "fase_fenologica": faseFenologica,
        "nombre_producto": nombreProducto,
        "peso_muestra": pesoMuestra,
        "prediagnostico": prediagnostico,
        "tipo_cliente": tipoCliente,
        "aplicacion_producto_quimico": aplicacionProductoQuimico,
        "codigo_trampa": codigoTrampa,
        "id_padre": idPadre,
      };

  @override
  String toString() {
    return ''' OrdenTrabajoLaboratorioModelo {
    id_tablet: $idTablet,
    actividad_origen: $actividadOrigen,
    analisis: $analisis,
    codigo_muestra: $codigoMuestra,
    conservacion: $conservacion,
    tipo_muestra: $tipoMuestra,
    descripcion_sintomas: $descripcionSintomas,
    fase_fenologica: $faseFenologica,
    nombre_producto: $nombreProducto,
    peso_muestra: $pesoMuestra,
    prediagnostico: $prediagnostico,
    tipo_cliente: $tipoCliente,
    aplicacion_producto_quimico: $aplicacionProductoQuimico,
    codigo_trampa: $codigoTrampa,
    id_padre: $idPadre,
    }''';
  }
}
