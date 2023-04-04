class MuestreoMfSvLaboratorioModeo {
  MuestreoMfSvLaboratorioModeo({
    this.id,
    this.idTablet,
    this.aplicacionProductoQuimico,
    this.codigoMuestra,
    this.descripcionSintomas,
    this.especieVegetal,
    this.sitioMuestreo,
    this.numeroFrutosColectados,
    this.idMuestreo,
  });

  int? id;
  int? idPadre;
  int? idTablet;
  String? aplicacionProductoQuimico;
  String? codigoMuestra;
  String? descripcionSintomas;
  String? especieVegetal;
  String? sitioMuestreo;
  String? numeroFrutosColectados;
  int? idMuestreo;

  factory MuestreoMfSvLaboratorioModeo.fromJson(Map<String, dynamic> json) =>
      MuestreoMfSvLaboratorioModeo(
        id: json["id"],
        idTablet: json["id_tablet"],
        aplicacionProductoQuimico: json["aplicacion_producto_quimico"],
        codigoMuestra: json["codigo_muestra"],
        descripcionSintomas: json["descripcion_sintomas"],
        especieVegetal: json["especie_vegetal"],
        sitioMuestreo: json["sitio_muestreo"],
        numeroFrutosColectados: json["numero_frutos_colectados"],
        idMuestreo: json["id_muestreo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tablet": idTablet,
        "aplicacion_producto_quimico": aplicacionProductoQuimico,
        "codigo_muestra": codigoMuestra,
        "descripcion_sintomas": descripcionSintomas,
        "especie_vegetal": especieVegetal,
        "sitio_muestreo": sitioMuestreo,
        "numero_frutos_colectados": numeroFrutosColectados,
        "id_muestreo": idMuestreo
      };
}
