import 'dart:convert';

List<LocalizacionModelo> localizacionModeloFromJson(String str) =>
    List<LocalizacionModelo>.from(
        json.decode(str).map((x) => LocalizacionModelo.fromJson(x)));

String localizacionModeloToJson(List<LocalizacionModelo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LocalizacionModelo {
  LocalizacionModelo({
    this.idGuia,
    this.codigo,
    this.nombre,
    this.idGuiaPadre,
    this.categoria,
  });

  int? idGuia;
  String? codigo;
  String? nombre;
  int? idGuiaPadre;
  int? categoria;

  factory LocalizacionModelo.fromJson(Map<String, dynamic> json) =>
      LocalizacionModelo(
        idGuia: json["id_localizacion"],
        codigo: json["codigo"],
        nombre: json["nombre"],
        idGuiaPadre: json["id_localizacion_padre"],
        categoria: json["categoria"],
      );

  Map<String, dynamic> toJson() => {
        "id_localizacion": idGuia,
        "codigo": codigo,
        "nombre": nombre,
        "id_localizacion_padre": idGuiaPadre,
        "categoria": categoria,
      };
}
