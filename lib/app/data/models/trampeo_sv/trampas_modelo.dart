// To parse this JSON data, do
//
//     final trampasModelo = trampasModeloFromJson(jsonString);

import 'dart:convert';

TrampasModelo trampasModeloFromJson(String str) =>
    TrampasModelo.fromJson(json.decode(str));

String trampasModeloToJson(TrampasModelo data) => json.encode(data.toJson());

class TrampasModelo {
  TrampasModelo({
    this.cuerpo,
  });

  List<Trampas>? cuerpo;

  factory TrampasModelo.fromJson(Map<String, dynamic> json) => TrampasModelo(
        cuerpo:
            List<Trampas>.from(json["cuerpo"].map((x) => Trampas.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cuerpo": List<dynamic>.from(cuerpo!.map((x) => x.toJson())),
      };
}

class Trampas {
  Trampas({
    this.idTrampa,
    this.idprovincia,
    this.provincia,
    this.idcanton,
    this.canton,
    this.idparroquia,
    this.parroquia,
    this.idlugarinstalacion,
    this.lugarinstalacion,
    this.numerolugarinstalacion,
    this.tipotrampa,
    this.codigotrampa,
    this.coordenadax,
    this.coordenaday,
    this.coordenadaz,
    this.fechainstalacion,
    this.estadotrampa,
    this.nombreplaga,
    this.secuencialOrden,
    this.utilizado,
    this.actualizado,
    this.activo,
    this.fechaInspeccion,
  });

  final int? idTrampa;
  final int? idprovincia;
  final String? provincia;
  final int? idcanton;
  final String? canton;
  final int? idparroquia;
  final String? parroquia;
  final int? idlugarinstalacion;
  final String? lugarinstalacion;
  final String? numerolugarinstalacion;
  final String? tipotrampa;
  final String? codigotrampa;
  final String? coordenadax;
  final String? coordenaday;
  final String? coordenadaz;
  final DateTime? fechainstalacion;
  String? estadotrampa;
  final String? nombreplaga;
  final int? secuencialOrden;
  final String? fechaInspeccion;
  int? utilizado;
  bool? actualizado = false;
  bool? activo = true;
  bool llenado = false;

  factory Trampas.fromJson(Map<String, dynamic> json) => Trampas(
        idTrampa: json["idTrampa"],
        idprovincia: json["idprovincia"],
        provincia: json["provincia"],
        idcanton: json["idcanton"],
        canton: json["canton"],
        idparroquia: json["idparroquia"],
        parroquia: json["parroquia"],
        idlugarinstalacion: json["idlugarinstalacion"],
        lugarinstalacion: json["lugarinstalacion"],
        numerolugarinstalacion: json["numerolugarinstalacion"].toString(),
        tipotrampa: json["tipotrampa"],
        codigotrampa: json["codigotrampa"],
        coordenadax: json["coordenadax"],
        coordenaday: json["coordenaday"],
        coordenadaz: json["coordenadaz"],
        fechainstalacion: DateTime.parse(json["fechainstalacion"]),
        estadotrampa: json["estadotrampa"],
        nombreplaga: json["nombreplaga"],
        secuencialOrden: json["secuencialorden"] ?? 0,
        fechaInspeccion: json["fecha_inspeccion"],
        utilizado: json["utilizado"] ?? 0,
        activo: true,
      );

  Map<String, dynamic> toJson() => {
        "idTrampa": idTrampa,
        "idprovincia": idprovincia,
        "provincia": provincia,
        "idcanton": idcanton,
        "canton": canton,
        "idparroquia": idparroquia,
        "parroquia": parroquia,
        "idlugarinstalacion": idlugarinstalacion,
        "lugarinstalacion": lugarinstalacion,
        "numerolugarinstalacion": numerolugarinstalacion,
        "tipotrampa": tipotrampa,
        "codigotrampa": codigotrampa,
        "coordenadax": coordenadax,
        "coordenaday": coordenaday,
        "coordenadaz": coordenadaz,
        "fechainstalacion":
            "${fechainstalacion!.year.toString().padLeft(4, '0')}-${fechainstalacion!.month.toString().padLeft(2, '0')}-${fechainstalacion!.day.toString().padLeft(2, '0')}",
        "estadotrampa": estadotrampa,
        "nombreplaga": nombreplaga,
        "secuencialOrden": secuencialOrden,
        "fecha_inspeccion": fechaInspeccion,
        //"${fechaInspeccion.year.toString().padLeft(4, '0')}-${fechaInspeccion.month.toString().padLeft(2, '0')}-${fechaInspeccion.day.toString().padLeft(2, '0')}",
        "utilizado": utilizado,
      };
}
