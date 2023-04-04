class ProductosImportadosOrdenModelo {
  ProductosImportadosOrdenModelo({
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
    this.controlF01Id,
  });

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
  int? controlF01Id;
  int? idTablet;

  factory ProductosImportadosOrdenModelo.fromJson(Map<String, dynamic> json) =>
      ProductosImportadosOrdenModelo(
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
        controlF01Id: json["control_f01_id"],
      );

  Map<String, dynamic> toJson() => {
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
        "control_f01_id": controlF01Id,
        "id_tablet": idTablet,
      };
}
