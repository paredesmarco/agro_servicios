class PaisesOrigenProcedenciaModelo {
  PaisesOrigenProcedenciaModelo({
    this.idLocalizacion,
    this.nombre,
  });

  int? idLocalizacion;
  String? nombre;

  factory PaisesOrigenProcedenciaModelo.fromJson(Map<String, dynamic> json) =>
      PaisesOrigenProcedenciaModelo(
        idLocalizacion: json["id_localizacion"],
        nombre: json["nombre"],
      );

  Map<String, dynamic> toJson() => {
        "id_localizacion": idLocalizacion,
        "nombre": nombre,
      };
}
