import 'dart:convert';

AplicacionesModelo newResponseFromJson(String str) =>
    AplicacionesModelo.fromJson(json.decode(str));

class AplicacionesModelo {
  int? id;
  String? nombre;
  String? version;
  String? descripcion;
  String? colorInicio;
  String? colorFin;
  String? codificacionAplicacion;
  String? estadoAplicacion;
  String? idArea;
  String? vista;
  int? orden;

  AplicacionesModelo(
    this.id,
    this.nombre,
    this.version,
    this.descripcion,
    this.colorInicio,
    this.colorFin,
    this.codificacionAplicacion,
    this.estadoAplicacion,
    this.idArea,
    this.vista,
    this.orden,
  );

  AplicacionesModelo.fromJson(Map<String, dynamic> json) {
    id = json['id_aplicacion'];
    nombre = json['nombre'];
    version = json['version'];
    descripcion = json['descripcion'];
    colorInicio = json['color_inicio'];
    colorFin = json['color_fin'];
    codificacionAplicacion = json['codificacion_aplicacion'];
    estadoAplicacion = json['estado_aplicacion'];
    idArea = json['id_area'];
    vista = json['vista'];
    orden = json['orden'];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'nombre': nombre,
        'version': version,
        'descripcion': descripcion,
        'color_inicio': colorInicio,
        'color_fin': colorFin,
        'codificacion_aplicacion': codificacionAplicacion,
        'estado_aplicacion': estadoAplicacion,
        'id_area': idArea,
        'vista': vista,
        'orden': orden,
      };
}
