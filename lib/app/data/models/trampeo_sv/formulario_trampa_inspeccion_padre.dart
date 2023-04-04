class InspeccionPadreModelo {
  InspeccionPadreModelo({
    this.id,
    this.idTablet,
    this.fechaInspeccion,
    this.usuarioId,
    this.usuario,
    this.tabletId,
    this.tabletVersionBase,
  });

  int? id;
  int? idTablet;
  DateTime? fechaInspeccion;
  String? usuarioId;
  String? usuario;
  String? tabletId;
  String? tabletVersionBase;

  factory InspeccionPadreModelo.fromJson(Map<String, dynamic> json) =>
      InspeccionPadreModelo(
        id: json["id"],
        idTablet: json["id_tablet"],
        fechaInspeccion: DateTime.parse(json["fecha_inspeccion"]),
        usuarioId: json["usuario_id"],
        usuario: json["usuario"],
        tabletId: json["tablet_id"],
        tabletVersionBase: json["tablet_version_base"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_tablet": idTablet,
        "fecha_inspeccion": fechaInspeccion!.toIso8601String(),
        "usuario_id": usuarioId,
        "usuario": usuario,
        "tablet_id": tabletId,
        "tablet_version_base": tabletVersionBase,
      };

  @override
  String toString() {
    return '''
      id: $id,
      id_tablet: $idTablet,
      fecha_inspeccion: $fechaInspeccion,
      usuario_id: $usuarioId,
      usuario: $usuario,
      tablet_id: $tabletId,
      tablet_version_base: $tabletVersionBase,
     ''';
  }
}
