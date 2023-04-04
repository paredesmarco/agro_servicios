import 'dart:convert';

import 'package:agro_servicios/app/common/comunes.dart';
import 'package:agro_servicios/app/data/models/token/token_modelo.dart';

IngresoUsuarioModelo ingresoUsuarioModeloFromJson(String str) =>
    IngresoUsuarioModelo.fromJson(json.decode(str));

String ingresoUsuarioModeloToJson(IngresoUsuarioModelo data) =>
    json.encode(data.toJson());

class IngresoUsuarioModelo {
  IngresoUsuarioModelo({
    this.estado,
    this.mensaje,
    this.cuerpo,
    this.token,
  });

  String? estado;
  String? mensaje;
  List<Cuerpo>? cuerpo;
  TokenModelo? token;

  factory IngresoUsuarioModelo.fromJson(Map<String, dynamic> json) =>
      IngresoUsuarioModelo(
        estado: json["estado"],
        mensaje: json["mensaje"],
        cuerpo:
            List<Cuerpo>.from(json["cuerpo"].map((x) => Cuerpo.fromJson(x))),
        token:
            json["token"] != null ? TokenModelo.fromJson(json["token"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "mensaje": mensaje,
        "cuerpo": List<dynamic>.from(cuerpo!.map((x) => x.toJson())),
        "token": token?.toJson(),
      };

  @override
  String toString() {
    return ''' IngresoUsuarioModelo{
      estado :  $estado,
      mensaje : $mensaje,
      cuerpo :  $cuerpo,
      token :  $token
    }
    ''';
  }
}

class Cuerpo {
  Cuerpo({
    this.identificador,
    this.clave,
    this.estado,
    this.nombre,
    this.fotografia,
    this.tipo,
  });

  String? identificador;
  String? clave;
  int? estado;
  String? nombre;
  String? fotografia;
  String? tipo;

  factory Cuerpo.fromJson(Map<String, dynamic> json) => Cuerpo(
        identificador: json["identificador"],
        clave: json["clave"],
        estado: json["estado"],
        nombre: json["nombre"],
        fotografia: json["fotografia"] == null
            ? null
            : '$URL_SERVIDOR/$NOMBRE_PROYECTO/${json["fotografia"]}',
        tipo: json["tipo"],
      );

  Map<String, dynamic> toJson() => {
        "identificador": identificador,
        "clave": clave,
        "estado": estado,
        "nombre": nombre,
        "fotografia": fotografia,
        "tipo": tipo,
      };
}
