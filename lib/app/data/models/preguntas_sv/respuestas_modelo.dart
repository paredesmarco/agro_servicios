import 'dart:convert';

RespuestasModelo newResponseFromJson(String str) =>
    RespuestasModelo.fromJson(json.decode(str));

class RespuestasModelo {
  int? id;
  int? idPregunta;
  String? formulario;
  String? tipoArea;
  int? orden;
  String? pregunta;
  int? puntos;
  String? tab;
  String? tipo;
  String? modoVisualizar;
  String? fecha;
  String? estado;
  String? tipoDato;
  String? obligatorio;
  String? opcionesRespuesta;
  String? numeroReporte; //Numero de Reporte del Formulario
  String? respuesta;

  RespuestasModelo({
    this.id,
    this.idPregunta,
    this.formulario,
    this.tipoArea,
    this.orden,
    this.pregunta,
    this.puntos,
    this.tab,
    this.tipo,
    this.modoVisualizar,
    this.fecha,
    this.estado,
    this.tipoDato,
    this.obligatorio,
    this.opcionesRespuesta,
    this.numeroReporte,
    this.respuesta,
  });

  bool _isFavorite = false;
  // ignore: unnecessary_getters_setters
  bool get isFavorite => _isFavorite;
  set isFavorite(bool valor) => _isFavorite = valor;

  factory RespuestasModelo.fromJson(Map<String, dynamic> json) =>
      RespuestasModelo(
          id: json["id"],
          idPregunta: json["id_pregunta"],
          formulario: json["formulario"],
          tipoArea: json["tipo_area"],
          orden: json["orden"],
          pregunta: json["pregunta"],
          puntos: json["puntos"],
          tab: json["tab"],
          tipo: json["tipo"],
          modoVisualizar: json["modo_visualizar"],
          fecha: json["fecha"],
          estado: json["estado"],
          tipoDato: json["tipo_dato"],
          obligatorio: json["obligatorio"],
          opcionesRespuesta: json["opciones_respuesta"],
          numeroReporte: json["numero_reporte"],
          respuesta: json["respuesta"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_pregunta": idPregunta,
        "formulario": formulario,
        "tipo_area": tipoArea,
        "orden": orden,
        "pregunta": pregunta,
        "puntos": puntos,
        "tab": tab,
        "tipo": tipo,
        "modo_visualizar": modoVisualizar,
        "fecha": fecha,
        "estado": estado,
        "tipo_dato": tipoDato,
        "obligatorio": obligatorio,
        "opciones_respuesta": opcionesRespuesta,
        "numero_reporte": numeroReporte,
        "respuesta": respuesta
      };

  // @override
  // String toString() {
  //   return ''' RespuestasModelo{
  //     id : $id,
  //     id_pregunta : $idPregunta,
  //     formulario : $formulario,
  //     tipo_area : $tipoArea,
  //     orden : $orden,
  //     pregunta : $pregunta,
  //     puntos : $puntos,
  //     tab : $tab,
  //     tipo : $tipo,
  //     modo_visualizar:$modoVisualizar
  //     fecha : $fecha,
  //     estado : $estado,
  //     tipo_dato : $tipoDato,
  //     obligatorio : $obligatorio,
  //     numero_reporte : $numeroReporte,
  //     respuesta : $respuesta,

  //     }
  //   ''';
  // }
}
