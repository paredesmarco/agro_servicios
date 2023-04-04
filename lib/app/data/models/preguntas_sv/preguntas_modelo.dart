import 'dart:convert';

PreguntasModelo newResponseFromJson(String str) =>
    PreguntasModelo.fromJson(json.decode(str));

class PreguntasModelo {
  int? id;
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

  PreguntasModelo({
    this.id,
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
  });

  bool _isFavorite = false;
  // ignore: unnecessary_getters_setters
  bool get isFavorite => _isFavorite;
  set isFavorite(bool valor) => _isFavorite = valor;
  String _respuesta = '';
  // ignore: unnecessary_getters_setters
  String get respuesta => _respuesta;
  set respuesta(String value) => _respuesta = value;

  factory PreguntasModelo.fromJson(Map<String, dynamic> json) =>
      PreguntasModelo(
          id: json["id"],
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
          opcionesRespuesta: json["opciones_respuesta"]);

  Map<String, dynamic> toJson() => {
        "id": id,
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
        "opciones_respuesta": obligatorio == null ? null : opcionesRespuesta
      };

  @override
  String toString() {
    return ''' PreguntasModelo{
      id : $id,
      formulario : $formulario,
      tipo_area : $tipoArea,
      orden : $orden,
      pregunta : $pregunta,
      puntos : $puntos,
      tab : $tab,
      tipo : $tipo,
      modo_visualizar:$modoVisualizar
      fecha : $fecha,
      estado : $estado,
      tipo_dato : $tipoDato,
      obligatorio : $obligatorio,
      opciones_respuesta : $opcionesRespuesta,
      }
    ''';
  }
}
