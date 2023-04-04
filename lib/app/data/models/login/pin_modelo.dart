import 'dart:convert';

PinModelo pinModeloFromJson(String str) => PinModelo.fromJson(json.decode(str));

String pinModeloToJson(PinModelo data) => json.encode(data.toJson());

class PinModelo {
  PinModelo({
    this.estado,
    this.mensaje,
    this.cuerpo,
  });

  String? estado;
  String? mensaje;
  List<Cuerpo>? cuerpo;

  factory PinModelo.fromJson(Map<String, dynamic> json) => PinModelo(
        estado: json["estado"],
        mensaje: json["mensaje"],
        cuerpo:
            List<Cuerpo>.from(json["cuerpo"].map((x) => Cuerpo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "estado": estado,
        "mensaje": mensaje,
        "cuerpo": List<dynamic>.from(cuerpo!.map((x) => x.toJson())),
      };
}

class Cuerpo {
  Cuerpo({
    this.idPin,
    this.identificador,
    this.pin,
    this.fechaRegistro,
    this.fechaCaducidad,
  });

  int? idPin;
  String? identificador;
  String? pin;
  DateTime? fechaRegistro;
  DateTime? fechaCaducidad;

  factory Cuerpo.fromJson(Map<String, dynamic> json) => Cuerpo(
        idPin: json["id_pin"],
        identificador: json["identificador"],
        pin: json["pin"],
        fechaRegistro: DateTime.parse(json["fecha_registro"]),
        fechaCaducidad: DateTime.parse(json["fecha_caducidad"]),
      );

  Map<String, dynamic> toJson() => {
        "id_pin": idPin,
        "identificador": identificador,
        "pin": pin,
        "fecha_registro": fechaRegistro!.toIso8601String(),
        "fecha_caducidad": fechaCaducidad!.toIso8601String(),
      };
}
