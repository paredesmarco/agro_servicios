class ProductosTransitoModelo {
  ProductosTransitoModelo({
    this.partidaArancelaria,
    this.nombre,
    this.subtipo,
  });

  String? partidaArancelaria;
  String? nombre;
  String? subtipo;

  factory ProductosTransitoModelo.fromJson(Map<String, dynamic> json) =>
      ProductosTransitoModelo(
        partidaArancelaria: json["partida_arancelaria"],
        nombre: json["nombre"],
        subtipo: json["subtipo"],
      );

  Map<String, dynamic> toJson() => {
        "partida_arancelaria": partidaArancelaria,
        "nombre": nombre,
        "subtipo": subtipo,
      };
}
