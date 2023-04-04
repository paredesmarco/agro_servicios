import 'dart:convert';

RespuestasAreasModelo newResponseFromJson(String str) =>
    RespuestasAreasModelo.fromJson(json.decode(str));

class RespuestasAreasModelo {
  int? id; //id Local
  String? formulario; //Id tipo FOrmulario
  String? numeroReporte; //Numero de Reporte del Formulario
  int? idArea; //aplicado a las multiples Areas

  RespuestasAreasModelo({
    this.id,
    this.formulario,
    this.numeroReporte,
    this.idArea,
  });

  factory RespuestasAreasModelo.fromJson(Map<String, dynamic> json) =>
      RespuestasAreasModelo(
        id: json["id"],
        formulario: json["formulario"],
        numeroReporte: json["numero_reporte"],
        idArea: json["id_area"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "formulario": formulario,
        "numero_reporte": numeroReporte,
        "id_area": idArea,
      };

  // @override
  // String toString() {
  //   return ''' RespuestasAreasModelo{
  //     id : $id,
  //     formulario : $formulario,
  //     numeroReporte : $numeroReporte,
  //     idArea : $idArea,
  //     }
  //   ''';
  // }
}
