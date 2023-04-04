class OrdenLaboratorioSvModelo {
  int? id;
  String? tipoMuestra;
  String? conservacion;
  String? codigoMuestra;
  String? analisisSolicitado;
  int? idVigilancia;

  OrdenLaboratorioSvModelo(
      {this.id,
      this.tipoMuestra,
      this.conservacion,
      this.codigoMuestra,
      this.analisisSolicitado,
      this.idVigilancia});

  void prueba() {}

  factory OrdenLaboratorioSvModelo.fromJson(Map<String, dynamic> json) =>
      OrdenLaboratorioSvModelo(
        id: json['id'],
        tipoMuestra: json['tipoMuestra'],
        conservacion: json['conservacion'],
        codigoMuestra: json['codigoMuestra'],
        analisisSolicitado: json['analisisSolicitado'],
        idVigilancia: json['idVigilancia'],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tipoMuestra": tipoMuestra,
        "conservacion": conservacion,
        "codigoMuestra": codigoMuestra,
        "analisisSolicitado": analisisSolicitado,
        "idVigilancia": idVigilancia
      };

  @override
  String toString() {
    return 'OrdenLaboratorioSvModelo: {id: $id, tipoMuestra: $tipoMuestra, conservacion: $conservacion, codigoMuestra: $codigoMuestra, analisisSolicitado: $analisisSolicitado, idVigilancia: $idVigilancia';
  }
}
