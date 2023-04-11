class RegistroInformacionModelo {
  RegistroInformacionModelo(
      {this.programa,
      this.fechaMuestra,
      this.codigoMuestraCam,
      this.nombreMuestra,
      this.idProvincia,
      this.provincia,
      this.idCanton,
      this.canton,
      this.idParroquia,
      this.parroquia,
      this.origenMuestra,
      this.nombreSitio,
      this.codigoCentroFaenamiento,
      this.certificadoZoosanitaria,
      this.nombreRepresentanteLeg,
      this.paisProcedencia,
      this.numeroPermisoFitosanitario,
      this.razonSocialExportador,
      this.tipoMuestra,
      this.numeroQuipux,
      this.codigoMuestraLab,
      required this.fechaEmision,
      required this.fechaRecepcion,
      this.referencia,
      this.accionesTomadas,
      this.observaciones,
      this.imagenes});

  String? programa;
  DateTime? fechaMuestra;
  String? codigoMuestraCam;
  String? nombreMuestra;
  int? idProvincia;
  String? provincia;
  int? idCanton;
  String? canton;
  int? idParroquia;
  String? parroquia;
  String? origenMuestra;
  String? nombreSitio;
  String? codigoCentroFaenamiento;
  String? certificadoZoosanitaria;
  String? nombreRepresentanteLeg;
  String? paisProcedencia;
  String? numeroPermisoFitosanitario;
  String? razonSocialExportador;
  String? tipoMuestra;
  String? numeroQuipux;
  String? codigoMuestraLab;
  DateTime fechaRecepcion;
  DateTime fechaEmision;
  String? referencia;
  String? accionesTomadas;
  String? observaciones;
  String? imagenes;
}
