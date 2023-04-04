import 'dart:convert';

PonderacionModelo newResponseFromJson(String str) =>
    PonderacionModelo.fromJson(json.decode(str));

class PonderacionModelo {
  int? id;
  String? formulario;
  String? tipoArea;
  String? resultado;
  int? rinicial;
  int? rfinal;
  String? fecha;

  PonderacionModelo({
    this.id,
    this.formulario,
    this.tipoArea,
    this.resultado,
    this.rinicial,
    this.rfinal,
    this.fecha,
  });

  factory PonderacionModelo.fromJson(Map<String, dynamic> json) =>
      PonderacionModelo(
        id: json["id"],
        formulario: json["formulario"],
        tipoArea: json["tipo_area"],
        resultado: json["resultado"],
        rinicial: json["rinicial"],
        rfinal: json["rfinal"],
        fecha: json["fecha"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "formulario": formulario,
        "tipo_area": tipoArea,
        "resultado": resultado,
        "rinicial": rinicial,
        "rfinal": rfinal,
        "fecha": fecha,
      };

  @override
  String toString() {
    return ''' PonderacionModelo{
      id : $id,
      formulario : $formulario,
      tipo_area : $tipoArea,
      resultado : $resultado,
      rinicial : $rinicial,
      rfinal : $rfinal,
      fecha : $fecha,
      }
    ''';
  }
}
