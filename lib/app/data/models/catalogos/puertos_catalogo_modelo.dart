class PuertosCatalogoModelo {
  PuertosCatalogoModelo({
    this.idPuerto,
    this.nombre,
    this.lugarinspeccion,
  });

  int? idPuerto;
  String? nombre;
  List<LugarInspeccion>? lugarinspeccion;

  factory PuertosCatalogoModelo.fromJson(Map<String, dynamic> json) =>
      PuertosCatalogoModelo(
        idPuerto: json["id_puerto"],
        nombre: json["nombre"],
        lugarinspeccion: json["lugar_inspeccion"] == null
            ? null
            : List<LugarInspeccion>.from(json["lugar_inspeccion"]
                .map((x) => LugarInspeccion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_puerto": idPuerto,
        "nombre": nombre,
        "lugar_inspeccion": lugarinspeccion == null
            ? null
            : List<dynamic>.from(lugarinspeccion!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return '''
    id_puerto : $idPuerto
    nombre : $nombre
    lugar_inspeccion : $lugarinspeccion
    ''';
  }
}

class LugarInspeccion {
  LugarInspeccion({
    this.nombre,
    this.idPuerto,
  });

  String? nombre;
  int? idPuerto;

  factory LugarInspeccion.fromJson(Map<String, dynamic> json) =>
      LugarInspeccion(
        nombre: json["nombre"],
        idPuerto: json["id_puerto"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "id_puerto": idPuerto,
      };
}
