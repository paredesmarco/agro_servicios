class AreasModelo {
  AreasModelo({
    this.id,
    this.idArea,
    this.nombre,
    this.nombreCorto,
    this.idAreaPadre,
    this.areas,
  });

  int? id;
  String? idArea;
  String? nombre;
  String? nombreCorto;
  String? idAreaPadre;
  List<AreasModelo>? areas;
  bool seleccionado = false;

  factory AreasModelo.fromJson(Map<String, dynamic> json) => AreasModelo(
        id: json["id"],
        idArea: json["id_area"],
        nombre: json["nombre"],
        nombreCorto: json["nombre_corto"],
        idAreaPadre: json["id_area_padre"],
        areas: json["areas"] == null
            ? null
            : List<AreasModelo>.from(
                json["areas"].map((x) => AreasModelo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_area": idArea,
        "nombre": nombre,
        "nombre_corto": nombreCorto,
        "id_area_padre": idAreaPadre,
      };
}
