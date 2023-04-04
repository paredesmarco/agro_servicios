class LocalizacionCatalogoModelo {
  LocalizacionCatalogoModelo({
    this.localizacionCatalogo,
  });

  List<LocalizacionCatalogo>? localizacionCatalogo;

  factory LocalizacionCatalogoModelo.fromJson(Map<String, dynamic> json) =>
      LocalizacionCatalogoModelo(
        localizacionCatalogo: List<LocalizacionCatalogo>.from(
            json["localizacionCatalogo"]
                .map((x) => LocalizacionCatalogo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "localizacionCatalogo":
            List<dynamic>.from(localizacionCatalogo!.map((x) => x.toJson())),
      };
}

class LocalizacionCatalogo {
  LocalizacionCatalogo({
    this.idguia,
    this.codigo,
    this.nombre,
    this.idGuiaPadre,
    this.categoria,
    this.cantonlist,
    this.parroquialist,
  });

  int? idguia;
  String? codigo;
  String? nombre;
  int? idGuiaPadre;
  int? categoria;
  List<LocalizacionCatalogo>? cantonlist;
  List<LocalizacionCatalogo>? parroquialist;

  factory LocalizacionCatalogo.fromJson(Map<String, dynamic> json) =>
      LocalizacionCatalogo(
        idguia: json["idguia"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        idGuiaPadre: json["idguiapadre"],
        categoria: json["categoria"],
        cantonlist: json["cantonlist"] == null
            ? null
            : List<LocalizacionCatalogo>.from(json["cantonlist"]
                .map((x) => LocalizacionCatalogo.fromJson(x))),
        parroquialist: json["parroquialist"] == null
            ? null
            : List<LocalizacionCatalogo>.from(json["parroquialist"]
                .map((x) => LocalizacionCatalogo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idguia": idguia,
        "codigo": codigo,
        "nombre": nombre,
        "idguiapadre": idGuiaPadre,
        "categoria": categoria,
        "cantonlist": cantonlist == null
            ? null
            : List<dynamic>.from(cantonlist!.map((x) => x.toJson())),
        "parroquialist": parroquialist == null
            ? null
            : List<dynamic>.from(parroquialist!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return ''' LocalizacionCatalogo{
    idguia : $idguia
    codigo : $codigo
    nombre : $nombre
    idGuiaPadre : $idGuiaPadre
    categoria : $categoria
    cantonlist : $cantonlist
    parroquialist : $parroquialist
    }
    ''';
  }
}
