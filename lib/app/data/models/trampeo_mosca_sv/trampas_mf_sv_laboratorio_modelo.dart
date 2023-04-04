class TrampasMfSvLaboratorioModelo {
  TrampasMfSvLaboratorioModelo({
    this.id,
    this.idPadre,
    this.idTablet,
    this.codigoMuestra,
    this.tipoMuestra,
    this.analisis,
    this.codigoTrampaPadre,
    this.secuencial,
  });

  int? id;
  int? idPadre;
  int? idTablet;
  String? codigoMuestra;
  String? tipoMuestra;
  String? analisis;
  String? codigoTrampaPadre;
  int? secuencial;

  factory TrampasMfSvLaboratorioModelo.fromJson(Map<String, dynamic> json) =>
      TrampasMfSvLaboratorioModelo(
        id: json["id"],
        idPadre: json["id_padre"],
        idTablet: json["id_tablet"],
        codigoMuestra: json["codigo_muestra"],
        tipoMuestra: json["tipo_muestra"],
        analisis: json["analisis"],
        codigoTrampaPadre: json["codigo_trampa_padre"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_padre": idPadre,
        "id_tablet": idTablet,
        "analisis": analisis,
        "codigo_muestra": codigoMuestra,
        "tipo_muestra": tipoMuestra,
        "codigo_trampa_padre": codigoTrampaPadre,
      };

  // @override
  // String toString() {
  //   return ''' TrampasMfSvLaboratorioModelo: {
  //     id : $id
  //     id_padre : $idPadre
  //     id_tablet : $idTablet
  //     analisis : $codigoMuestra
  //     codigo_muestra : $tipoMuestra
  //     tipo_muestra : $analisis
  //     codigo_trampa_padre : $codigoTrampaPadre
  //   }''';
  // }
}
