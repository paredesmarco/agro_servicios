import 'dart:convert';

List<AreaAplicacionModelo> areaAplicacionModeloFromJson(String str) =>
    List<AreaAplicacionModelo>.from(
        json.decode(str).map((x) => AreaAplicacionModelo.fromJson(x)));

String areaAplicacionModeloToJson(List<AreaAplicacionModelo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AreaAplicacionModelo {
  AreaAplicacionModelo({
    this.area,
    this.aplicacion,
  });

  String? area;
  List<Aplicacion>? aplicacion;

  factory AreaAplicacionModelo.fromJson(Map<String, dynamic> json) =>
      AreaAplicacionModelo(
        area: json["area"],
        aplicacion: List<Aplicacion>.from(
            json["aplicacion"].map((x) => Aplicacion.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "aplicacion": List<dynamic>.from(aplicacion!.map((x) => x.toJson())),
      };
}

class Aplicacion {
  Aplicacion({
    this.id,
    this.nombre,
    this.version,
    this.descripcion,
    this.colorInicio,
    this.colorFin,
    this.codificacionAplicacion,
    this.estadoAplicacion,
    this.idArea,
  });

  int? id;
  String? nombre;
  String? version;
  String? descripcion;
  String? colorInicio;
  String? colorFin;
  String? codificacionAplicacion;
  String? estadoAplicacion;
  String? idArea;

  factory Aplicacion.fromJson(Map<String, dynamic> json) => Aplicacion(
        id: json["id"],
        nombre: json["nombre"],
        version: json["version"],
        descripcion: json["descripcion"],
        colorInicio: json["color_inicio"],
        colorFin: json["color_fin"],
        codificacionAplicacion: json["codificacion_aplicacion"],
        estadoAplicacion: json["estado_aplicacion"],
        idArea: json["id_area"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "version": version,
        "descripcion": descripcion,
        "color_inicio": colorInicio,
        "color_fin": colorFin,
        "codificacion_aplicacion": codificacionAplicacion,
        "estado_aplicacion": estadoAplicacion,
        "id_area": idArea,
      };
}
