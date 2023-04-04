class EmbalajeControlLaboratorioSvModelo {
  int? id;
  String? nombreProducto;
  String? tipoCliente;
  String? tipoMuestra;
  String? conservacion;
  String? actividadOrigen;
  String? pesoMuestra;
  String? codigoMuestra;
  String? prediagnostico;
  String? analisis;
  String? descripcionSintomas;
  String? faseFenologica;
  int? controlF03Id;
  int? idTablet;

  EmbalajeControlLaboratorioSvModelo({
    this.id,
    this.nombreProducto,
    this.tipoCliente,
    this.tipoMuestra,
    this.conservacion,
    this.actividadOrigen,
    this.pesoMuestra,
    this.codigoMuestra,
    this.prediagnostico,
    this.analisis,
    this.descripcionSintomas,
    this.faseFenologica,
    this.controlF03Id,
    this.idTablet,
  });

  factory EmbalajeControlLaboratorioSvModelo.fromJson(
          Map<String, dynamic> json) =>
      EmbalajeControlLaboratorioSvModelo(
        id: json["id"],
        nombreProducto: json["nombre_producto"],
        tipoCliente: json["tipo_cliente"],
        tipoMuestra: json["tipo_muestra"],
        conservacion: json["conservacion"],
        actividadOrigen: json["actividad_origen"],
        pesoMuestra: json["peso_muestra"],
        codigoMuestra: json["codigo_muestra"],
        prediagnostico: json["prediagnostico"],
        analisis: json["analisis"],
        descripcionSintomas: json["descripcion_sintomas"],
        faseFenologica: json["fase_fenologica"],
        controlF03Id: json["control_f03_id"],
        idTablet: json["id_tablet"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre_producto": nombreProducto,
        "tipo_cliente": tipoCliente,
        "tipo_muestra": tipoMuestra,
        "conservacion": conservacion,
        "actividad_origen": actividadOrigen,
        "peso_muestra": pesoMuestra,
        "codigo_muestra": codigoMuestra,
        "prediagnostico": prediagnostico,
        "analisis": analisis,
        "descripcion_sintomas": descripcionSintomas,
        "fase_fenologica": faseFenologica,
        "control_f03_id": controlF03Id,
        "id_tablet": idTablet,
      };

  void limpiarModelo() {
    id = null;
    nombreProducto = null;
    tipoCliente = null;
    tipoMuestra = null;
    conservacion = null;
    actividadOrigen = null;
    pesoMuestra = null;
    codigoMuestra = null;
    prediagnostico = null;
    analisis = null;
    descripcionSintomas = null;
    faseFenologica = null;
    controlF03Id = null;
    idTablet = null;
  }

  @override
  String toString() {
    return '''EmbalajeControlLaboratorioSvModelo{
        id: $id,
        nombre_producto: $nombreProducto,
        tipo_cliente: $tipoCliente,
        tipo_muestra: $tipoMuestra,
        conservacion: $conservacion,
        actividad_origen: $actividadOrigen,
        peso_muestra: $pesoMuestra,
        codigo_muestra: $codigoMuestra,
        prediagnostico: $prediagnostico,
        analisis: $analisis
        descripcion_sintomas: $descripcionSintomas,
        fase_fenologica: $faseFenologica,
        control_f03_id: $controlF03Id,
        id_tablet: $idTablet
        }''';
  }
}
