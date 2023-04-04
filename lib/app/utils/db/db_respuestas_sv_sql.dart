class DBRespuestasSvSql {
  static List<String> script = [_formularioAreas, _formularioRespuestas];
  static List<String> scriptDrop = [
    _dropFormularioRespuestas,
    _dropFormularioAreas,
  ];
  static List<String> scriptDelete = [
    _deleteFormularioRespuestas,
    _deleteFormularioAreas
  ];

  static const _dropFormularioRespuestas =
      'DROP TABLE IF EXISTS formulario_respuestas_sv;';
  static const _dropFormularioAreas =
      'DROP TABLE IF EXISTS formulario_areas_sv;';

  static const _deleteFormularioRespuestas =
      'DELETE TABLE formulario_respuestas_sv;';
  static const _deleteFormularioAreas = 'DELETE TABLE formulario_areas_sv;';

  static const _formularioAreas =
      '''CREATE TABLE IF NOT EXISTS  formulario_areas_sv(
      id INTEGER PRIMARY KEY,
      formulario TEXT,
      numero_reporte TEXT,
      id_area INTEGER
      ); ''';

  static const _formularioRespuestas =
      '''CREATE TABLE IF NOT EXISTS  formulario_respuestas_sv (
      id INTEGER  PRIMARY KEY,
      id_pregunta INTEGER,
      formulario TEXT,
      tipo_area TEXT,
      orden INTEGER,
      pregunta TEXT,
      puntos INTEGER,
      tab  TEXT,
      tipo  TEXT,
      modo_visualizar  TEXT,
      fecha TEXT,
      estado TEXT,
      tipo_dato TEXT,
      obligatorio TEXT,
      opciones_respuesta  TEXT,
      numero_reporte TEXT,
      respuesta TEXT,
      switchr INTEGER
      ); ''';
}
